# -*- coding: utf-8 -*-
"""Aplica um patch .xdelta (VCDIFF) sem precisar do xdelta3 instalado.

Existe por causa do Steam Deck: o SteamOS nao traz xdelta3 e o sistema e'
somente leitura, mas Python 3 esta' sempre la'. No Windows o instalador usa o
xdelta3.exe que vem junto, que e' mais rapido; este script e' o plano B.

Implementa o VCDIFF da RFC 3284 com a tabela de codigos padrao. Os deltas
desta traducao sao gerados sem compressao secundaria, entao nao ha' Huffman
para decodificar aqui.

Uso:
    python aplicar_delta.py <original> <delta> <saida>
"""
import struct
import sys
from pathlib import Path

VCD_SOURCE = 1
VCD_TARGET = 2
VCD_ADLER32 = 4

RUN, ADD, COPY, NOOP = 0, 1, 2, 3


def _tabela_padrao():
    """A tabela de codigos padrao da RFC 3284, secao 5.4."""
    t = []
    t.append(((RUN, 0, 0), (NOOP, 0, 0)))
    for tam in range(0, 18):
        t.append(((ADD, tam, 0), (NOOP, 0, 0)))
    for modo in range(9):
        t.append(((COPY, 0, modo), (NOOP, 0, 0)))
        for tam in range(4, 19):
            t.append(((COPY, tam, modo), (NOOP, 0, 0)))
    for modo in range(6):
        for tam_add in range(1, 5):
            for tam_copy in range(4, 7):
                t.append(((ADD, tam_add, 0), (COPY, tam_copy, modo)))
    for modo in range(6, 9):
        for tam_add in range(1, 5):
            t.append(((ADD, tam_add, 0), (COPY, 4, modo)))
    for modo in range(9):
        t.append(((COPY, 4, modo), (ADD, 1, 0)))
    assert len(t) == 256, len(t)
    return t


TABELA = _tabela_padrao()


class Cache:
    """O cache de enderecos do VCDIFF: 4 posicoes 'near' e 3 'same'."""

    NEAR, SAME = 4, 3

    def __init__(self):
        self.near = [0] * self.NEAR
        self.same = [0] * (self.SAME * 256)
        self.proximo = 0

    def endereco(self, aqui, modo, ler_inteiro, ler_byte):
        if modo == 0:
            end = ler_inteiro()
        elif modo == 1:
            end = aqui - ler_inteiro()
        elif modo < 2 + self.NEAR:
            end = self.near[modo - 2] + ler_inteiro()
        else:
            m = modo - (2 + self.NEAR)
            end = self.same[m * 256 + ler_byte()]
        self.atualizar(end)
        return end

    def atualizar(self, end):
        self.near[self.proximo] = end
        self.proximo = (self.proximo + 1) % self.NEAR
        self.same[end % (self.SAME * 256)] = end


class Fluxo:
    """Leitor de bytes com os inteiros de tamanho variavel do VCDIFF."""

    def __init__(self, dados, pos=0):
        self.d = dados
        self.pos = pos

    def byte(self):
        b = self.d[self.pos]
        self.pos += 1
        return b

    def inteiro(self):
        valor = 0
        while True:
            b = self.byte()
            valor = (valor << 7) | (b & 0x7F)
            if not b & 0x80:
                return valor

    def bytes(self, n):
        pedaco = self.d[self.pos:self.pos + n]
        self.pos += n
        return pedaco


def aplicar(caminho_origem, caminho_delta, caminho_saida):
    delta = Path(caminho_delta).read_bytes()
    f = Fluxo(delta)
    if f.bytes(3) != b"\xd6\xc3\xc4":
        raise ValueError("nao e' um arquivo VCDIFF")
    f.byte()                       # versao
    indicador = f.byte()
    if indicador & 0x01:           # VCD_DECOMPRESS
        raise ValueError("delta usa compressao secundaria; nao suportado")
    if indicador & 0x02:           # VCD_CODETABLE
        raise ValueError("delta usa tabela de codigos propria; nao suportado")
    if indicador & 0x04:           # VCD_APPHEADER
        f.bytes(f.inteiro())       # o xdelta3 guarda os nomes de arquivo aqui

    origem = open(caminho_origem, "rb")
    saida = open(caminho_saida, "w+b")
    escrito = 0
    try:
        while f.pos < len(delta):
            win = f.byte()
            if win & (VCD_SOURCE | VCD_TARGET):
                tam_fonte = f.inteiro()
                pos_fonte = f.inteiro()
                de_onde = origem if win & VCD_SOURCE else saida
                guardado = saida.tell()
                de_onde.seek(pos_fonte)
                fonte = de_onde.read(tam_fonte)
                saida.seek(guardado)
            else:
                fonte = b""
            f.inteiro()                     # tamanho do bloco de delta
            tam_alvo = f.inteiro()
            if f.byte():
                raise ValueError("janela comprimida; nao suportado")
            tam_dados = f.inteiro()
            tam_instr = f.inteiro()
            tam_ends = f.inteiro()
            if win & VCD_ADLER32:
                # extensao do xdelta3, fora da RFC: um adler32 da janela alvo,
                # 4 bytes em big-endian, logo antes das secoes
                f.bytes(4)
            dados = Fluxo(f.bytes(tam_dados))
            instr = Fluxo(f.bytes(tam_instr))
            ends = Fluxo(f.bytes(tam_ends))

            alvo = bytearray()
            cache = Cache()
            while len(alvo) < tam_alvo:
                for tipo, tam, modo in TABELA[instr.byte()]:
                    if tipo == NOOP:
                        continue
                    if tam == 0:
                        tam = instr.inteiro()
                    if tipo == ADD:
                        alvo += dados.bytes(tam)
                    elif tipo == RUN:
                        alvo += dados.bytes(1) * tam
                    else:
                        aqui = len(fonte) + len(alvo)
                        end = cache.endereco(aqui, modo, ends.inteiro, ends.byte)
                        for _ in range(tam):
                            if end < len(fonte):
                                alvo.append(fonte[end])
                            else:
                                alvo.append(alvo[end - len(fonte)])
                            end += 1
            saida.seek(escrito)
            saida.write(alvo)
            escrito += len(alvo)
    finally:
        origem.close()
        saida.close()
    return escrito


if __name__ == "__main__":
    if len(sys.argv) != 4:
        sys.exit(__doc__)
    n = aplicar(*sys.argv[1:4])
    print(f"{n:,d} bytes escritos em {sys.argv[3]}")

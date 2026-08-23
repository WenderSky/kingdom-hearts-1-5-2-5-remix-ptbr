#!/bin/bash
# Instalador da traducao PT-BR de KINGDOM HEARTS HD 1.5+2.5 ReMIX - Steam Deck
#
# O SteamOS nao traz xdelta3 e o sistema e' somente leitura, entao usamos o
# aplicar_delta.py, que so' precisa do Python 3 (que ja' vem no Deck).
set -u

BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DESINSTALAR=0
MANTER_BACKUP=0
JOGO=""

while [ $# -gt 0 ]; do
  case "$1" in
    --desinstalar) DESINSTALAR=1 ;;
    --manter-backup) MANTER_BACKUP=1 ;;
    --jogo) shift; JOGO="$1" ;;
    *) echo "opcao desconhecida: $1"; exit 1 ;;
  esac
  shift
done

azul()    { printf '\033[36m%s\033[0m\n' "$1"; }
verde()   { printf '\033[32m%s\033[0m\n' "$1"; }
amarelo() { printf '\033[33m%s\033[0m\n' "$1"; }
vermelho(){ printf '\033[31m%s\033[0m\n' "$1"; }

echo
amarelo "  KINGDOM HEARTS HD 1.5+2.5 ReMIX - Traducao PT-BR"
echo    "  Traducao de Wender_sky"

if ! command -v python3 >/dev/null 2>&1; then
  vermelho "  Precisa do python3, e nao achei nenhum."
  exit 1
fi

NOME="KINGDOM HEARTS -HD 1.5+2.5 ReMIX-"
if [ -z "$JOGO" ]; then
  for b in "$HOME/.local/share/Steam/steamapps/common" \
           "$HOME/.steam/steam/steamapps/common" \
           /run/media/mmcblk0p1/steamapps/common \
           /run/media/deck/*/steamapps/common; do
    if [ -d "$b/$NOME/Image" ]; then JOGO="$b/$NOME"; break; fi
  done
fi
if [ -z "$JOGO" ] || [ ! -d "$JOGO/Image" ]; then
  vermelho "  Nao achei o jogo."
  echo    "  Rode assim:  ./instalar.sh --jogo \"/caminho/do/$NOME\""
  exit 1
fi
echo "  jogo: $JOGO"
echo

python3 - "$BASE" "$JOGO" "$DESINSTALAR" "$MANTER_BACKUP" <<'PYEOF'
import hashlib, json, os, sys, shutil
sys.path.insert(0, sys.argv[1])
from aplicar_delta import aplicar

base, jogo = sys.argv[1], sys.argv[2]
desinstalar, manter_backup = sys.argv[3] == "1", sys.argv[4] == "1"
manifesto = json.load(open(os.path.join(base, "manifesto.json"), encoding="utf-8"))
imagem = os.path.join(jogo, "Image")
print(f"  versao {manifesto['versao']}\n")

def sha(p, algoritmo=hashlib.sha256, bloco=1 << 22):
    h = algoritmo()
    with open(p, "rb") as f:
        while (pedaco := f.read(bloco)):
            h.update(pedaco)
    return h.hexdigest()


def _varint(b, i):
    r = s = 0
    while True:
        x = b[i]; i += 1
        r |= (x & 0x7F) << s; s += 7
        if not x & 0x80:
            return r, i


def depot_entrada(destino):
    """Tamanho e SHA-1 de fabrica, lidos do manifesto de deposito da Steam.

    O `depotcache/2552433_*.manifest` e' protobuf: depois do nome do arquivo
    vem tamanho (campo 2) e o SHA-1 do conteudo (campo 5). E' o que separa
    "voce mexeu no arquivo" de "seu jogo e' de outra versao"."""
    import glob
    for raiz in (os.path.expanduser("~/.local/share/Steam"),
                 os.path.expanduser("~/.steam/steam")):
        arquivos = sorted(glob.glob(os.path.join(raiz, "depotcache",
                                                 "2552433_*.manifest")))
        if not arquivos:
            continue
        try:
            d = open(arquivos[-1], "rb").read()
        except OSError:
            continue
        nome = ("Image\\" + destino.replace("/", "\\")).encode()
        i = d.find(nome)
        if i < 0:
            continue
        j = i + len(nome)
        campos = {}
        while j < len(d):
            chave, j = _varint(d, j)
            campo, tipo = chave >> 3, chave & 7
            if campo > 6 or campo in campos:
                break
            if tipo == 0:
                campos[campo], j = _varint(d, j)
            elif tipo == 2:
                ln, j = _varint(d, j)
                if ln == 20:
                    campos[campo] = d[j:j + 20].hex()
                j += ln
            else:
                break
            if campo == 5:
                break
        if 2 in campos:
            return {"tamanho": campos[2], "sha1": campos.get(5)}
    return None

if desinstalar:
    n = 0
    for a in manifesto["arquivos"]:
        alvo = os.path.join(imagem, a["destino"])
        bkp = alvo + ".original"
        if os.path.exists(bkp):
            os.replace(bkp, alvo)
            print(f"  restaurado  {a['destino']}")
            n += 1
    if n:
        print(f"\n  {n} arquivos restaurados. O jogo voltou ao original.")
    else:
        print("\n  Nao ha' backup guardado - a instalacao apaga os originais")
        print("  depois de conferir, para nao ocupar 10 GB a' toa.")
        print("\n  Para voltar ao jogo original, va' na Steam:")
        print("    Propriedades > Arquivos instalados >")
        print("    Verificar integridade dos arquivos")
    sys.exit(0)

fazer = []
for a in manifesto["arquivos"]:
    alvo = os.path.join(imagem, a["destino"])
    if not os.path.exists(alvo):
        sys.exit(f"  FALTA {a['destino']} - o jogo esta' completo?")
    h = sha(alvo)
    if h == a["sha256_traduzido"]:
        print(f"  ja' traduzido  {a['destino']}")
        continue
    if h == a["sha256_original"]:
        fazer.append((a, alvo, alvo)); continue
    bkp = alvo + ".original"
    if os.path.exists(bkp) and sha(bkp) == a["sha256_original"]:
        fazer.append((a, alvo, bkp)); continue
    # ...ou o jogador tem uma VERSAO ANTERIOR desta traducao instalada: o
    # arquivo dele nao e' o de fabrica nem o desta versao, e sem isto a unica
    # saida seria rebaixar o jogo inteiro pela Steam
    atualizacao = next((v for v in a.get("atualizacoes", [])
                        if v.get("de") == h), None)
    if atualizacao:
        print(f"  atualizando da v{atualizacao['versao']}  {a['destino']}")
        fazer.append((dict(a, delta=atualizacao["delta"]), alvo, alvo))
        continue
    # o tamanho ja' separa "download pela metade" de "conteudo trocado"; o
    # manifesto de deposito da Steam (depotcache) separa "voce mexeu no
    # arquivo" de "seu jogo e' de outra versao" -- ver o instalar.ps1
    tam = os.path.getsize(alvo)
    linhas = [f"  DIFERENTE {a['destino']} - nao e' o original nem o traduzido."]
    if tam < a["bytes_original"]:
        linhas.append(f"  Tem {tam:,} bytes e o de fabrica tem "
                      f"{a['bytes_original']:,}: esta' INCOMPLETO.")
        linhas.append("  O download da Steam nao terminou, ou faltou espaco.")
    elif tam != a["bytes_original"]:
        linhas.append(f"  Tem {tam:,} bytes e o de fabrica tem "
                      f"{a['bytes_original']:,}.")
    else:
        linhas.append("  O tamanho e' o de fabrica; o conteudo e' que nao e'.")
    d = depot_entrada(a["destino"])
    if d and d["tamanho"] != a["bytes_original"]:
        linhas.append(f"  A Steam diz que o original tem {d['tamanho']:,} bytes"
                      " nesta maquina:")
        linhas.append("  seu jogo esta' numa VERSAO diferente da que este patch"
                      " conhece.")
        linhas.append("  Avise o autor da traducao.")
        sys.exit("\n".join(linhas))
    if d and d["sha1"] and sha(alvo, hashlib.sha1) == d["sha1"]:
        linhas.append("  Mas a Steam diz que ELE E' o arquivo de fabrica -"
                      " o errado esta' no patch.")
        linhas.append("  Avise o autor da traducao.")
        sys.exit("\n".join(linhas))
    linhas.append("")
    linhas.append("  Como consertar:")
    linhas.append(f"    1. apague o arquivo: {alvo}")
    linhas.append("    2. Steam > Propriedades do jogo > Arquivos instalados >")
    linhas.append("       Verificar integridade (a Steam rebaixa so' ele)")
    linhas.append("    3. rode este instalador de novo")
    linhas.append("  Se tem outro mod ou traducao instalada, remova antes.")
    sys.exit("\n".join(linhas))

if not fazer:
    print("\n  A traducao ja' esta' instalada.")
    print("  Lembre: o idioma do jogo tem de estar em INGLES.")
    sys.exit(0)

livre = shutil.disk_usage(imagem).free
# o original de cada arquivo so' fica no disco enquanto o novo e' escrito e
# conferido, entao o pico e' o maior arquivo - nao a soma de todos
tamanhos = [a["bytes_original"] for a, _, _ in fazer]
precisa = sum(tamanhos) if manter_backup else max(tamanhos)
print(f"\n  aplicando {len(fazer)} arquivos "
      f"(precisa de {precisa/2**30:.1f} GB, livre {livre/2**30:.1f} GB)")
if livre < precisa * 1.1:
    sys.exit("  Espaco insuficiente. Libere espaco e tente de novo.")
print("  isto leva alguns minutos - o arquivo maior tem 3 GB")

for a, alvo, fonte in fazer:
    if fonte == alvo:
        os.replace(alvo, alvo + ".original")
        fonte = alvo + ".original"
    aplicar(fonte, os.path.join(base, "patch", a["delta"]), alvo)
    if sha(alvo) != a["sha256_traduzido"]:
        os.remove(alvo)
        os.replace(fonte, alvo)
        sys.exit(f"  ERRO: {a['destino']} saiu diferente do esperado.")
    # o hash conferiu: o original ja' nao serve para nada
    if not manter_backup and os.path.exists(fonte) and fonte != alvo:
        os.remove(fonte)
    print(f"  ok          {a['destino']}")

print("\n  Pronto! A traducao foi instalada.")
print("  IMPORTANTE: abra o jogo e deixe o idioma em INGLES.")
if not manter_backup:
    print("\n  Para desfazer, use 'Verificar integridade dos arquivos'")
    print("  nas propriedades do jogo na Steam.")
PYEOF

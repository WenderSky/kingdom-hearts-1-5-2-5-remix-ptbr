# v1.6 — a tradução assinada

Esta versão não corrige nada: ela **assina** a tradução. Em vez de um arquivo
LEIA-ME que ninguém abre, o crédito passa a aparecer dentro do jogo, na
mesma fonte e com o mesmo contorno da arte original.

## ✍️ O crédito no menu da coletânea

O painel do menu tem um logotipo que fica sempre no mesmo lugar e só troca o
fundo conforme o jogo escolhido. Embaixo dele entrou **Tradução -
Wender_sky**, nas **seis** telas (KH Final Mix, Re:CoM, Days, KH2, BbS e
Re:coded).

São seis arquivos porque o painel é uma imagem inteira por jogo, não um
recorte reaproveitado — e o `Disney / SQUARE ENIX` do rodapé muda de cor
conforme o fundo, então a assinatura acompanha.

Os menus dos dois filmes (**Days** e **Re:coded**) receberam o mesmo
tratamento.

## ✍️ O `DEVELOPED BY SQUARE ENIX` das telas iniciais

Nas telas de título, o bloco `DEVELOPED BY / SQUARE ENIX` virou **TRADUÇÃO
POR / WENDER_SKY**, redesenhado glifo a glifo com a fonte de menu do próprio
jogo — inclusive o `Ç` e o `Ã`, que não existem na fonte original e foram
montados a partir dos traços dela.

Entrou em **quatro** dos seis: **KINGDOM HEARTS Final Mix**, **358/2 Days**,
**Re:coded** e **Birth by Sleep Final Mix**.

### O que ficou de fora, e por quê

No **KINGDOM HEARTS II** e no **Re:Chain of Memories** o crédito aparece com
teclado mas volta a `DEVELOPED BY SQUARE ENIX` assim que o jogo detecta um
controle: a tela inteira — rótulos, ícones e o bloco — vem de um atlas
diferente, e esse atlas não foi encontrado.

A busca não foi por tentativa: varrendo o conteúdo (procurando a mancha de
tinta do bloco em qualquer posição de qualquer textura), o `kh2_first` tem
**23** imagens com ele e as 23 estão assinadas; `kh2_second`, `kh2_third`,
`kh2_fourth` e `kh2_sixth` não têm nenhuma; no Re:CoM são **15** (três
`FORM` vezes cinco idiomas) e as 15 foram assinadas. Ainda assim volta. A
camada PS2 foi desembaralhada e conferida — o bloco também não está lá.

Como assinar sem achar o alvo só aumentaria o risco à toa, **os dois foram
devolvidos ao estado da v1.5**, byte a byte. A tradução deles continua
inteira; o que não entrou foi só o crédito.

## 📦 O que muda no seu jogo

| Arquivo | O que ganhou |
|---|---|
| `Mare.pkg` | as seis telas do menu e os dois filmes |
| `kh1_first` | a tela inicial do KINGDOM HEARTS Final Mix |
| `bbs_first`, `bbs_third` | a tela inicial do Birth by Sleep |

O `bbs_third` é novo na distribuição — quem vem de qualquer versão anterior
tem esse arquivo de fábrica, e o instalador aplica o patch certo sozinho.
`Re:CoM`, `KH2` e os demais **não mudam** em relação à v1.5.

## ⬆️ Atualizando

O instalador reconhece a versão pelo **SHA-256** de cada arquivo, não pelo
número. Quem está em qualquer versão de 1.0 a 1.5 é levado direto à 1.6, sem
baixar nada pela Steam.

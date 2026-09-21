# v1.9 — a letra que sumia no começo da fala

Versão de acabamento, e quase toda ela saiu de **um relatório de quem estava
jogando**. Obrigado mesmo — três dos quatro consertos abaixo eu não teria
achado sozinho.

## 🐛 O `Escuta` que virava `Lscuta`

O relato foi esse: no túnel do Twilight Town, depois dos clones do Vivi, o
Roxas fala com o Pence e sai **`Lscuta`** na tela.

A causa não estava na tradução — estava na **ferramenta que lê o texto do
jogo**. O KH2 abre certas falas com um comando invisível, e a ferramenta
achava que esse comando engolia o byte seguinte. Ele não engole. O byte
seguinte era a **primeira letra da fala**.

Na prática, quem traduziu recebeu a frase já sem a inicial:

| o que a ferramenta mostrava | o que era |
|---|---|
| `isten, there were a whole bunch of Vivi clones...` | **L**isten |
| `iglet...` | **P**iglet |
| `e found the computer Ansem was using!` | **W**e found |

A tradução foi feita em cima do que aparecia, e a letra inglesa continuou lá,
presa no comando, sendo desenhada antes do texto português.

São **60 falas** com esse defeito. Em 17 delas a inicial do português calhou
de ser a mesma do inglês e ninguém percebeu (`S`ora, `C`ala a boca, `N`ão).
Nas outras **43** saía assim:

| aparecia | agora |
|---|---|
| `Peitão...` | `Leitão...` |
| `Wchamos o computador que o Ansem usava!` | `Achamos...` |
| `Sntão você QUERIA mesmo ser rei!` | `Então...` |
| `Frimeiro, vamos achar todos os medalhões.` | `Primeiro...` |
| `Há vou eu!` | `Lá vou eu!` |
| `Yocê sente falta dele.` | `Você...` |
| `Bas tudo PARECE tranquilo.` | `Mas...` |
| `Poleza!` | `Moleza!` |

## 🗺️ Os nomes de rua do Twilight Town, agora todos em inglês

Outro ponto do mesmo relato: *"alguns nomes estão traduzidos outros em inglês
e acaba confundindo a chegar no objetivo"*. Estava certíssimo — em uma fala o
jogo dizia `Rua do Mercado` e em outra `Market Street`.

Quem decidiu a direção foi **a placa**. Os letreiros de rua, o mapa e as telas
de tutorial do Twilight Town são *imagem*, com a letra desenhada dentro, e
continuam em inglês. Traduzir o nome na fala nunca ia bater com o
`Market Street` escrito na parede — e quem está procurando o caminho é quem
paga.

Curiosamente, a maioria já estava em inglês: **47 ocorrências contra 30**.
Esta versão só fecha a conta.

`Praça da Estação` → `Station Plaza` · `Rua do Mercado` → `Market Street` ·
`Colina do Poente` → `Sunset Hill` · `Terreno Baldio` → `Sandlot` ·
`Beco` → `Back Alley` · `O Ponto de Sempre` → `The Usual Spot`

## 🎭 O Setzer não estava te chamando de objeto

No original o Setzer fala `Hey. Rucksack.` — ele te chama pela bolsa que o
Roxas carrega, de deboche. A tradução tinha ficado literal, `Ei. Mochila.`, e
em português soava como se ele estivesse chamando uma mochila.

Agora é **`Ei. Mochileiro.`** — apelido formado sobre o mesmo objeto, que é o
que a piada pede.

## 📏 O diário do Roxas, nos filmes

Sem relato, este: apareceu numa revisão das ferramentas.

A régua que mede se uma linha cabe na caixa estava contando o **`ã` como
largura zero** — ela media o texto antes da troca que grava o til no jogo, e
naquela tabela o `ã` não existe. Resultado: `Organização` era medida como se
fosse `Organizaço`, e linha que vazava passava batido.

Com a régua honesta, **55 textos** estavam largos demais, quase todos nos dois
filmes: 39 no diário do Roxas (20 deles nos Relatórios Secretos), 8 na
enciclopédia do Re:coded e 8 em legendas. Todos foram requebrados — **nenhuma
palavra mudou**, só onde a linha quebra.

É o mesmo tipo de conserto do Diário do KH1 na v1.5 e da linha de tutorial do
BbS na v1.8: mexer na quebra, não no texto.

## 🖼️ O que continua em inglês, e por quê

Do mesmo relatório vieram as telas de tutorial (habilidades, auto-reload, as
regras do Struggle), o quadro de empregos do Roxas e o `OBTAINED` que aparece
ao abrir um baú.

Conferido arquivo por arquivo: **o texto do KH2 está 100% traduzido**. Essas
telas não são texto — são **imagem**, com as letras desenhadas dentro, e a
Square fez uma versão de cada uma para cada idioma. Traduzir ali não é
traduzir, é redesenhar: só o `OBTAINED` aparece em 19 texturas, uma por mundo.

Fica para uma versão de arte. O material já está separado e mapeado.

## 📦 O que muda no seu jogo

| Arquivo | O que ganhou |
|---|---|
| `kh2_first` | as falas do Twilight Town e os rótulos de sala |
| `kh2_fifth` | as falas dos outros mundos e o Diário do Grilo |
| `Mare` | o diário do Roxas e a enciclopédia do Re:coded |

Os outros **não mudam** em relação à 1.8.

## ⬆️ Atualizando

O instalador reconhece a versão pelo **SHA-256** de cada arquivo, não pelo
número. Quem está em qualquer versão de 1.0 a 1.8 vai direto à 1.9.

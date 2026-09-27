# v1.10 — o que era imagem

Na 1.9 eu escrevi que as telas de tutorial, o quadro de empregos e o
`OBTAINED` do baú continuavam em inglês porque **não são texto**: são imagem,
com as letras desenhadas dentro, e a Square fez uma versão de cada uma para
cada idioma.

Esta versão redesenha essas imagens.

## 🎒 KINGDOM HEARTS II

| onde | era | virou |
|---|---|---|
| ao abrir um baú | `OBTAINED` | **`OBTIDO`** |
| fim de batalha | `GET BONUS!` | **`BÔNUS!`** |
| ao subir de nível | `LEVEL UP!` | **`NÍVEL ↑!`** |
| caixas de aviso | `INFORMATION` · `LV.` | **`INFORMAÇÃO`** · **`NV.`** |
| quadro de empregos do Roxas | `HELP WANTED` · `NEW!!` · `HI SCORE` | **`PRECISA-SE`** · **`NOVO!`** · **`RECORDE`** |
| cartões do prólogo | `THE 1st DAY` | **`O 1º DIA`** |
| telas de tutorial | habilidades, auto-reload e as regras do Struggle | **traduzidas**, inclusive as capturas de menu dentro delas |

O `OBTAINED` sozinho aparece em **19 texturas** — uma cópia da HUD por mundo
do jogo.

## 🗺️ KINGDOM HEARTS FINAL MIX — o mapa-múndi

E aqui vai uma confissão.

As cinco texturas do mapa-múndi **estavam traduzidas desde sempre**, guardadas
no projeto, montadas no patch — e **nunca chegaram ao jogo**. Elas moram num
pacote (`kh1_fourth`) que a distribuição não incluía: não estava na lista de
reempacotamento, não estava no manifesto, não estava em lugar nenhum. Nada
acusou, porque ninguém reclama de um arquivo que não é procurado.

Descobri isso agora, ao levantar o que ainda faltava de arte. E, ao olhar as
texturas antigas de perto, elas também não serviam — fonte trocada por uma
genérica, fundo opaco por trás das letras, resíduo do inglês por baixo. Foram
refeitas.

| era | virou |
|---|---|
| `MISSION` · `LEVEL` | **`MISSÃO`** · **`NÍVEL`** |
| `SCORE` · `NEW HIGH SCORE` | **`PONTOS`** · **`NOVO RECORDE`** |
| `MISSION COMPLETE` | **`MISSÃO COMPLETADA`** |
| `GUMMI GARAGE` · `GUMMI SHIP MISSION` | **`GARAGEM GUMMI`** · **`MISSÃO GUMMI`** |
| `COMPLETE!` · `HIGH SCORE` | **`COMPLETO!`** · **`RECORDE`** |

O pacote `kh1_fourth` entra na distribuição a partir desta versão. Quem
instalar recebe ele junto, sem precisar fazer nada.

## 🔤 Sobre a letra

Nada disso foi escrito com uma fonte parecida. O desenho de cada palavra saiu
das **próprias texturas do jogo**, colhido da versão espanhola — que usa a
mesma fonte e escreve quase as mesmas palavras. `COMPLETADA`, `RESULTADOS`,
`TOTAL` e `MODO` já estavam certos em português e não foram tocados.

Os acentos `ã` e `í` não existem nessa fonte em nenhum idioma, e foram
desenhados à mão, no mesmo peso de traço das letras.

## 📦 O que muda no seu jogo

| Arquivo | O que ganhou |
|---|---|
| `kh2_first` | HUD do Twilight Town, quadro de empregos, cartões de dia |
| `kh2_fifth` | HUD dos outros 17 mundos e as telas de tutorial |
| `kh1_first` … `kh1_third` | **não mudam** |
| `kh1_fourth` | **novo na distribuição** — o mapa-múndi |

Os outros **não mudam** em relação à 1.9.

## ⬆️ Atualizando

O instalador reconhece a versão pelo **SHA-256** de cada arquivo, não pelo
número. Quem está em qualquer versão de 1.0 a 1.9 vai direto à 1.10.

> O `kh1_fourth` é novo na distribuição. Quem vem de qualquer versão anterior
> o tem de fábrica, e o instalador aplica o patch nele normalmente.

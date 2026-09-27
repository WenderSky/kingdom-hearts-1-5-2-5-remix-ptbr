# v1.11 — os letreiros de sala, e o nome do lugar que a missão diz

Esta versão traz junto tudo o que estava na 1.10, que ficou pronta mas não
chegou a ser publicada. Quem vem da 1.9 recebe as duas de uma vez.

## 🪧 O letreiro que aparece ao entrar na sala

Aquele nome que passa na tela quando você entra numa área — `THE USUAL SPOT`,
`SANDLOT`, `MARKET STREET` — é **imagem**, não texto: as letras são desenhadas
dentro da textura, e a Square fez uma versão para cada idioma.

Até a 1.9 este repositório afirmava que a placa não mudava. Ela muda: o
espanhol traz `EL LUGAR DE SIEMPRE` no lugar de `THE USUAL SPOT`. São **233
letreiros com texto** no KINGDOM HEARTS II, e **47 já estão em português**:

- **Twilight Town inteiro** — os 41;
- **Hollow Bastion** — 6 dos 29, o resto em andamento.

A letra não é fonte: é letreiro desenhado à mão, com a linha de base ondulada
e cada glifo de um tamanho. Não há programa que reproduza isso, e recortar
letra da versão espanhola não serve porque as palavras são outras. Cada um foi
redesenhado, e o encaixe (escala, centro, régua) é conferido por script contra
o original, letreiro por letreiro.

## 🧭 E a missão passou a dizer o mesmo que a placa

Com a placa em português, os nomes de área nas falas e nas missões vieram
junto — **77 trocas em 70 mensagens**. Antes a missão mandava você para
`Sunset Hill` e a placa na parede dizia outra coisa; agora as duas dizem
**Colina do Poente**.

| era | virou |
|---|---|
| `Sunset Hill` · `Sunset Station` · `Sunset Terrace` | **Colina do Poente** · **Estação do Poente** · **Terraço do Poente** |
| `Market Street` · `Station Heights` · `Tram Common` | **Rua do Mercado** · **Alto da Estação** · **Praça do Bonde** |
| `Sandlot` · `The Usual Spot` · `Station Plaza` | **Terreno Baldio** · **O Ponto de Sempre** · **Praça da Estação** |
| `Central Station` · `Underground Concourse` | **Estação Central** · **Passagem Subterrânea** |

E o menu de destinos, que estava meio traduzido: ele listava
`2: Tunnelway 3: Back Alley 4: Praça do Bonde` — três entradas do mesmo tipo,
duas em inglês ao lado da terceira em português. Agora é **Túnel** e **Beco**
como as outras.

> Nome **próprio** de mundo continua em inglês, como sempre: Twilight Town,
> Hollow Bastion, Radiant Garden, Castle Oblivion. O que passou a traduzir é o
> nome **da área dentro** do mundo.

## 🖼️ E tudo o que a 1.10 trazia

As imagens com texto do KINGDOM HEARTS II — `OBTAINED` virou **`OBTIDO`**,
`GET BONUS!` virou **`BÔNUS!`**, `LEVEL UP!` virou **`NÍVEL ↑!`**, o quadro de
empregos do Roxas, os cartões do prólogo e as telas de tutorial — e o
**mapa-múndi do KINGDOM HEARTS FINAL MIX**, que estava traduzido desde sempre e
nunca chegava ao jogo porque morava num pacote que a distribuição não incluía.

Os detalhes estão em [`NOTAS_RELEASE_v1.10.md`](NOTAS_RELEASE_v1.10.md).

## 📦 Agora são dois pacotes de tradução — escolha um

| pacote | o que faz |
|---|---|
| **`KH_PTBR_v1.11.zip`** | a tradução de texto, completa |
| **`KH_PTBR_v1.11_Texturas.zip`** | o mesmo, **mais** os 47 letreiros de sala |

O texto é **idêntico** nos dois. A diferença é só a arte.

Por que a escolha: com 47 dos 233 letreiros prontos, quem instalar o pacote com
texturas vai andar de uma sala com a placa em português para outra ainda em
inglês. Se isso incomodar mais do que a placa em inglês, instale o pacote de
texto e espere a arte fechar — dá para trocar de um para o outro depois, sem
reinstalar o jogo e sem perder save.

O **`KH_Videos_PTBR_v1.0.zip`** continua opcional e independente dos dois.

## ⬆️ Atualizando

O instalador reconhece a versão pelo **SHA-256** de cada arquivo, não pelo
número. Quem está em qualquer versão de 1.0 a 1.10 vai direto à 1.11.

## 📊 Quanto falta de textura

O texto está 100%. A arte com letra desenhada dentro está em **6%** da
coletânea (110 de 1729), e os letreiros de sala do KH2 em **20%** (47 de 233).
O quadro fica no [README](README.md) e sobe a cada lote.

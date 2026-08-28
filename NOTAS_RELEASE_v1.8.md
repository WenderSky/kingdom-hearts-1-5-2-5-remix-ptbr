# v1.8 — as linhas que passavam da caixa

Versão pequena, de acabamento: doze frases do Re:CoM e uma linha de ajuda do
BbS que passavam da largura da caixa.

## 📏 A régua honesta

Vale registrar o critério, porque ele muda o tamanho do problema.

Medir a tradução contra o **inglês** engana: ele é a língua mais curta do
pacote, e quase toda tradução passa dele sem que isso queira dizer vazamento.
Por essa régua o Re:CoM teria centenas de linhas "estourando" — e nenhuma
delas aparece torta em jogo.

A régua do projeto é outra: para **a mesma mensagem**, quanto o espanhol, o
francês, o alemão e o italiano ocupam. São traduções que a Square aprovou,
rodando neste mesmo jogo, nesta mesma caixa. Se o alemão coube ali, cabe.

Por esse critério sobraram **12 frases** no Re:CoM e **1 linha** no BbS.

## 🩹 Re:CoM

Doze frases encurtadas pelas regras mecânicas do projeto — as que não mudam
sentido nem registro:

| | |
|---|---|
| sujeito oculto | *Você está pronto?* → *Está pronto?* |
| perífrase vira verbo | *o Sora está falando sério* → *o Sora fala sério* |
| palavra mais curta | *Aconteceu alguma coisa?* → *Aconteceu algo?* |

## 🩹 BbS

A linha do tutorial de interagir com objetos tinha 349 px contra um teto de
330. **Nenhuma palavra mudou**: a segunda linha tinha folga (290 px), e bastou
mover o `ou` para ela — 321 e 318 px, as duas dentro do teto.

É a correção mais barata que existe, a mesma do Diário do KH1 e das descrições
de habilidade: mexer em **onde a linha quebra**, não no que ela diz.

## 🔎 O que foi conferido e estava certo

- **`save` não é erro.** O Re:CoM usa *salvar* como verbo (45 vezes) e *o save*
  como substantivo (10) — inclusive na mesma frase: "dá para **salvar** os
  dados... ao carregar esse **save**". É coerente, e é como se fala.
- **KH2 e o menu da coletânea** não têm nenhuma linha acima do teto.
- No BbS o que ainda passa são **nomes próprios** (Pérola, Huguinho, Pateta,
  Tico, Teco), por 1 a 11 px. Não há como encurtar sem descaracterizar, e a
  própria régua do projeto os marca como isentos.

## 📦 O que muda no seu jogo

| Arquivo | O que ganhou |
|---|---|
| `Recom` | as 12 frases |
| `bbs_first` | a linha do tutorial |

Os outros **não mudam** em relação à 1.7.

## ⬆️ Atualizando

O instalador reconhece a versão pelo **SHA-256** de cada arquivo, não pelo
número. Quem está em qualquer versão de 1.0 a 1.7 vai direto à 1.8.

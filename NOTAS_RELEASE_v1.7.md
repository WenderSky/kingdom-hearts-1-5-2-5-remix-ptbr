# v1.7 — os seis jogos assinados, e o instalador que travava

A 1.6 deixou dois jogos de fora e um bug de instalação em aberto. Esta versão
fecha os dois.

## 🔧 O instalador travava em quem tem um HD desconectado

Reportado por quem instalou a 1.5:

```
Join-Path : Não é possível localizar a unidade.
Não existe uma unidade com o nome 'D'.
```

O `Join-Path` do PowerShell não é só juntar texto: ele resolve a unidade e
**lança exceção** se ela não existe. Quem tem no `libraryfolders.vdf` da Steam
uma biblioteca num HD que saiu da máquina — ou num disco externo desligado —
carrega essa linha para sempre no arquivo. O instalador lia, morria ali, e
**nem chegava a procurar o jogo**.

Trocado por uma função que só concatena texto, nas **9** chamadas que tocam
caminho que pode não existir. Agora a biblioteca fantasma é simplesmente
ignorada e a busca continua. Quem estava travado na 1.5 ou 1.6 resolve com o
instalador desta versão — o conteúdo do patch é o mesmo.

## ✍️ O crédito no KINGDOM HEARTS II e no Re:Chain of Memories

Na 1.6 estes dois ficaram sem crédito: o bloco `DEVELOPED BY SQUARE ENIX`
volta ao original assim que o jogo detecta um controle, porque a tela inteira
troca de atlas — e esse atlas não foi encontrado em pacote nenhum.

A saída foi **não disputar o bloco**: o crédito foi para a **arte de fundo**,
que o jogo desenha sempre, com controle ou teclado.

Três coisas que o caminho ensinou:

- **em fundo opaco não se apaga a caixa.** A rotina usada nas outras telas
  zera a área antes de escrever (certo quando o fundo é transparente); num
  fundo opaco isso abriria um retângulo transparente no meio da tela;
- **a escala do fundo não é a do bloco.** No KH2 o fundo é desenhado a 1,44x e
  o bloco a 0,74x — a mesma caixa sai com o **dobro** do tamanho;
- **no Re:CoM o alfa satura em 128.** Compor o texto já com 128 mistura o
  preto com a arte *na cor*, e a mistura fica gravada: sai cinza em vez de
  preto.

No Re:CoM o crédito fica na metade direita da tela. Não é escolha: medindo
onde a textura cai na tela, ela só começa a ser desenhada a partir de 58% da
largura — a coluna do `DEVELOPED BY` não pertence a essa imagem.

**Com isso os seis jogos da coletânea estão assinados.**

## 🩹 Re:CoM: o Diário, o Índice e as fichas de inimigo

- **Diário do Grilo e Índice de Cartas** tinham um sétimo slot de idioma
  (`US_`) que o pipeline não varria, e podiam abrir em inglês. Agora os dois
  slots são cobertos.
- **40 fichas de inimigo** diziam `Limite: 3 reloads` e `Limite: 30 attacks`.
  É o defeito de tradução por fragmento: a prova de que era esquecimento, e
  não decisão, está na mesma ficha — logo abaixo ela já trazia *Recarga
  Móvel* e *Ataque Veloz*. Corrigido para **recargas** e **ataques**, sem
  crescer um pixel de linha.

## 📦 O que muda no seu jogo

| Arquivo | O que ganhou |
|---|---|
| `kh2_first` | o crédito na tela inicial do KINGDOM HEARTS II |
| `Recom` | o crédito, o slot US do Diário e do Índice, e as 40 fichas |

Os outros **não mudam** em relação à 1.6.

## ⬆️ Atualizando

O instalador reconhece a versão pelo **SHA-256** de cada arquivo, não pelo
número. Quem está em qualquer versão de 1.0 a 1.6 vai direto à 1.7.

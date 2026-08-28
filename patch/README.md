<div align="center">

# KINGDOM HEARTS HD 1.5+2.5 ReMIX — Tradução PT-BR 🗝️

### A coletânea inteira em português. Um patch só.

![Versão](https://img.shields.io/badge/vers%C3%A3o-1.2-blue?style=for-the-badge)
![Jogos](https://img.shields.io/badge/6_jogos-100%25-success?style=for-the-badge)
![Download](https://img.shields.io/badge/download-23_MB-orange?style=for-the-badge)
![Plataforma](https://img.shields.io/badge/Steam-Windows_%7C_Steam_Deck-1b2838?style=for-the-badge&logo=steam)

</div>

---

## 🎮 O que é isto

Tradução **feita à mão, do zero**, a partir do texto em inglês de cada jogo.
Nada de tradução automática: cada fala foi passada uma a uma, com uma régua
medindo se ela cabe na caixa antes de entrar.

**36.562 trechos · 1.698.684 caracteres em português.**

| jogo | trechos | o que está traduzido |
|---|---:|---|
| **KINGDOM HEARTS FINAL MIX** | 5.975 | história, itens, Diário do Grilo, menus |
| **Re:Chain of Memories** | 3.373 | história, cartas, fichas, menus |
| **Birth by Sleep FINAL MIX** | 6.784 | as três campanhas, Relatos, Arena, 13 telas de ajuda redesenhadas |
| **KINGDOM HEARTS II FINAL MIX** | 15.936 | história, Diário, Relatórios de Ansem, tutoriais, Guia Gummi |
| **358/2 Days** e **Re:coded** | 4.494 | os dois filmes: cenas, Diário do Roxas, Relatórios Secretos, enciclopédia |

---

## 💾 Instalação

Dá para instalar de dois jeitos. **O automático faz tudo sozinho**; o manual
existe para quem prefere ver o que está acontecendo.

### 1) Automática — Windows

Extraia a pasta inteira e clique duas vezes em **`Instalar.bat`**.

O instalador acha o jogo sozinho na Steam, confere cada arquivo pelo SHA-256,
aplica os patches e confere o resultado. Se algo não bater, ele para **antes**
de escrever qualquer coisa.

> Se a pasta do jogo não for encontrada, rode apontando o caminho:
> ```powershell
> .\instalar.ps1 -Jogo "D:\SteamLibrary\steamapps\common\KINGDOM HEARTS -HD 1.5+2.5 ReMIX-"
> ```

### 1) Automática — Steam Deck

Copie a pasta para o Deck e, no modo Desktop, rode no Konsole:

```bash
chmod +x SteamDeck/instalar.sh
./SteamDeck/instalar.sh
```

### 2) Manual — comando por comando

Este patch não é "copiar e colar": ele **reconstrói** arquivos de até 10,8 GB
a partir de um delta de alguns KB, e isso precisa do `xdelta3` (que vem na
pasta). Mas dá para rodar na mão, um arquivo por vez, de dentro da pasta do
pacote:

```powershell
.\xdelta3.exe -d -f -s "<arquivo do jogo>" "patch\<nome>.xdelta" "<arquivo do jogo>"
```

O **`manifesto.json`** lista os 22 arquivos, o delta de cada um e o SHA-256
antes e depois — é por ele que se confere se deu certo.

> 💡 **No Steam Deck, arrastar pelo cabo costuma ser mais rápido** que abrir o
> Konsole: ligue o Deck no PC, copie a pasta para a área de trabalho dele e
> rode o `instalar.sh` de lá.

---

## ⚠️ Antes de instalar

| | |
|---|---|
| **Deixe o jogo em INGLÊS** | é o slot que a tradução ocupa. Em qualquer outro idioma, o texto sai no original |
| **Estraga o save?** | não. O patch mexe só nos arquivos de texto |
| **Preciso dos vídeos?** | não. O pacote de vídeos é separado e opcional |
| **Ordem de instalação** | tanto faz. Nada aqui desfaz nada |
| **Atualizar de uma versão anterior** | rodar o instalador por cima basta: ele reconhece qual versão você tem e aplica só a diferença, sem rebaixar nada pela Steam. Vale igual no Windows e no Steam Deck |
| **Como desfazer** | Steam ▸ botão direito no jogo ▸ Propriedades ▸ Arquivos instalados ▸ **Verificar integridade dos arquivos** |

> O instalador **confere o SHA-256** de cada arquivo antes de aplicar o delta.
> Aqui a checagem protege de verdade: delta aplicado sobre base errada corrompe
> um `.pkg` de vários GB. (No pacote de vídeos ela não existe — lá o arquivo é
> isolado e a checagem só atrapalhava.)
>
> Se algum arquivo estiver **em uso** na hora (a Steam costuma segurar um
> `.pkg` grande logo depois de verificar), o instalador espera e tenta de novo
> sozinho.

---

## 🌍 O que fica em inglês, e por quê

- **termos da série**: Keyblade, Heartless, Nobody, Kingdom Hearts, Moogle,
  munny, Struggle;
- **nome de item, magia, comando e Drive Form**: aparecem **desenhados** na
  interface. Traduzir só o texto faria a descrição falar de "Poção" enquanto o
  menu mostra `Potion`;
- **nome próprio de mundo**: Traverse Town, Hollow Bastion, Port Royal,
  Castle Oblivion — é endereço, não descrição. Mas nome **descritivo** traduz:
  Cave of Wonders → Caverna das Maravilhas;
- **tela de título e rolagem de créditos**: são imagem, e o nome do jogo não se
  traduz.

Traduz-se **tudo o que descreve** (efeito de item, ficha de inimigo, resumo do
Diário) e **todo comando de interação** — é o que você lê na hora de agir.

---

## ✍️ O que mudou na 1.6

Esta versão não corrige nada: ela **assina** a tradução dentro do jogo, na
mesma fonte e com o mesmo contorno da arte original.

| | |
|---|---|
| **No menu da coletânea** | embaixo do logotipo do painel entrou **Tradução - Wender_sky**, nas **seis** telas (KH Final Mix, Re:CoM, Days, KH2, BbS e Re:coded). São seis arquivos porque cada jogo tem a sua imagem inteira, e o `Disney / SQUARE ENIX` do rodapé muda de cor conforme o fundo |
| **Nos menus dos filmes** | **Days** e **Re:coded** receberam o mesmo crédito |
| **Nas telas iniciais** | o bloco `DEVELOPED BY / SQUARE ENIX` virou **TRADUÇÃO POR / WENDER_SKY**, desenhado glifo a glifo com a fonte de menu do próprio jogo — o `Ç` e o `Ã`, que não existem nela, foram montados a partir dos seus traços. Entrou em **KINGDOM HEARTS Final Mix**, **358/2 Days**, **Re:coded** e **Birth by Sleep** |
| **KH2 e Re:CoM ficaram de fora** | neles o crédito aparece com teclado mas volta ao original quando o jogo detecta um controle: a tela inteira vem de outro atlas, que não foi encontrado. Varrendo o conteúdo, as **23** imagens do `kh2_first` e as **15** do Re:CoM que têm o bloco estão todas assinadas, e ainda assim volta. Para não correr risco à toa, os dois foram devolvidos ao estado da 1.5 — a tradução deles segue inteira |

> O `bbs_third` é novo na distribuição. Quem vem de qualquer versão anterior
> tem esse arquivo de fábrica, e o instalador aplica o patch certo sozinho.

> Rodar o instalador por cima basta, venha de qualquer versão: ele reconhece o
> que você tem pelo SHA-256 e aplica só a diferença.

---

## 🩹 O que mudou na 1.5

| | |
|---|---|
| **Diário: texto atrás do retrato** | na ficha de personagem, a segunda linha da página da direita passava por trás do retrato e sumia. O retrato cobre as **duas primeiras linhas** dela, e ali a largura útil é menor: o inglês nunca põe mais de **151 px** (contra 240 nas linhas livres), a nossa tradução chegava a 236. **52 fichas de 184** afetadas, todas corrigidas mudando só onde a linha quebra |
| **Duas descrições de item idênticas** | o grau do efeito mora no advérbio, e ele tinha sido comido: *Slightly raises Defense* virou "Aumenta a Defesa", igual a *Raises Defense*. A Corrente Protect e a Protera diziam a mesma frase |
| **Inglês dentro da descrição** | `essência de vitality`, `Essência de emptiness cristalizada`, `A rare e most valuable ore`, e cinco com a frase inteira sem traduzir. A tradução é por fragmento: a frase repetida em 34 itens estava pronta, a única de cada item faltou. **25 descrições** corrigidas |

> Rodar o instalador por cima basta, venha de qualquer versão: ele reconhece o
> que você tem pelo SHA-256 e aplica só a diferença.

---

## 🩹 O que mudou na 1.4

| | |
|---|---|
| **Descrição de habilidade cortada** | no menu Habilidades o rodapé era cortado e o resto ficava fora da tela: a Fúria perdia o *força.*, a Carga do Pateta perdia o *MP.* do custo |
| **A causa** | a caixa mostra **três linhas**, e o jogo **monta ela de dois pedaços** — a descrição e o custo ficam guardados separados e são colados na hora de mostrar. Medir cada metade sozinha não acha nada: o estouro só existe depois da cola. Pesava também o custo ter sido quebrado em duas linhas onde o inglês usa uma |
| **O conserto** | **30 descrições** de volta às três linhas; 29 só mudaram onde a linha quebra e **uma** precisou de reescrita (*"que resta"* → *"restante"*, no MP Burst) |
| **O gummi de novo** | as conversas da nave continuavam cortadas depois da 1.3: o arquivo existe em **dois pacotes** e a 1.3 corrigiu o que o jogo não lê. Ele não existe no `kh1_first` de fábrica — o próprio patch o pôs lá na 1.0 — então procurar na base de fábrica achava só a outra cópia. Agora as duas estão certas |

> Rodar o instalador por cima basta, venha de qualquer versão: ele reconhece o
> que você tem pelo SHA-256 e aplica só a diferença.

---

## 🩹 O que mudou na 1.3

Um relato de quem jogou a 1.2, com GIF: dentro da **nave gummi**, a segunda
linha das conversas do rádio saía em vermelho apagado, ilegível.

| | |
|---|---|
| **O que acontecia** | Sora dizia *"Nossa, é"* e o *"enorme!"* ficava embaixo, borrado; Donald perguntava *"O que é"* e o *"aquilo?"* sumia igual. As falas de uma linha só apareciam normais — foi essa a pista. **42 falas** ao todo |
| **A causa** | essas caixas têm **duas linhas**, e a quebra de linha delas é um comando próprio do formato, não o `
` de sempre. A tradução quebrou com `
` e, ao quebrar, repetiu na frente da linha nova um pedaço do cabeçalho da caixa — que **não é texto, é um comando** (o que diz quanto tempo a fala fica na tela). Solto no meio da frase, ele desmonta a caixa: sobra a sombra do texto, sem a letra por cima |
| **A prova** | nos cinco idiomas oficiais do disco são **473 falas** e **nenhuma** passa de duas linhas. A nossa 1.2 tinha 34 com três |
| **O conserto** | as 42 voltaram a caber em duas linhas, com a quebra certa. **Nenhuma precisou ser reescrita**: só mudou onde a linha quebra, e o corte segue o ritmo do próprio inglês para não separar o que anda junto (*Marca da Trindade*, *Rei Mickey*) |
| **De brinde** | o `treasure.ev` e o `PresentMessage.bin` — os do conserto da 1.2 — existem em **dois pacotes** do jogo. A 1.2 corrigiu o que o jogo lê; a outra cópia ficou como estava. Agora as duas estão iguais |

> Quem está na 1.0, 1.1 ou 1.2 é só rodar o instalador por cima: da 1.2 para a
> 1.3 são **10 KB**, e nada precisa ser rebaixado pela Steam.

---

## 🩹 O que mudou na 1.2

Dois relatos de quem jogou a 1.1, e os dois eram **o mesmo defeito**.

| | |
|---|---|
| **O baú não dizia o que você achou** | a caixa piscava no canto e fechava sem mostrar o item — o baú da primeira área de Traverse Town, o do Defense Up, e os outros |
| **O correio devolvia caixa vazia** | você entregava o cartão e não recebia nada em tela; devia vir um Cottage |
| **A causa** | o `treasure.ev` e o `PresentMessage.bin` **não são lista de texto, são script**: os bytes entre uma fala e a seguinte fazem parte do fluxo de comandos. Quando a tradução ficava mais curta que o inglês (`Obtained` → `Obteve` são 2 bytes), o espaço que sobrava era preenchido com zeros — e esses zeros entravam no meio dos comandos. Agora o que sobra vira **espaço**, que não aparece na tela e não desloca nada. **60 falas** corrigidas |
| **A prova** | nos outros quatro idiomas do disco há *sempre exatamente um* zero entre uma fala e o marcador seguinte — 66 vezes no espanhol, no francês e no alemão, 70 no italiano, sem uma exceção. Na nossa 1.1, 36 estavam fora |
| **`complete gummi collection`** | o nome tinha ficado em inglês nas duas mensagens que o mostram. Virou **coleção completa de gummis** |

> Quem está na 1.0 ou na 1.1 é só rodar o instalador por cima: são **6 KB** de
> diferença vindo da 1.1, e nada precisa ser rebaixado pela Steam.

---

## 🩹 O que mudou na 1.1

Correções vindas de quem instalou a 1.0 e jogou.

| | |
|---|---|
| **O Diário fechava o jogo** | ao virar a última página de 22 Crônicas, 45 fichas do Registro de Personagens e 9 Relatórios de Ansem |
| **E vazava texto para fora da página** | o resto do Diário desenhava a página seguinte por cima da atual, fora da caixa e com as letras espaçadas. É o mesmo defeito: o `{0F}` que vira a página precisa de um espaço logo depois, e a tradução tinha aparado. No inglês são 606 ocorrências do comando e 606 com o espaço; na tradução, 233 estavam erradas |
| **Menus com as opções trocadas de lugar** | no KH1 o cursor anda por linha, e o reencaixe do texto tinha empurrado palavras de uma opção para a outra — `Ampliar meus` / `horizontes. Ser forte.` no início do jogo, `Certo, topo! Foi` / `mal, sem tempo agora.` em Traverse Town. **69 caixas realinhadas**, incluindo as copas do Coliseu, a entrada da arena, o balanço do Pooh e o Bosque dos Cem Acres |
| **Texto passando da caixa no Diário** | 13 páginas re-quebradas com a régua de pixels |
| **`iOlhar em Volta`** | a tela de controles mostrava a letra `i` solta: o desenho do botão tinha se perdido na tradução. Mais três mensagens de menu no mesmo caso |
| **Instalador mais claro** | quando um arquivo do jogo não bate, ele agora diz **por quê** — arquivo incompleto, alterado por outro mod, ou versão diferente do jogo — comparando com o próprio manifesto de depósito da Steam, e manda apagar só aquele arquivo antes de verificar a integridade |

---

## 🎬 Dublagem brasileira

Os nomes seguem a dublagem de cada filme, não o inglês:

Horloge, Madame Samovar, Zip · Huguinho, Zezinho e Luisinho · Tico e Teco ·
Tio Patinhas · Abel, Leitão, Tigrão e Ió · Timão e Pumba · Flora, Fauna e
Primavera · Pérola Negra · Papai Natal (o Jack erra) e Papai Noel (que corrige)

E os bordões ficam iguais nos seis jogos: *"Got it memorized?"* é sempre
**"Guarda bem isso, hein?"**.

---

<div align="center">

**Tradução por Wender_sky (Steam)**

*"Há muitos mundos, mas eles dividem o mesmo céu — um só céu, um só destino."*

</div>

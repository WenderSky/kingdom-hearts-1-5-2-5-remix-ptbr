<div align="center">

# 🗝️ KINGDOM HEARTS HD 1.5+2.5 ReMIX — Tradução PT-BR

### A coletânea inteira em português brasileiro

![Versão](https://img.shields.io/badge/vers%C3%A3o-1.3-blue?style=for-the-badge)
![Jogos](https://img.shields.io/badge/6_jogos-100%25-success?style=for-the-badge)
![Trechos](https://img.shields.io/badge/36.562_trechos-1,7_milh%C3%A3o_de_caracteres-9b59b6?style=for-the-badge)
![Plataforma](https://img.shields.io/badge/Steam-Windows_%7C_Steam_Deck-1b2838?style=for-the-badge&logo=steam)

**[⬇️ Baixar na página de Releases](../../releases/latest)**

</div>

---

## 🎮 Sobre

Tradução **feita do zero**, a partir do texto em inglês de cada jogo.
Tradução automatizada: cada fala foi passada uma a uma, e cada uma passou
por uma régua que mede a largura da linha antes de ela entrar no jogo — 
Infelizmente alguns textos acabam vazando da caixa.

| jogo | trechos | o que está traduzido |
|---|---:|---|
| **KINGDOM HEARTS FINAL MIX** | 5.975 | história, itens, Diário do Grilo, menus |
| **Re:Chain of Memories** | 3.373 | história, cartas, fichas, menus |
| **Birth by Sleep FINAL MIX** | 6.784 | as três campanhas, Relatos, Arena, 13 telas de ajuda redesenhadas |
| **KINGDOM HEARTS II FINAL MIX** | 15.936 | história, Diário, Relatórios de Ansem, tutoriais, Guia Gummi |
| **358/2 Days** e **Re:coded** | 4.494 | os dois filmes: cenas, Diário do Roxas, Relatórios Secretos, enciclopédia |
| **total** | **36.562** | **1.698.684 caracteres em português** |

---

## 📦 São dois pacotes

| pacote | tamanho | o que faz |
|---|---:|---|
| **`KH_PTBR`** | 18 MB | traduz o texto dos seis jogos |
| **`KH_Videos_PTBR`** | 1,74 GB | legenda os 10 vídeos que têm o texto pintado na imagem |

O segundo é **opcional e independente** — vídeo legendado é recodificado, então
não cabe num patch pequeno. Quem só quer a tradução baixa 18 MB.

---

## 💾 Instalação

### Tradução (texto)

**Windows:** extraia e clique duas vezes em **`Instalar.bat`**.
**Steam Deck:** `chmod +x SteamDeck/instalar.sh && ./SteamDeck/instalar.sh`

O instalador acha o jogo sozinho, confere cada arquivo pelo SHA-256, aplica os
patches com barra de progresso e confere o resultado. Se algo não bater, ele
para **antes** de escrever qualquer coisa.

### Vídeos

Extraia o zip e **arraste a pasta`STEAM` para dentro da pasta do jogo**, 
mandando substituir. O Windows funde as pastas sozinho e troca só 
os dez arquivos. No Steam Deck é igual, pelo cabo.

### ⚠️ Deixe o jogo em INGLÊS

É o slot que a tradução ocupa. Em qualquer outro idioma, o texto sai no
original.

### Para desinstalar

Steam ▸ botão direito no jogo ▸ Propriedades ▸ Arquivos instalados ▸
**Verificar integridade dos arquivos**.

---

## ⚠️ Leia antes de jogar

**O jogo não foi inteiramente revisado.** Traduzir 36 mil trechos é uma coisa;
jogar os seis do começo ao fim conferindo cada tela é outra. O que dá para
verificar por máquina —  que nenhum marcador de comando se perdeu, 
que todo caractere tem desenho na fonte — está limpo. O que
depende de ver em jogo foi testado por amostragem.

É possível encontrar uma frase que soa estranha no contexto, texto encostando
na borda da caixa ou um trecho ainda em inglês num canto pouco visitado.

**Nada disso quebra save nem trava o jogo** — o patch mexe apenas em arquivos
de texto e de imagem. **Se achar algo, abra uma issue** com o print e onde foi.

---

## 🌍 O que fica em inglês, e por quê

- **termos da série**: Keyblade, Heartless, Nobody, Kingdom Hearts, Moogle,
  munny, Struggle;
- **nome de item, magia, comando e Drive Form**: aparecem **desenhados** na
  interface, como imagem. Traduzir só a descrição faria ela falar de "Poção"
  enquanto o menu mostra `Potion`;
- **nome próprio de mundo**: Traverse Town, Hollow Bastion, Port Royal,
  Castle Oblivion. Já nome **descritivo** traduz: *Cave of Wonders* virou
  Caverna das Maravilhas;
- **tela de título e rolagem de créditos**: são imagem, e o nome do jogo e os
  nomes da equipe não se traduzem;
- **menu de pausa e menu principal do Birth by Sleep**: são texto e dá para
  fazer — ficam para uma versão futura.

**Dublagem brasileira, sempre:** Horloge, Madame Samovar e Zip · Huguinho,
Zezinho e Luisinho · Tico e Teco · Tio Patinhas · Abel, Leitão, Tigrão e Ió ·
Timão e Pumba · Flora, Fauna e Primavera · Pérola Negra. E o bordão do Axel é o
mesmo nos quatro jogos em que aparece: *"Guarda bem isso, hein?"*

---

## 🩹 O que mudou na 1.3

Um relato de quem jogou a 1.2, com GIF: dentro da **nave gummi**, a segunda
linha das conversas do rádio saía em vermelho apagado, ilegível. As falas que
cabiam numa linha só apareciam normais — e foi isso que deu a pista.

- **O que acontecia.** Sora dizia *"Nossa, é"* e o *"enorme!"* ficava embaixo,
  borrado; Donald perguntava *"O que é"* e o *"aquilo?"* sumia do mesmo jeito.
  Ao todo, **42 falas**.
- **A causa.** Essas caixas têm **duas linhas**, e a quebra de linha delas é um
  comando próprio do formato — não é o `
` de sempre. A tradução quebrou com
  `
` e, ao quebrar, repetiu na frente da linha nova um pedaço do cabeçalho da
  caixa. Só que esse pedaço **não é texto: é um comando**, o mesmo que diz
  quanto tempo a fala fica na tela. Solto no meio da frase, ele desmonta a
  caixa — e o que sobra na tela é a sombra do texto, sem a letra por cima.
- **A prova.** Está no próprio disco: nos cinco idiomas oficiais são **473
  falas** e **nenhuma** passa de duas linhas. A nossa 1.2 tinha 34 com três.
- **O conserto.** As 42 voltaram a caber em duas linhas, com a quebra certa.
  **Nenhuma precisou ser reescrita** — só mudou onde a linha quebra, e o ponto
  de corte segue o ritmo do próprio inglês para não separar o que anda junto
  (*Marca da Trindade*, *Rei Mickey*).
- **De brinde, o baú na cópia que faltava.** O `treasure.ev` e o
  `PresentMessage.bin` — os do conserto da 1.2 — existem em **dois pacotes** do
  jogo. A 1.2 corrigiu o que o jogo lê; a cópia guardada no outro ficou como
  estava. Agora as duas estão iguais.

Quem está na 1.0, 1.1 ou 1.2 é só rodar o instalador por cima — ele reconhece a
versão e aplica só a diferença. Da 1.2 para a 1.3 são **10 KB**.

---

## 🩹 O que mudou na 1.2

Dois relatos de quem jogou a 1.1 — e os dois eram **o mesmo defeito**.

- **O baú não dizia o que você tinha achado.** A caixa piscava no canto e
  fechava sem mostrar o item: o baú da primeira área de Traverse Town, o do
  Defense Up, e os outros.
- **O correio devolvia uma caixa vazia.** Você entregava o cartão e não recebia
  nada em tela; devia vir um Cottage.
- **A causa.** O `treasure.ev` e o `PresentMessage.bin` não são lista de texto,
  são **script**: os bytes entre uma fala e a seguinte fazem parte do fluxo de
  comandos. Quando a tradução ficava mais curta que o inglês (`Obtained` →
  `Obteve` são 2 bytes), o espaço que sobrava era preenchido com **zeros** — e
  eles entravam no meio dos comandos. Agora o que sobra vira **espaço**, que
  não aparece na tela e não desloca nada. **60 falas corrigidas**, e o arquivo
  continua com o mesmo tamanho ao byte.
- **A prova.** Nos outros quatro idiomas do disco há *sempre exatamente um*
  zero entre uma fala e o marcador seguinte — 66 vezes no espanhol, no francês
  e no alemão, 70 no italiano, sem uma exceção. Na nossa 1.1, 36 estavam fora.
  Uma verificação nova reprova o pacote se o esqueleto do script mudar.
- **`complete gummi collection`** tinha ficado em inglês nas duas mensagens que
  o mostram. Virou **coleção completa de gummis**.

Quem está na 1.0 ou na 1.1 é só rodar o instalador por cima — ele reconhece a
versão e aplica só a diferença, sem rebaixar nada pela Steam. Os três caminhos
foram testados de ponta a ponta: instalação do zero, atualização da 1.0 e da
1.1, com 22/22 arquivos corretos em cada uma.

---

## 🩹 O que mudou na 1.1

Tudo aqui saiu de relatos de quem instalou a 1.0 e jogou.

- **O Diário do Grilo fechava o jogo, e vazava texto para fora da página.**
  Dois sintomas, uma causa: o `{0F}` que vira a página é um comando que precisa
  de um espaço logo depois. Aparado no fim do texto, o jogo fechava ao virar a
  última página (22 Crônicas, 45 fichas, 9 Relatórios); virado em quebra de
  linha, a página seguinte saía por cima da atual, fora da caixa e com as
  letras espaçadas. No inglês são 606 ocorrências e 606 com o espaço.
  Na tradução eram 233 comandos com o argumento trocado, mais as 76 entradas
  que o tinham perdido no fim. Uma régua nova reprova quem aparar de novo.
- **Menus com as opções trocadas de lugar.** No KH1 o cursor anda por linha:
  cada linha é uma opção. O reencaixe de texto tinha empurrado palavras de uma
  para a outra, e no início do jogo aparecia `Ampliar meus` / `horizontes. Ser
  forte.`. **69 caixas realinhadas** — as três respostas de Destiny Islands, as
  copas do Coliseu, a entrada da arena, o balanço do Pooh, o sim/não de
  Traverse Town.
- **13 páginas do Diário passavam da caixa** — re-quebradas com a régua de
  pixels.
- **`iOlhar em Volta` na tela de controles**: o desenho do botão tinha se
  perdido e sobrava a letra solta. Mais três mensagens de menu no mesmo caso.
- **O instalador agora explica o erro.** Quando um arquivo do jogo não bate,
  ele diz se está incompleto, se foi alterado por outro mod ou se o jogo está
  numa versão diferente — comparando com o manifesto de depósito da própria
  Steam — e manda apagar só aquele arquivo antes de verificar a integridade.

---

## 📂 O que há neste repositório

| pasta | conteúdo |
|---|---|
| **`patch/`** | o pacote de tradução completo — os 22 patches, o instalador e o manifesto |
| **`videos/`** | o leia-me do pacote de vídeos (os `.mp4` vão nos Releases: 1,74 GB) |
| **`steam/`** | o guia da Steam em BBCode e a capa dele |

---

## 🙏 Créditos

**Tradução, ferramentas, fontes e legendagem de vídeo:** **Wender_sky**

Feita do zero, sem partir de nenhuma tradução existente. As traduções de
terceiros que já circulavam serviram apenas como **referência técnica** — para
entender formato de arquivo, fonte e empacotamento —, nunca como fonte de texto.

**Ferramentas de terceiros:** [OpenKH](https://github.com/Xeeynamo/OpenKh)
(extração dos pacotes `.hed`/`.pkg`) · [xdelta3](https://github.com/jmacd/xdelta)
(os patches binários) · [FFmpeg](https://ffmpeg.org/) (legendagem dos vídeos).

**KINGDOM HEARTS** é uma obra da Square Enix e da Disney. Esta é uma tradução
feita por fã, sem fins lucrativos, distribuída como patch — **não contém nenhum
arquivo do jogo original**. Uso não comercial.

<div align="center">

*"Há muitos mundos, mas eles dividem o mesmo céu — um só céu, um só destino."*

</div>

<div align="center">

# 🗝️ KINGDOM HEARTS HD 1.5+2.5 ReMIX — Tradução PT-BR

### A coletânea inteira em português brasileiro

![Versão](https://img.shields.io/badge/vers%C3%A3o-1.0-blue?style=for-the-badge)
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

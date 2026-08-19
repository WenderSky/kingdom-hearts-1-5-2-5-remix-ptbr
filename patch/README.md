<div align="center">

# KINGDOM HEARTS HD 1.5+2.5 ReMIX — Tradução PT-BR 🗝️

### A coletânea inteira em português. Um patch só.

![Versão](https://img.shields.io/badge/vers%C3%A3o-1.0-blue?style=for-the-badge)
![Jogos](https://img.shields.io/badge/6_jogos-100%25-success?style=for-the-badge)
![Download](https://img.shields.io/badge/download-18_MB-orange?style=for-the-badge)
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

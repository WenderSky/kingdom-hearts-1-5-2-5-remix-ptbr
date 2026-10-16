# v1.12.1 — o diário do Days que fechava o jogo

## 🐛 O jogo fechava na nota secreta do dia 225 (358/2 Days)

Relatado na [issue #1](https://github.com/WenderSky/kingdom-hearts-1-5-2-5-remix-ptbr/issues/1):
ao abrir a nota secreta do **dia 225** no diário do Roxas, o jogo fechava — e
só em português; em outro idioma, abria normalmente.

A nota traduzida tinha **785 caracteres**. Nenhum texto desse diário, em
nenhum dos cinco idiomas oficiais, passa de **779** — e 779 é justamente essa
mesma nota em francês. Tudo indica que o jogo reserva um espaço fixo para o
texto de cada nota, e a tradução passava dele. A nota foi reescrita mais
enxuta (**741 caracteres**, 14 linhas), sem perder nada do conteúdo, e de
quebra corrigiu um erro de digitação (`ferinhas` → `feriazinhas`).

É a única mudança desta versão: um texto, num arquivo. Os outros jogos e o
resto do 358/2 Days não mudaram.

## ⬆️ Atualizando

Rode o instalador por cima, como sempre. Ele reconhece a versão pelo
**SHA-256** de cada arquivo e aplica só a diferença — vale para qualquer versão
de 1.0 a 1.12, inclusive as duas variantes da 1.11.

Os vídeos legendados não mudaram: o pacote de vídeos continua o da 1.0,
[na release v1.0](https://github.com/WenderSky/kingdom-hearts-1-5-2-5-remix-ptbr/releases/tag/v1.0).

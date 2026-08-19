#!/bin/bash
# Instalador da traducao PT-BR de KINGDOM HEARTS HD 1.5+2.5 ReMIX - Steam Deck
#
# O SteamOS nao traz xdelta3 e o sistema e' somente leitura, entao usamos o
# aplicar_delta.py, que so' precisa do Python 3 (que ja' vem no Deck).
set -u

BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DESINSTALAR=0
MANTER_BACKUP=0
JOGO=""

while [ $# -gt 0 ]; do
  case "$1" in
    --desinstalar) DESINSTALAR=1 ;;
    --manter-backup) MANTER_BACKUP=1 ;;
    --jogo) shift; JOGO="$1" ;;
    *) echo "opcao desconhecida: $1"; exit 1 ;;
  esac
  shift
done

azul()    { printf '\033[36m%s\033[0m\n' "$1"; }
verde()   { printf '\033[32m%s\033[0m\n' "$1"; }
amarelo() { printf '\033[33m%s\033[0m\n' "$1"; }
vermelho(){ printf '\033[31m%s\033[0m\n' "$1"; }

echo
amarelo "  KINGDOM HEARTS HD 1.5+2.5 ReMIX - Traducao PT-BR"
echo    "  Traducao de Wender_sky"

if ! command -v python3 >/dev/null 2>&1; then
  vermelho "  Precisa do python3, e nao achei nenhum."
  exit 1
fi

NOME="KINGDOM HEARTS -HD 1.5+2.5 ReMIX-"
if [ -z "$JOGO" ]; then
  for b in "$HOME/.local/share/Steam/steamapps/common" \
           "$HOME/.steam/steam/steamapps/common" \
           /run/media/mmcblk0p1/steamapps/common \
           /run/media/deck/*/steamapps/common; do
    if [ -d "$b/$NOME/Image" ]; then JOGO="$b/$NOME"; break; fi
  done
fi
if [ -z "$JOGO" ] || [ ! -d "$JOGO/Image" ]; then
  vermelho "  Nao achei o jogo."
  echo    "  Rode assim:  ./instalar.sh --jogo \"/caminho/do/$NOME\""
  exit 1
fi
echo "  jogo: $JOGO"
echo

python3 - "$BASE" "$JOGO" "$DESINSTALAR" "$MANTER_BACKUP" <<'PYEOF'
import hashlib, json, os, sys, shutil
sys.path.insert(0, sys.argv[1])
from aplicar_delta import aplicar

base, jogo = sys.argv[1], sys.argv[2]
desinstalar, manter_backup = sys.argv[3] == "1", sys.argv[4] == "1"
manifesto = json.load(open(os.path.join(base, "manifesto.json"), encoding="utf-8"))
imagem = os.path.join(jogo, "Image")
print(f"  versao {manifesto['versao']}\n")

def sha(p, bloco=1 << 22):
    h = hashlib.sha256()
    with open(p, "rb") as f:
        while (pedaco := f.read(bloco)):
            h.update(pedaco)
    return h.hexdigest()

if desinstalar:
    n = 0
    for a in manifesto["arquivos"]:
        alvo = os.path.join(imagem, a["destino"])
        bkp = alvo + ".original"
        if os.path.exists(bkp):
            os.replace(bkp, alvo)
            print(f"  restaurado  {a['destino']}")
            n += 1
    if n:
        print(f"\n  {n} arquivos restaurados. O jogo voltou ao original.")
    else:
        print("\n  Nao ha' backup guardado - a instalacao apaga os originais")
        print("  depois de conferir, para nao ocupar 10 GB a' toa.")
        print("\n  Para voltar ao jogo original, va' na Steam:")
        print("    Propriedades > Arquivos instalados >")
        print("    Verificar integridade dos arquivos")
    sys.exit(0)

fazer = []
for a in manifesto["arquivos"]:
    alvo = os.path.join(imagem, a["destino"])
    if not os.path.exists(alvo):
        sys.exit(f"  FALTA {a['destino']} - o jogo esta' completo?")
    h = sha(alvo)
    if h == a["sha256_traduzido"]:
        print(f"  ja' traduzido  {a['destino']}")
        continue
    if h == a["sha256_original"]:
        fazer.append((a, alvo, alvo)); continue
    bkp = alvo + ".original"
    if os.path.exists(bkp) and sha(bkp) == a["sha256_original"]:
        fazer.append((a, alvo, bkp)); continue
    sys.exit(f"  DIFERENTE {a['destino']} - nao e' o original nem o traduzido.\n"
             "  Remova outros mods ou use 'Verificar integridade' na Steam.")

if not fazer:
    print("\n  A traducao ja' esta' instalada.")
    print("  Lembre: o idioma do jogo tem de estar em INGLES.")
    sys.exit(0)

livre = shutil.disk_usage(imagem).free
# o original de cada arquivo so' fica no disco enquanto o novo e' escrito e
# conferido, entao o pico e' o maior arquivo - nao a soma de todos
tamanhos = [a["bytes_original"] for a, _, _ in fazer]
precisa = sum(tamanhos) if manter_backup else max(tamanhos)
print(f"\n  aplicando {len(fazer)} arquivos "
      f"(precisa de {precisa/2**30:.1f} GB, livre {livre/2**30:.1f} GB)")
if livre < precisa * 1.1:
    sys.exit("  Espaco insuficiente. Libere espaco e tente de novo.")
print("  isto leva alguns minutos - o arquivo maior tem 3 GB")

for a, alvo, fonte in fazer:
    if fonte == alvo:
        os.replace(alvo, alvo + ".original")
        fonte = alvo + ".original"
    aplicar(fonte, os.path.join(base, "patch", a["delta"]), alvo)
    if sha(alvo) != a["sha256_traduzido"]:
        os.remove(alvo)
        os.replace(fonte, alvo)
        sys.exit(f"  ERRO: {a['destino']} saiu diferente do esperado.")
    # o hash conferiu: o original ja' nao serve para nada
    if not manter_backup and os.path.exists(fonte) and fonte != alvo:
        os.remove(fonte)
    print(f"  ok          {a['destino']}")

print("\n  Pronto! A traducao foi instalada.")
print("  IMPORTANTE: abra o jogo e deixe o idioma em INGLES.")
if not manter_backup:
    print("\n  Para desfazer, use 'Verificar integridade dos arquivos'")
    print("  nas propriedades do jogo na Steam.")
PYEOF

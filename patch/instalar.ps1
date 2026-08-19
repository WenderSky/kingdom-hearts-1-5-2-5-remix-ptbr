# Instalador da traducao PT-BR de KINGDOM HEARTS HD 1.5+2.5 ReMIX
# Aplica os patches .xdelta sobre os arquivos originais do jogo.
param(
    [string]$Jogo = "",
    [switch]$Desinstalar,
    [switch]$ManterBackup
)

$ErrorActionPreference = "Stop"
$Base = Split-Path -Parent $MyInvocation.MyCommand.Path
$Xdelta = Join-Path $Base "xdelta3.exe"

function Titulo($t) {
    Write-Host ""
    Write-Host "  $t" -ForegroundColor Cyan
    Write-Host "  $('-' * $t.Length)" -ForegroundColor DarkGray
}

function Hash256($caminho) {
    (Get-FileHash -Algorithm SHA256 -LiteralPath $caminho).Hash.ToLower()
}

# ------------------------------------------------------------- progresso
# Tudo aqui e' medido em BYTES, nao em arquivos: o kh2_fifth.pkg tem 10,8 GB e
# o kh1_first.hed tem 19 KB. Uma barra por contagem de arquivo andaria depressa
# no comeco e congelaria no fim, que e' pior que nao ter barra.
$Global:BarraTotal = 0      # quanto ha' para fazer, nesta fase
$Global:BarraFeito = 0      # quanto ja' foi feito
$Global:BarraRotulo = ""
$Global:BarraUltimo = -1

function IniciarBarra($total, $rotulo) {
    $Global:BarraTotal = [double]$total
    $Global:BarraFeito = 0
    $Global:BarraRotulo = $rotulo
    $Global:BarraUltimo = -1
    DesenharBarra 0
}

function DesenharBarra($extra) {
    if ($Global:BarraTotal -le 0) { return }
    $feito = $Global:BarraFeito + $extra
    $pct = [int][Math]::Floor(100 * $feito / $Global:BarraTotal)
    if ($pct -gt 100) { $pct = 100 }
    if ($pct -lt 0) { $pct = 0 }
    # so' redesenha quando o numero muda: escrever a cada bloco de 4 MB deixa
    # o console lento e a barra tremida
    if ($pct -eq $Global:BarraUltimo) { return }
    $Global:BarraUltimo = $pct
    $cheio = [int]($pct * 28 / 100)
    $barra = ("#" * $cheio) + ("." * (28 - $cheio))
    $linha = "  [{0}] {1,3}%  {2}" -f $barra, $pct, $Global:BarraRotulo
    if ($linha.Length -gt 78) { $linha = $linha.Substring(0, 78) }
    Write-Host ("`r" + $linha.PadRight(79)) -NoNewline -ForegroundColor Cyan
}

function AndarBarra($quanto, $rotulo) {
    $Global:BarraFeito += $quanto
    if ($rotulo) { $Global:BarraRotulo = $rotulo }
    DesenharBarra 0
}

function FecharBarra($mensagem) {
    Write-Host ("`r" + (" " * 79)) -NoNewline
    Write-Host ("`r  " + $mensagem) -ForegroundColor Green
}

# SHA-256 lido em blocos, para a barra andar durante a conta. O Get-FileHash
# faria o mesmo trabalho, mas de uma vez so' e sem dizer nada -- e sao 27 GB.
function Hash256Andando($caminho) {
    $sha = [System.Security.Cryptography.SHA256]::Create()
    $fs = [System.IO.File]::OpenRead($caminho)
    try {
        $buf = New-Object byte[] (4 * 1024 * 1024)
        while ($true) {
            $n = $fs.Read($buf, 0, $buf.Length)
            if ($n -le 0) { break }
            [void]$sha.TransformBlock($buf, 0, $n, $null, 0)
            AndarBarra $n $null
        }
        [void]$sha.TransformFinalBlock($buf, 0, 0)
        return ([BitConverter]::ToString($sha.Hash) -replace '-', '').ToLower()
    } finally {
        $fs.Dispose()
        $sha.Dispose()
    }
}

function AcharJogo {
    $nome = "KINGDOM HEARTS -HD 1.5+2.5 ReMIX-"
    # 1. onde a Steam esta' instalada
    $steam = $null
    try {
        $steam = (Get-ItemProperty "HKCU:\Software\Valve\Steam" -Name SteamPath -ErrorAction Stop).SteamPath
    } catch {}
    $bibliotecas = @()
    if ($steam) {
        $bibliotecas += Join-Path $steam "steamapps\common"
        # 2. as outras bibliotecas, listadas no libraryfolders.vdf
        $vdf = Join-Path $steam "steamapps\libraryfolders.vdf"
        if (Test-Path $vdf) {
            foreach ($linha in Get-Content $vdf) {
                if ($linha -match '"path"\s+"(.+)"') {
                    $bibliotecas += Join-Path ($matches[1] -replace '\\\\', '\') "steamapps\common"
                }
            }
        }
    }
    # 3. as letras de unidade, por garantia
    foreach ($d in (Get-PSDrive -PSProvider FileSystem)) {
        $bibliotecas += "$($d.Name):\SteamLibrary\steamapps\common"
        $bibliotecas += "$($d.Name):\Program Files (x86)\Steam\steamapps\common"
    }
    foreach ($b in $bibliotecas) {
        $tentativa = Join-Path $b $nome
        if (Test-Path (Join-Path $tentativa "Image")) { return $tentativa }
    }
    return $null
}

# ---------------------------------------------------------------- inicio
Write-Host ""
Write-Host "  KINGDOM HEARTS HD 1.5+2.5 ReMIX - Traducao PT-BR" -ForegroundColor Yellow
Write-Host "  Traducao de Wender_sky" -ForegroundColor DarkGray

$manifesto = Get-Content (Join-Path $Base "manifesto.json") -Raw -Encoding UTF8 | ConvertFrom-Json
Write-Host "  versao $($manifesto.versao)" -ForegroundColor DarkGray

if (-not $Jogo) { $Jogo = AcharJogo }
if (-not $Jogo -or -not (Test-Path (Join-Path $Jogo "Image"))) {
    Titulo "Nao achei o jogo"
    Write-Host "  Rode assim, com o caminho da pasta do jogo:"
    Write-Host '    .\instalar.ps1 -Jogo "D:\SteamLibrary\steamapps\common\KINGDOM HEARTS -HD 1.5+2.5 ReMIX-"'
    exit 1
}
Write-Host "  jogo: $Jogo" -ForegroundColor DarkGray

# ------------------------------------------------------------ desinstalar
if ($Desinstalar) {
    Titulo "Desinstalando"
    $n = 0
    foreach ($a in $manifesto.arquivos) {
        $alvo = Join-Path (Join-Path $Jogo "Image") $a.destino
        $bkp = "$alvo.original"
        if (Test-Path $bkp) {
            Remove-Item -LiteralPath $alvo -Force -ErrorAction SilentlyContinue
            Move-Item -LiteralPath $bkp -Destination $alvo -Force
            Write-Host "  restaurado  $($a.destino)" -ForegroundColor Green
            $n++
        } else {
            Write-Host "  sem backup  $($a.destino)" -ForegroundColor DarkGray
        }
    }
    Write-Host ""
    if ($n -gt 0) {
        Write-Host "  $n arquivos restaurados. O jogo voltou ao original." -ForegroundColor Green
    } else {
        Write-Host "  Nao ha' backup guardado - a instalacao apaga os originais" -ForegroundColor Yellow
        Write-Host "  depois de conferir, para nao ocupar 10 GB a' toa." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "  Para voltar ao jogo original:" -ForegroundColor Cyan
        Write-Host "    Steam > botao direito no jogo > Propriedades >" -ForegroundColor Cyan
        Write-Host "    Arquivos instalados > Verificar integridade dos arquivos" -ForegroundColor Cyan
    }
    exit 0
}

# --------------------------------------------------------------- conferir
Titulo "Conferindo os arquivos do jogo"
$fazer = @()
$prontos = 0
$totalConferir = ($manifesto.arquivos | ForEach-Object { $_.bytes_original } | Measure-Object -Sum).Sum
IniciarBarra $totalConferir "lendo os arquivos do jogo"
foreach ($a in $manifesto.arquivos) {
    $alvo = Join-Path (Join-Path $Jogo "Image") $a.destino
    if (-not (Test-Path $alvo)) {
        FecharBarra ""
        Write-Host "  FALTA       $($a.destino)" -ForegroundColor Red
        Write-Host ""
        Write-Host "  Esse arquivo nao existe. O jogo esta' completo?" -ForegroundColor Red
        exit 1
    }
    $Global:BarraRotulo = $a.destino
    $h = Hash256Andando $alvo
    if ($h -eq $a.sha256_traduzido) {
        $prontos++
        continue
    }
    if ($h -eq $a.sha256_original) {
        $fazer += @{ arquivo = $a; alvo = $alvo; fonte = $alvo }
        continue
    }
    # nao bate: talvez o original esteja guardado do lado
    $bkp = "$alvo.original"
    if ((Test-Path $bkp) -and (Hash256 $bkp) -eq $a.sha256_original) {
        $fazer += @{ arquivo = $a; alvo = $alvo; fonte = $bkp }
        continue
    }
    FecharBarra ""
    Write-Host "  DIFERENTE   $($a.destino)" -ForegroundColor Red
    Write-Host ""
    Write-Host "  Esse arquivo nao e' o original nem o traduzido." -ForegroundColor Red
    Write-Host "  Se voce tem outro mod instalado, remova primeiro." -ForegroundColor Yellow
    Write-Host "  Ou use 'Verificar integridade dos arquivos' na Steam" -ForegroundColor Yellow
    Write-Host "  para voltar ao original e rode este instalador de novo." -ForegroundColor Yellow
    exit 1
}
FecharBarra ("conferidos {0} arquivos: {1} a traduzir, {2} ja' prontos" -f `
    $manifesto.arquivos.Count, $fazer.Count, $prontos)

if ($fazer.Count -eq 0) {
    Write-Host ""
    Write-Host "  A traducao ja' esta' instalada." -ForegroundColor Green
    Write-Host "  Lembre: o idioma do jogo tem de estar em INGLES." -ForegroundColor Yellow
    exit 0
}

# ---------------------------------------------------------------- aplicar
Titulo "Aplicando a traducao"
# O original de cada arquivo e' guardado so' enquanto o novo e' escrito e
# conferido; depois disso ele some. O pico de espaco e' o maior arquivo, nao a
# soma de todos.
$maior = ($fazer | ForEach-Object { $_.arquivo.bytes_original } | Measure-Object -Maximum).Maximum
if ($ManterBackup) {
    $maior = ($fazer | ForEach-Object { $_.arquivo.bytes_original } | Measure-Object -Sum).Sum
    Write-Host ("  guardando backup: mais {0:N1} GB no disco" -f ($maior / 1GB)) -ForegroundColor DarkGray
}
$unidade = (Get-Item $Jogo).PSDrive
$livre = (Get-PSDrive $unidade.Name).Free
if ($livre -lt $maior * 1.1) {
    Write-Host ("  Espaco insuficiente: preciso de {0:N1} GB livres, ha' {1:N1} GB." -f `
        ($maior * 1.1 / 1GB), ($livre / 1GB)) -ForegroundColor Red
    exit 1
}

# cada arquivo custa duas passadas: escrever o novo e conferir o hash dele
$totalAplicar = 2 * (($fazer | ForEach-Object { $_.arquivo.bytes_original } |
    Measure-Object -Sum).Sum)
IniciarBarra $totalAplicar "aplicando"

foreach ($item in $fazer) {
    $a = $item.arquivo
    $alvo = $item.alvo
    $fonte = $item.fonte
    $bkp = "$alvo.original"

    if ($fonte -eq $alvo) {
        # guarda o original antes de sobrescrever.
        #
        # Tenta mais de uma vez de proposito: logo depois de a Steam baixar ou
        # verificar um .pkg de varios GB, o antivirus do Windows ainda esta'
        # com o arquivo aberto e o Move-Item falha com "esta' sendo usado por
        # outro processo". E' transitorio -- alguns segundos resolvem, e sem a
        # espera o instalador parava no meio da lista.
        $movido = $false
        foreach ($tentativa in 1..6) {
            try {
                Move-Item -LiteralPath $alvo -Destination $bkp -Force -ErrorAction Stop
                $movido = $true
                break
            } catch {
                if ($tentativa -eq 1) {
                    $Global:BarraRotulo = "$($a.destino) - em uso, aguardando"
                    DesenharBarra 0
                }
                Start-Sleep -Seconds 5
            }
        }
        if (-not $movido) {
            Write-Host "  ERRO: $($a.destino) esta' em uso e nao consegui mexer nele." -ForegroundColor Red
            Write-Host "  Feche a Steam e o jogo e rode o instalador de novo." -ForegroundColor Yellow
            exit 1
        }
        $fonte = $bkp
    }
    $delta = Join-Path (Join-Path $Base "patch") $a.delta
    # o xdelta3 nao informa progresso, mas o arquivo que ele escreve cresce --
    # e' dai' que sai a fracao deste arquivo
    $Global:BarraRotulo = $a.destino
    # !! NAO usar Start-Process aqui. Sem -Wait ele devolve um objeto cujo
    # ExitCode nao e' preenchido: o xdelta3 escrevia o arquivo inteiro e o
    # instalador acusava "ERRO ao aplicar" mesmo assim. Com o ProcessStartInfo
    # o codigo de saida e' o de verdade, e as aspas dos caminhos (que tem
    # espaco) ficam explicitas na linha de comando.
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $Xdelta
    $psi.Arguments = '-d -f -s "{0}" "{1}" "{2}"' -f $fonte, $delta, $alvo
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true
    $proc = [System.Diagnostics.Process]::Start($psi)
    while (-not $proc.HasExited) {
        Start-Sleep -Milliseconds 200
        $escrito = 0
        try { $escrito = (Get-Item -LiteralPath $alvo -ErrorAction Stop).Length } catch {}
        if ($escrito -gt $a.bytes_original) { $escrito = $a.bytes_original }
        DesenharBarra $escrito
    }
    $proc.WaitForExit()
    if ($proc.ExitCode -ne 0) {
        FecharBarra ""
        Write-Host "  ERRO ao aplicar $($a.destino)" -ForegroundColor Red
        Move-Item -LiteralPath $bkp -Destination $alvo -Force -ErrorAction SilentlyContinue
        exit 1
    }
    AndarBarra $a.bytes_original $null
    if ((Hash256Andando $alvo) -ne $a.sha256_traduzido) {
        FecharBarra ""
        Write-Host "  ERRO: $($a.destino) saiu diferente do esperado" -ForegroundColor Red
        Remove-Item -LiteralPath $alvo -Force
        Move-Item -LiteralPath $bkp -Destination $alvo -Force
        exit 1
    }
    # o hash conferiu: o original ja' nao serve para nada
    if (-not $ManterBackup) {
        Remove-Item -LiteralPath $bkp -Force -ErrorAction SilentlyContinue
    }
}
FecharBarra ("{0} arquivos traduzidos" -f $fazer.Count)

Titulo "Pronto"
Write-Host "  A traducao foi instalada." -ForegroundColor Green
Write-Host ""
Write-Host "  IMPORTANTE: abra o jogo e deixe o idioma em INGLES." -ForegroundColor Yellow
Write-Host "  E' o slot que a traducao ocupa." -ForegroundColor Yellow
Write-Host ""
if ($ManterBackup) {
    Write-Host "  Para desfazer: Desinstalar.bat" -ForegroundColor DarkGray
} else {
    Write-Host "  Para desfazer, use 'Verificar integridade dos arquivos'" -ForegroundColor DarkGray
    Write-Host "  nas propriedades do jogo na Steam." -ForegroundColor DarkGray
}
exit 0

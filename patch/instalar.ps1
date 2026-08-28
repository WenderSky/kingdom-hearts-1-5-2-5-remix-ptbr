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

# Junta caminho SEM cobrar que a unidade exista.
# O `Join-Path` do PowerShell resolve o PSDrive e **falha** com
# `DriveNotFoundException` quando o caminho aponta para um disco que nao
# esta' ligado. Isso derrubava o instalador de quem tem, no
# `libraryfolders.vdf` da Steam, uma biblioteca num HD que saiu da
# maquina: o arquivo continua listando a unidade, ela nao existe mais, e
# o instalador morria antes de procurar o jogo (relatado na v1.5).
# Aqui o caminho e' so' texto -- quem decide se existe e' o `Test-Path`.
function Unir($a, $b) {
    if (-not $a) { return $b }
    return ($a.TrimEnd('\\') + '\\' + $b.TrimStart('\\'))
}

function Titulo($t) {
    Write-Host ""
    Write-Host "  $t" -ForegroundColor Cyan
    Write-Host "  $('-' * $t.Length)" -ForegroundColor DarkGray
}

function Hash256($caminho) {
    (Get-FileHash -Algorithm SHA256 -LiteralPath $caminho).Hash.ToLower()
}

function Hash1($caminho) {
    (Get-FileHash -Algorithm SHA1 -LiteralPath $caminho).Hash.ToLower()
}

# ---------------------------------------------------- o que a Steam entrega
# Quando um arquivo do jogo nao bate com o original nem com o traduzido, a
# pergunta e' "voce mexeu nele" ou "seu jogo e' de outra versao?". Quem sabe
# responder e' a propria Steam: o `depotcache\2552433_*.manifest` do jogador
# lista, para cada arquivo do deposito, nome, tamanho e o **SHA-1 do arquivo
# inteiro** (conferido em tres arquivos desta instalacao).
#
# O .manifest e' protobuf. Depois do nome vem, em sequencia:
#   campo 2 tamanho (varint)   3 flags   4 SHA-1 do nome   5 SHA-1 do conteudo
#
# Le-se o arquivo como ASCII so' para achar o nome: cada byte vira um char, o
# indice e' o mesmo, e ai' o parse continua nos bytes crus.
function DepotEntrada($destino) {
    try {
        $steam = (Get-ItemProperty "HKCU:\Software\Valve\Steam" -Name SteamPath -ErrorAction Stop).SteamPath
    } catch { return $null }
    $cache = Unir $steam "depotcache"
    if (-not (Test-Path $cache)) { return $null }
    $arq = Get-ChildItem -LiteralPath $cache -Filter "2552433_*.manifest" -ErrorAction SilentlyContinue |
           Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if (-not $arq) { return $null }
    try {
        $bytes = [System.IO.File]::ReadAllBytes($arq.FullName)
        $texto = [System.Text.Encoding]::ASCII.GetString($bytes)
    } catch { return $null }
    $nome = "Image\" + ($destino -replace '/', '\')
    $i = $texto.IndexOf($nome)
    if ($i -lt 0) { return $null }
    $j = $i + $nome.Length
    $campos = @{}
    while ($j -lt $bytes.Length) {
        $chave = 0; $desl = 0
        while ($j -lt $bytes.Length) {
            $b = $bytes[$j]; $j++
            $chave = $chave -bor (($b -band 0x7f) -shl $desl); $desl += 7
            if (-not ($b -band 0x80)) { break }
        }
        $campo = $chave -shr 3; $tipo = $chave -band 7
        if ($campo -gt 6 -or $campos.ContainsKey($campo)) { break }
        if ($tipo -eq 0) {
            $v = [uint64]0; $desl = 0
            while ($j -lt $bytes.Length) {
                $b = $bytes[$j]; $j++
                $v = $v -bor ([uint64]($b -band 0x7f) -shl $desl); $desl += 7
                if (-not ($b -band 0x80)) { break }
            }
            $campos[$campo] = $v
        } elseif ($tipo -eq 2) {
            $ln = 0; $desl = 0
            while ($j -lt $bytes.Length) {
                $b = $bytes[$j]; $j++
                $ln = $ln -bor (($b -band 0x7f) -shl $desl); $desl += 7
                if (-not ($b -band 0x80)) { break }
            }
            if ($ln -eq 20 -and ($j + 19) -lt $bytes.Length) {
                $campos[$campo] = (($bytes[$j..($j + 19)] |
                    ForEach-Object { $_.ToString("x2") }) -join "")
            }
            $j += $ln
        } else { break }
        if ($campo -eq 5) { break }
    }
    if (-not $campos.ContainsKey(2)) { return $null }
    return @{ tamanho = [int64]$campos[2]; sha1 = $campos[5] }
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
        $bibliotecas += Unir $steam "steamapps\common"
        # 2. as outras bibliotecas, listadas no libraryfolders.vdf
        $vdf = Unir $steam "steamapps\libraryfolders.vdf"
        if (Test-Path $vdf) {
            foreach ($linha in Get-Content $vdf) {
                if ($linha -match '"path"\s+"(.+)"') {
                    $bibliotecas += Unir ($matches[1] -replace '\\\\', '\') "steamapps\common"
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
        $tentativa = Unir $b $nome
        if (Test-Path (Unir $tentativa "Image")) { return $tentativa }
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
if (-not $Jogo -or -not (Test-Path (Unir $Jogo "Image"))) {
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
        $alvo = Unir (Unir $Jogo "Image") $a.destino
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
    $alvo = Unir (Unir $Jogo "Image") $a.destino
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
    # ...ou o jogador tem uma VERSAO ANTERIOR desta traducao instalada. Sem
    # isto ele so' teria a saida de rebaixar 14 GB pela Steam para depois
    # aplicar o patch inteiro de novo: o arquivo dele nao e' o de fabrica nem
    # o traduzido desta versao, e o instalador o recusava como "DIFERENTE".
    $atualizacao = $null
    foreach ($v in @($a.atualizacoes)) {
        if ($v -and $v.de -eq $h) { $atualizacao = $v; break }
    }
    if ($atualizacao) {
        $fazer += @{ arquivo = $a; alvo = $alvo; fonte = $alvo;
                     delta = $atualizacao.delta; versao = $atualizacao.versao }
        continue
    }
    FecharBarra ""
    Write-Host "  DIFERENTE   $($a.destino)" -ForegroundColor Red
    Write-Host ""
    Write-Host "  Esse arquivo nao e' o original nem o traduzido." -ForegroundColor Red
    # o tamanho ja' separa "download pela metade" de "conteudo trocado", e e'
    # de graca: um arquivo de 10,8 GB truncado e' o caso mais comum
    $tam = (Get-Item -LiteralPath $alvo).Length
    if ($tam -lt $a.bytes_original) {
        Write-Host ("  Ele tem {0:N0} bytes e o de fabrica tem {1:N0}: esta' INCOMPLETO." -f `
            $tam, $a.bytes_original) -ForegroundColor Red
        Write-Host "  O download da Steam nao terminou, ou faltou espaco em disco." -ForegroundColor Yellow
    } elseif ($tam -ne $a.bytes_original) {
        Write-Host ("  Ele tem {0:N0} bytes e o de fabrica tem {1:N0}." -f `
            $tam, $a.bytes_original) -ForegroundColor Red
    } else {
        Write-Host "  O tamanho e' o de fabrica; o conteudo e' que nao e'." -ForegroundColor Red
    }
    $depot = DepotEntrada $a.destino
    if ($depot) {
        if ($depot.tamanho -ne $a.bytes_original) {
            Write-Host ""
            Write-Host "  A Steam diz que o original deste arquivo tem" -ForegroundColor Yellow
            Write-Host ("  {0:N0} bytes nesta maquina: seu jogo esta' numa VERSAO" -f $depot.tamanho) -ForegroundColor Yellow
            Write-Host "  diferente da que este patch conhece. Avise o autor da" -ForegroundColor Yellow
            Write-Host "  traducao -- nenhum patch vai servir ate' ele refazer." -ForegroundColor Yellow
            exit 1
        }
        if ($depot.sha1 -and (Hash1 $alvo) -eq $depot.sha1) {
            Write-Host ""
            Write-Host "  Mas a Steam diz que ELE E' o arquivo de fabrica -- entao o" -ForegroundColor Yellow
            Write-Host "  errado esta' no patch. Avise o autor da traducao." -ForegroundColor Yellow
            exit 1
        }
        Write-Host "  Conferido com a Steam: nao e' o arquivo de fabrica." -ForegroundColor Red
    }
    Write-Host ""
    Write-Host "  Como consertar:" -ForegroundColor Yellow
    Write-Host "    1. apague este arquivo:"
    Write-Host "       $alvo" -ForegroundColor White
    Write-Host "    2. na Steam: botao direito no jogo > Propriedades >"
    Write-Host "       Arquivos instalados > Verificar integridade dos arquivos"
    Write-Host "       (assim a Steam rebaixa so' ele)"
    Write-Host "    3. rode este instalador de novo"
    Write-Host ""
    Write-Host "  Se voce tem outro mod ou outra traducao instalada, remova antes." -ForegroundColor Yellow
    exit 1
}
FecharBarra ("conferidos {0} arquivos: {1} a traduzir, {2} ja' prontos" -f `
    $manifesto.arquivos.Count, $fazer.Count, $prontos)
$atualizando = @($fazer | Where-Object { $_.delta }).Count
if ($atualizando) {
    Write-Host ("  {0} arquivo(s) vem de uma versao anterior da traducao - " +
                "atualizando no lugar" -f $atualizando) -ForegroundColor Green
}

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
    # arquivo vindo de uma versao anterior da traducao usa o delta dela
    $nomeDelta = if ($item.delta) { $item.delta } else { $a.delta }
    $delta = Join-Path (Join-Path $Base "patch") $nomeDelta
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

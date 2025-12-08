#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Limpeza Profunda do Sistema
    
.DESCRIPTION
    Script para limpeza profunda do sistema Windows incluindo temporários,
    cache de navegadores, lixeira, prefetch e logs antigos
    Sistema mm.ti Lab v1.0
    
.NOTES
    Script criado por: Marlon Motta e equipe
    Email: marlonmotta.ti@gmail.com
    Versão: 1.0
#>

# ============================================================================
# CONFIGURAÇÕES INICIAIS
# ============================================================================
$Host.UI.RawUI.WindowTitle = "Limpeza Profunda do Sistema - mm.ti Lab"
$ErrorActionPreference = "Continue"
$ScriptVersion = "1.0"

# Cores
$SuccessColor = "Green"
$WarningColor = "Yellow"
$ErrorColor = "Red"
$InfoColor = "Cyan"

# ============================================================================
# VERIFICAÇÃO DE PRIVILÉGIOS ADMINISTRATIVOS
# ============================================================================
function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Administrator)) {
    Write-Host ""
    Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Red
    Write-Host "║  ERRO: Este script precisa ser executado como         ║" -ForegroundColor Red
    Write-Host "║  ADMINISTRADOR!                                        ║" -ForegroundColor Red
    Write-Host "║                                                        ║" -ForegroundColor Red
    Write-Host "║  Clique com o botão direito e escolha:                ║" -ForegroundColor Red
    Write-Host "║  'Executar com PowerShell como Administrador'         ║" -ForegroundColor Red
    Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Red
    Write-Host ""
    Read-Host "Pressione Enter para sair"
    exit 1
}

# ============================================================================
# INTERFACE INICIAL
# ============================================================================
Clear-Host
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        LIMPEZA PROFUNDA DO SISTEMA WINDOWS           ║" -ForegroundColor Cyan
Write-Host "║                  mm.ti Lab Toolkit                     ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  Este script irá limpar:                              ║" -ForegroundColor Cyan
Write-Host "║  1. Arquivos temporários (%TEMP%)                     ║" -ForegroundColor Cyan
Write-Host "║  2. Cache de navegadores (Chrome, Edge, Firefox)      ║" -ForegroundColor Cyan
Write-Host "║  3. Lixeira                                            ║" -ForegroundColor Cyan
Write-Host "║  4. Prefetch                                           ║" -ForegroundColor Cyan
Write-Host "║  5. Logs antigos do sistema                           ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  ⚠️  ATENÇÃO: Esta operação pode demorar alguns       ║" -ForegroundColor Yellow
Write-Host "║  minutos dependendo da quantidade de arquivos.        ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$confirmacao = Read-Host "Deseja continuar? (S/N)"
if ($confirmacao -notmatch '^[Ss]$') {
    Write-Host "`nOperação cancelada pelo usuário." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    exit 0
}

# ============================================================================
# CONFIGURAÇÃO DE LOGS
# ============================================================================
$LogDir = "C:\mmti-toolkit-logs"
if (-not (Test-Path $LogDir)) {
    New-Item -Path $LogDir -ItemType Directory -Force | Out-Null
}

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$LogFile = "$LogDir\clean-system_$timestamp.log"

function Write-Log {
    param([string]$Message)
    $logMessage = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message"
    Add-Content -Path $LogFile -Value $logMessage
}

Write-Log "========== INÍCIO DA LIMPEZA PROFUNDA =========="
Write-Log "Sistema: $([Environment]::OSVersion.VersionString)"

# Variáveis para calcular espaço liberado
$espacoInicial = (Get-PSDrive C).Used
$totalArquivos = 0

# ============================================================================
# ETAPA 1: Limpeza de Temporários
# ============================================================================
Clear-Host
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [1/5] Limpando Arquivos Temporários                  │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza Profunda" -Status "Limpando temporários" -PercentComplete 10

Write-Log "========== Limpeza Temporários =========="
try {
    Write-Host "Limpando pasta Windows\Temp..." -ForegroundColor White
    $tempCount = (Get-ChildItem "$env:SystemRoot\Temp" -ErrorAction SilentlyContinue | Measure-Object).Count
    Remove-Item "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    $totalArquivos += $tempCount
    Write-Host "[OK] $tempCount arquivos removidos de Windows\Temp" -ForegroundColor Green
    Write-Log "Removidos $tempCount arquivos de Windows\Temp"
    
    Write-Host "Limpando pasta Temp do usuário..." -ForegroundColor White
    $userTempCount = (Get-ChildItem "$env:TEMP" -ErrorAction SilentlyContinue | Measure-Object).Count
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    $totalArquivos += $userTempCount
    Write-Host "[OK] $userTempCount arquivos removidos de %TEMP%" -ForegroundColor Green
    Write-Log "Removidos $userTempCount arquivos de %TEMP%"
} catch {
    Write-Host "[AVISO] Alguns arquivos não puderam ser removidos" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 2: Limpeza de Cache de Navegadores
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [2/5] Limpando Cache de Navegadores                  │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza Profunda" -Status "Limpando cache de navegadores" -PercentComplete 30

Write-Log "========== Limpeza Cache Navegadores =========="
$cachePaths = @(
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache",
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Code Cache",
    "$env:APPDATA\Mozilla\Firefox\Profiles"
)

foreach ($path in $cachePaths) {
    if (Test-Path $path) {
        try {
            $cacheCount = (Get-ChildItem $path -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count
            Remove-Item "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
            $totalArquivos += $cacheCount
            $browser = Split-Path (Split-Path $path -Parent) -Leaf
            Write-Host "[OK] Cache do $browser limpo ($cacheCount arquivos)" -ForegroundColor Green
            Write-Log "Cache do $browser limpo: $cacheCount arquivos"
        } catch {
            Write-Host "[AVISO] Não foi possível limpar cache de $path" -ForegroundColor Yellow
            Write-Log "Aviso: $($_.Exception.Message)"
        }
    }
}

# ============================================================================
# ETAPA 3: Limpeza da Lixeira
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [3/5] Esvaziando Lixeira                              │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza Profunda" -Status "Esvaziando lixeira" -PercentComplete 50

Write-Log "========== Limpeza Lixeira =========="
try {
    Write-Host "Esvaziando lixeira..." -ForegroundColor White
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    Write-Host "[OK] Lixeira esvaziada!" -ForegroundColor Green
    Write-Log "Lixeira esvaziada com sucesso"
} catch {
    Write-Host "[AVISO] Não foi possível esvaziar a lixeira completamente" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 4: Limpeza de Prefetch
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [4/5] Limpando Prefetch                               │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza Profunda" -Status "Limpando prefetch" -PercentComplete 70

Write-Log "========== Limpeza Prefetch =========="
try {
    $prefetchPath = "$env:SystemRoot\Prefetch"
    if (Test-Path $prefetchPath) {
        Write-Host "Limpando pasta Prefetch..." -ForegroundColor White
        $prefetchCount = (Get-ChildItem $prefetchPath -ErrorAction SilentlyContinue | Measure-Object).Count
        Remove-Item "$prefetchPath\*" -Force -ErrorAction SilentlyContinue
        $totalArquivos += $prefetchCount
        Write-Host "[OK] $prefetchCount arquivos de prefetch removidos" -ForegroundColor Green
        Write-Log "Removidos $prefetchCount arquivos de prefetch"
    }
} catch {
    Write-Host "[AVISO] Não foi possível limpar prefetch completamente" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 5: Limpeza de Logs Antigos
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [5/5] Limpando Logs Antigos do Sistema               │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza Profunda" -Status "Limpando logs antigos" -PercentComplete 85

Write-Log "========== Limpeza Logs Antigos =========="
try {
    $logPaths = @(
        "$env:SystemRoot\Logs\CBS",
        "$env:SystemRoot\Logs\DISM",
        "$env:SystemRoot\Logs\WindowsUpdate"
    )
    
    foreach ($logPath in $logPaths) {
        if (Test-Path $logPath) {
            $logs = Get-ChildItem $logPath -Recurse -File -ErrorAction SilentlyContinue | 
                    Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) }
            $logCount = ($logs | Measure-Object).Count
            if ($logCount -gt 0) {
                $logs | Remove-Item -Force -ErrorAction SilentlyContinue
                $totalArquivos += $logCount
                $folderName = Split-Path $logPath -Leaf
                Write-Host "[OK] $logCount logs antigos removidos de $folderName" -ForegroundColor Green
                Write-Log "Removidos $logCount logs antigos de $folderName"
            }
        }
    }
} catch {
    Write-Host "[AVISO] Alguns logs não puderam ser removidos" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# CALCULAR ESPAÇO LIBERADO
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ Calculando Espaço Liberado                            │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza Profunda" -Status "Calculando espaço liberado" -PercentComplete 95

Start-Sleep -Seconds 3
$espacoFinal = (Get-PSDrive C).Used
$espacoLiberado = $espacoInicial - $espacoFinal

if ($espacoLiberado -lt 0) { $espacoLiberado = 0 }

$espacoMB = [math]::Round($espacoLiberado / 1MB, 2)
$espacoGB = [math]::Round($espacoLiberado / 1GB, 2)

# ============================================================================
# RESUMO FINAL
# ============================================================================
Write-Progress -Activity "Limpeza Profunda" -Status "Concluído!" -PercentComplete 100 -Completed

Clear-Host
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║      🎉 LIMPEZA PROFUNDA CONCLUÍDA COM SUCESSO!      ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "┌─ RESUMO ───────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│                                                        │" -ForegroundColor Cyan
Write-Host "│  ✓ Arquivos temporários limpos                        │" -ForegroundColor Green
Write-Host "│  ✓ Cache de navegadores limpo                         │" -ForegroundColor Green
Write-Host "│  ✓ Lixeira esvaziada                                  │" -ForegroundColor Green
Write-Host "│  ✓ Prefetch limpo                                     │" -ForegroundColor Green
Write-Host "│  ✓ Logs antigos removidos                             │" -ForegroundColor Green
Write-Host "│                                                        │" -ForegroundColor Cyan
Write-Host "│  📊 Total de arquivos processados: $($totalArquivos.ToString().PadLeft(10))        │" -ForegroundColor Yellow
if ($espacoGB -gt 0) {
    Write-Host "│  💾 Espaço liberado: ~$espacoGB GB ($espacoMB MB)              │" -ForegroundColor Yellow
} else {
    Write-Host "│  💾 Espaço liberado: ~$espacoMB MB                              │" -ForegroundColor Yellow
}
Write-Host "│                                                        │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""
Write-Host "📂 LOG DETALHADO SALVO EM:" -ForegroundColor Cyan
Write-Host "   $LogFile" -ForegroundColor White
Write-Host ""
Write-Host "───────────────────────────────────────────────────────────" -ForegroundColor Gray
Write-Host ""
Write-Host "Sistema mm.ti Lab - PC Toolkit v$ScriptVersion" -ForegroundColor Gray
Write-Host "Script criado por Marlon Motta e equipe" -ForegroundColor Gray
Write-Host "Email: marlonmotta.ti@gmail.com" -ForegroundColor Gray
Write-Host ""

Write-Log "Total de arquivos processados: $totalArquivos"
Write-Log "Espaço liberado: $espacoMB MB ($espacoGB GB)"
Write-Log "========== FIM DA LIMPEZA PROFUNDA =========="

Write-Host "Pressione qualquer tecla para fechar..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')


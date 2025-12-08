#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Limpeza Rápida de Arquivos Temporários
    
.DESCRIPTION
    Script para limpeza rápida de arquivos temporários, lixeira e logs básicos
    Sistema mm.ti Lab v1.0
    
.NOTES
    Script criado por: Marlon Motta e equipe
    Email: marlonmotta.ti@gmail.com
    Versão: 1.0
#>

# ============================================================================
# CONFIGURAÇÕES INICIAIS
# ============================================================================
$Host.UI.RawUI.WindowTitle = "Limpeza Rápida de Temporários - mm.ti Lab"
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
Write-Host "║     LIMPEZA RÁPIDA DE ARQUIVOS TEMPORÁRIOS            ║" -ForegroundColor Cyan
Write-Host "║                  mm.ti Lab Toolkit                     ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  Este script irá limpar:                              ║" -ForegroundColor Cyan
Write-Host "║  - Arquivos temporários do sistema                    ║" -ForegroundColor Cyan
Write-Host "║  - Arquivos temporários do usuário                    ║" -ForegroundColor Cyan
Write-Host "║  - Lixeira                                             ║" -ForegroundColor Cyan
Write-Host "║  - Logs básicos do sistema                            ║" -ForegroundColor Cyan
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
$LogFile = "$LogDir\clean-temp_$timestamp.log"

function Write-Log {
    param([string]$Message)
    $logMessage = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message"
    Add-Content -Path $LogFile -Value $logMessage
}

Write-Log "========== INÍCIO DA LIMPEZA RÁPIDA =========="
Write-Log "Sistema: $([Environment]::OSVersion.VersionString)"

# Variáveis para calcular espaço liberado
$espacoInicial = (Get-PSDrive C).Used
$espacoLiberado = 0

# ============================================================================
# LIMPEZA DE TEMPORÁRIOS
# ============================================================================
Clear-Host
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [1/4] Limpando Arquivos Temporários do Sistema       │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza Rápida" -Status "Limpando temporários do sistema" -PercentComplete 10

Write-Log "========== Limpeza Temporários Sistema =========="
try {
    Write-Host "Limpando pasta Windows\Temp..." -ForegroundColor White
    $tempCount = (Get-ChildItem "$env:SystemRoot\Temp" -ErrorAction SilentlyContinue | Measure-Object).Count
    Remove-Item "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "[OK] $tempCount arquivos removidos de Windows\Temp" -ForegroundColor Green
    Write-Log "Removidos $tempCount arquivos de Windows\Temp"
} catch {
    Write-Host "[AVISO] Alguns arquivos não puderam ser removidos" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

Write-Host ""
Write-Progress -Activity "Limpeza Rápida" -Status "Limpando temporários do usuário" -PercentComplete 30

Write-Log "========== Limpeza Temporários Usuário =========="
try {
    Write-Host "Limpando pasta Temp do usuário..." -ForegroundColor White
    $userTempCount = (Get-ChildItem "$env:TEMP" -ErrorAction SilentlyContinue | Measure-Object).Count
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "[OK] $userTempCount arquivos removidos de %TEMP%" -ForegroundColor Green
    Write-Log "Removidos $userTempCount arquivos de %TEMP%"
} catch {
    Write-Host "[AVISO] Alguns arquivos não puderam ser removidos" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# LIMPEZA DA LIXEIRA
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [2/4] Esvaziando Lixeira                               │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza Rápida" -Status "Esvaziando lixeira" -PercentComplete 50

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
# LIMPEZA DE LOGS BÁSICOS
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [3/4] Limpando Logs Básicos do Sistema                │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza Rápida" -Status "Limpando logs" -PercentComplete 70

Write-Log "========== Limpeza Logs =========="
try {
    Write-Host "Limpando logs antigos..." -ForegroundColor White
    $logCount = 0
    
    if (Test-Path "$env:SystemRoot\Logs\CBS") {
        $logs = Get-ChildItem "$env:SystemRoot\Logs\CBS\*.log" -ErrorAction SilentlyContinue
        $logCount += $logs.Count
        Remove-Item "$env:SystemRoot\Logs\CBS\*.log" -Force -ErrorAction SilentlyContinue
    }
    
    if (Test-Path "$env:SystemRoot\Logs\DISM") {
        $logs = Get-ChildItem "$env:SystemRoot\Logs\DISM\*.log" -ErrorAction SilentlyContinue
        $logCount += $logs.Count
        Remove-Item "$env:SystemRoot\Logs\DISM\*.log" -Force -ErrorAction SilentlyContinue
    }
    
    Write-Host "[OK] $logCount arquivos de log removidos" -ForegroundColor Green
    Write-Log "Removidos $logCount arquivos de log"
} catch {
    Write-Host "[AVISO] Alguns logs não puderam ser removidos" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# CALCULAR ESPAÇO LIBERADO
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [4/4] Calculando Espaço Liberado                      │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza Rápida" -Status "Calculando espaço liberado" -PercentComplete 90

Start-Sleep -Seconds 2
$espacoFinal = (Get-PSDrive C).Used
$espacoLiberado = $espacoInicial - $espacoFinal

if ($espacoLiberado -lt 0) { $espacoLiberado = 0 }

$espacoMB = [math]::Round($espacoLiberado / 1MB, 2)
$espacoGB = [math]::Round($espacoLiberado / 1GB, 2)

# ============================================================================
# RESUMO FINAL
# ============================================================================
Write-Progress -Activity "Limpeza Rápida" -Status "Concluído!" -PercentComplete 100 -Completed

Clear-Host
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║      🎉 LIMPEZA RÁPIDA CONCLUÍDA COM SUCESSO!         ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "┌─ RESUMO ───────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│                                                        │" -ForegroundColor Cyan
Write-Host "│  ✓ Arquivos temporários do sistema limpos            │" -ForegroundColor Green
Write-Host "│  ✓ Arquivos temporários do usuário limpos            │" -ForegroundColor Green
Write-Host "│  ✓ Lixeira esvaziada                                  │" -ForegroundColor Green
Write-Host "│  ✓ Logs básicos removidos                             │" -ForegroundColor Green
Write-Host "│                                                        │" -ForegroundColor Cyan
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

Write-Log "Espaço liberado: $espacoMB MB ($espacoGB GB)"
Write-Log "========== FIM DA LIMPEZA RÁPIDA =========="

Write-Host "Pressione qualquer tecla para fechar..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')


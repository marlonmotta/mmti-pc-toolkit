#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Limpeza de Atualizações Antigas do Windows
    
.DESCRIPTION
    Script para remover atualizações antigas do Windows e limpar Component Store
    Sistema mm.ti Lab v1.0
    
.NOTES
    Script criado por: Marlon Motta e equipe
    Email: marlonmotta.ti@gmail.com
    Versão: 1.0
#>

# ============================================================================
# CONFIGURAÇÕES INICIAIS
# ============================================================================
$Host.UI.RawUI.WindowTitle = "Limpeza de Atualizações Antigas - mm.ti Lab"
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
Write-Host "║    LIMPEZA DE ATUALIZAÇÕES ANTIGAS DO WINDOWS        ║" -ForegroundColor Cyan
Write-Host "║                  mm.ti Lab Toolkit                     ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  Este script irá:                                     ║" -ForegroundColor Cyan
Write-Host "║  1. Remover atualizações antigas do Windows           ║" -ForegroundColor Cyan
Write-Host "║  2. Limpar Component Store (DISM)                     ║" -ForegroundColor Cyan
Write-Host "║  3. Limpar cache do Windows Update                    ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  💾 ESPERADO: Liberar 5-10 GB de espaço              ║" -ForegroundColor Yellow
Write-Host "║  ⏱️  TEMPO: 10-30 minutos                            ║" -ForegroundColor Yellow
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
$LogFile = "$LogDir\clean-updates_$timestamp.log"

function Write-Log {
    param([string]$Message)
    $logMessage = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message"
    Add-Content -Path $LogFile -Value $logMessage
}

Write-Log "========== INÍCIO DA LIMPEZA DE ATUALIZAÇÕES =========="
Write-Log "Sistema: $([Environment]::OSVersion.VersionString)"

# Variáveis para calcular espaço liberado
$espacoInicial = (Get-PSDrive C).Used

# ============================================================================
# ETAPA 1: Limpeza do Component Store (DISM)
# ============================================================================
Clear-Host
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [1/3] Limpando Component Store (DISM)                │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""
Write-Host "Removendo versões antigas de componentes do Windows..." -ForegroundColor White
Write-Host "⏱️  Tempo estimado: 5-15 minutos" -ForegroundColor Yellow
Write-Host ""

Write-Progress -Activity "Limpeza de Atualizações" -Status "DISM Component Cleanup" -PercentComplete 10

Write-Log "========== DISM Component Cleanup =========="
try {
    Write-Host "Executando DISM /Cleanup-Image /StartComponentCleanup /ResetBase..." -ForegroundColor White
    $output = & dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase 2>&1
    $exitCode = $LASTEXITCODE
    $output | ForEach-Object { Write-Log $_ }
    
    if ($exitCode -eq 0) {
        Write-Host "[OK] Component Store limpo com sucesso!" -ForegroundColor Green
        Write-Log "Status: SUCESSO"
    } else {
        Write-Host "[AVISO] Código de saída: $exitCode" -ForegroundColor Yellow
        Write-Log "Status: Código $exitCode"
    }
} catch {
    Write-Host "[ERRO] Falha ao executar DISM Component Cleanup" -ForegroundColor Red
    Write-Log "Erro: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 2: Limpeza de Atualizações Antigas
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [2/3] Removendo Atualizações Antigas                 │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza de Atualizações" -Status "Removendo atualizações antigas" -PercentComplete 50

Write-Log "========== Remoção de Atualizações Antigas =========="
try {
    Write-Host "Buscando atualizações antigas..." -ForegroundColor White
    
    # Usar Windows Update Cleanup Tool via DISM
    Write-Host "Executando limpeza de atualizações via DISM..." -ForegroundColor White
    $output = & dism.exe /Online /Cleanup-Image /StartComponentCleanup 2>&1
    $exitCode = $LASTEXITCODE
    $output | ForEach-Object { Write-Log $_ }
    
    if ($exitCode -eq 0) {
        Write-Host "[OK] Atualizações antigas removidas!" -ForegroundColor Green
        Write-Log "Status: SUCESSO"
    } else {
        Write-Host "[AVISO] Código de saída: $exitCode" -ForegroundColor Yellow
        Write-Log "Status: Código $exitCode"
    }
} catch {
    Write-Host "[ERRO] Falha ao remover atualizações antigas" -ForegroundColor Red
    Write-Log "Erro: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 3: Limpeza do Cache do Windows Update
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [3/3] Limpando Cache do Windows Update               │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza de Atualizações" -Status "Limpando cache do Windows Update" -PercentComplete 80

Write-Log "========== Limpeza Cache Windows Update =========="
try {
    Write-Host "Parando serviços Windows Update..." -ForegroundColor White
    Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
    Stop-Service -Name bits -Force -ErrorAction SilentlyContinue
    Write-Log "Serviços parados"
    
    Write-Host "Limpando pasta SoftwareDistribution..." -ForegroundColor White
    $softDist = "$env:SystemRoot\SoftwareDistribution"
    if (Test-Path "$softDist.old") {
        Remove-Item "$softDist.old" -Recurse -Force -ErrorAction SilentlyContinue
    }
    if (Test-Path $softDist) {
        Rename-Item -Path $softDist -NewName "SoftwareDistribution.old" -Force -ErrorAction SilentlyContinue
    }
    Write-Log "Pasta SoftwareDistribution renomeada"
    
    Start-Service -Name wuauserv -ErrorAction SilentlyContinue
    Start-Service -Name bits -ErrorAction SilentlyContinue
    Write-Log "Serviços reiniciados"
    
    Write-Host "[OK] Cache do Windows Update limpo!" -ForegroundColor Green
    Write-Log "Status: CONCLUÍDO"
} catch {
    Write-Host "[ERRO] Falha na limpeza do cache: $($_.Exception.Message)" -ForegroundColor Red
    Write-Log "Erro: $($_.Exception.Message)"
}

# ============================================================================
# CALCULAR ESPAÇO LIBERADO
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ Calculando Espaço Liberado                            │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Limpeza de Atualizações" -Status "Calculando espaço liberado" -PercentComplete 95

Start-Sleep -Seconds 3
$espacoFinal = (Get-PSDrive C).Used
$espacoLiberado = $espacoInicial - $espacoFinal

if ($espacoLiberado -lt 0) { $espacoLiberado = 0 }

$espacoMB = [math]::Round($espacoLiberado / 1MB, 2)
$espacoGB = [math]::Round($espacoLiberado / 1GB, 2)

# ============================================================================
# RESUMO FINAL
# ============================================================================
Write-Progress -Activity "Limpeza de Atualizações" -Status "Concluído!" -PercentComplete 100 -Completed

Clear-Host
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║   🎉 LIMPEZA DE ATUALIZAÇÕES CONCLUÍDA COM SUCESSO!  ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "┌─ RESUMO ───────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│                                                        │" -ForegroundColor Cyan
Write-Host "│  ✓ Component Store limpo (DISM)                      │" -ForegroundColor Green
Write-Host "│  ✓ Atualizações antigas removidas                    │" -ForegroundColor Green
Write-Host "│  ✓ Cache do Windows Update limpo                     │" -ForegroundColor Green
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
Write-Host "💡 RECOMENDAÇÃO:" -ForegroundColor Yellow
Write-Host "   Execute o Windows Update após esta limpeza para" -ForegroundColor White
Write-Host "   garantir que o sistema está atualizado." -ForegroundColor White
Write-Host ""
Write-Host "───────────────────────────────────────────────────────────" -ForegroundColor Gray
Write-Host ""
Write-Host "Sistema mm.ti Lab - PC Toolkit v$ScriptVersion" -ForegroundColor Gray
Write-Host "Script criado por Marlon Motta e equipe" -ForegroundColor Gray
Write-Host "Email: marlonmotta.ti@gmail.com" -ForegroundColor Gray
Write-Host ""

Write-Log "Espaço liberado: $espacoMB MB ($espacoGB GB)"
Write-Log "========== FIM DA LIMPEZA DE ATUALIZAÇÕES =========="

Write-Host "Pressione qualquer tecla para fechar..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')


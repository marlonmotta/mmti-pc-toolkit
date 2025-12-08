#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Reset Completo de Configurações de Rede
    
.DESCRIPTION
    Script para resetar completamente as configurações de rede do Windows,
    incluindo TCP/IP, DNS, Winsock e adaptadores de rede
    Sistema mm.ti Lab v1.0
    
.NOTES
    Script criado por: Marlon Motta e equipe
    Email: marlonmotta.ti@gmail.com
    Versão: 1.0
#>

# ============================================================================
# CONFIGURAÇÕES INICIAIS
# ============================================================================
$Host.UI.RawUI.WindowTitle = "Reset de Configurações de Rede - mm.ti Lab"
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
Write-Host "║     RESET COMPLETO DE CONFIGURAÇÕES DE REDE          ║" -ForegroundColor Cyan
Write-Host "║                  mm.ti Lab Toolkit                     ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  Este script irá resetar:                             ║" -ForegroundColor Cyan
Write-Host "║  1. Stack TCP/IP                                       ║" -ForegroundColor Cyan
Write-Host "║  2. Stack Winsock                                      ║" -ForegroundColor Cyan
Write-Host "║  3. Configurações DNS                                  ║" -ForegroundColor Cyan
Write-Host "║  4. Adaptadores de rede                                ║" -ForegroundColor Cyan
Write-Host "║  5. Cache de DNS                                       ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  ⚠️  ATENÇÃO: Você perderá a conexão com a internet   ║" -ForegroundColor Red
Write-Host "║  temporariamente. Pode ser necessário reconfigurar     ║" -ForegroundColor Red
Write-Host "║  suas configurações de rede após o reset.              ║" -ForegroundColor Red
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
$LogFile = "$LogDir\repair-network_$timestamp.log"

function Write-Log {
    param([string]$Message)
    $logMessage = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message"
    Add-Content -Path $LogFile -Value $logMessage
}

Write-Log "========== INÍCIO DO RESET DE REDE =========="
Write-Log "Sistema: $([Environment]::OSVersion.VersionString)"

# Variáveis de resultado
$resultados = @{
    TCPIP = 0
    Winsock = 0
    DNS = 0
    Adapters = 0
    DNSCache = 0
}

# ============================================================================
# ETAPA 1: Reset TCP/IP Stack
# ============================================================================
Clear-Host
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [1/5] Resetando Stack TCP/IP                         │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Reset de Rede" -Status "Resetando TCP/IP" -PercentComplete 10

Write-Log "========== Reset TCP/IP Stack =========="
try {
    Write-Host "Executando netsh int ip reset..." -ForegroundColor White
    $output = & netsh int ip reset 2>&1
    $resultados.TCPIP = $LASTEXITCODE
    $output | ForEach-Object { Write-Log $_ }
    
    if ($resultados.TCPIP -eq 0) {
        Write-Host "[OK] Stack TCP/IP resetado!" -ForegroundColor Green
        Write-Log "Status: SUCESSO"
    } else {
        Write-Host "[AVISO] Código de saída: $($resultados.TCPIP)" -ForegroundColor Yellow
        Write-Log "Status: Código $($resultados.TCPIP)"
    }
} catch {
    Write-Host "[ERRO] Falha ao resetar TCP/IP: $($_.Exception.Message)" -ForegroundColor Red
    Write-Log "Erro: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 2: Reset Winsock
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [2/5] Resetando Stack Winsock                        │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Reset de Rede" -Status "Resetando Winsock" -PercentComplete 30

Write-Log "========== Reset Winsock =========="
try {
    Write-Host "Executando netsh winsock reset..." -ForegroundColor White
    $output = & netsh winsock reset 2>&1
    $resultados.Winsock = $LASTEXITCODE
    $output | ForEach-Object { Write-Log $_ }
    
    if ($resultados.Winsock -eq 0) {
        Write-Host "[OK] Stack Winsock resetado!" -ForegroundColor Green
        Write-Log "Status: SUCESSO"
    } else {
        Write-Host "[AVISO] Código de saída: $($resultados.Winsock)" -ForegroundColor Yellow
        Write-Log "Status: Código $($resultados.Winsock)"
    }
} catch {
    Write-Host "[ERRO] Falha ao resetar Winsock: $($_.Exception.Message)" -ForegroundColor Red
    Write-Log "Erro: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 3: Reset DNS
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [3/5] Resetando Configurações DNS                    │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Reset de Rede" -Status "Resetando DNS" -PercentComplete 50

Write-Log "========== Reset DNS =========="
try {
    Write-Host "Executando netsh int ipv4 reset..." -ForegroundColor White
    $output = & netsh int ipv4 reset 2>&1
    $resultados.DNS = $LASTEXITCODE
    $output | ForEach-Object { Write-Log $_ }
    
    Write-Host "Executando netsh int ipv6 reset..." -ForegroundColor White
    $output2 = & netsh int ipv6 reset 2>&1
    $output2 | ForEach-Object { Write-Log $_ }
    
    if ($resultados.DNS -eq 0) {
        Write-Host "[OK] Configurações DNS resetadas!" -ForegroundColor Green
        Write-Log "Status: SUCESSO"
    } else {
        Write-Host "[AVISO] Código de saída: $($resultados.DNS)" -ForegroundColor Yellow
        Write-Log "Status: Código $($resultados.DNS)"
    }
} catch {
    Write-Host "[ERRO] Falha ao resetar DNS: $($_.Exception.Message)" -ForegroundColor Red
    Write-Log "Erro: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 4: Reset Adaptadores de Rede
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [4/5] Resetando Adaptadores de Rede                  │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Reset de Rede" -Status "Resetando adaptadores" -PercentComplete 70

Write-Log "========== Reset Adaptadores de Rede =========="
try {
    Write-Host "Desabilitando e reabilitando adaptadores de rede..." -ForegroundColor White
    $adapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
    
    foreach ($adapter in $adapters) {
        Write-Host "  - Desabilitando $($adapter.Name)..." -ForegroundColor Gray
        Disable-NetAdapter -Name $adapter.Name -Confirm:$false -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
        Write-Host "  - Reabilitando $($adapter.Name)..." -ForegroundColor Gray
        Enable-NetAdapter -Name $adapter.Name -Confirm:$false -ErrorAction SilentlyContinue
        Write-Log "Adaptador $($adapter.Name) resetado"
    }
    
    $resultados.Adapters = 1
    Write-Host "[OK] Adaptadores de rede resetados!" -ForegroundColor Green
    Write-Log "Status: SUCESSO"
} catch {
    Write-Host "[AVISO] Alguns adaptadores não puderam ser resetados" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 5: Limpar Cache DNS
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [5/5] Limpando Cache DNS                             │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Reset de Rede" -Status "Limpando cache DNS" -PercentComplete 90

Write-Log "========== Limpeza Cache DNS =========="
try {
    Write-Host "Limpando cache DNS..." -ForegroundColor White
    $output = & ipconfig /flushdns 2>&1
    $resultados.DNSCache = $LASTEXITCODE
    $output | ForEach-Object { Write-Log $_ }
    
    if ($resultados.DNSCache -eq 0) {
        Write-Host "[OK] Cache DNS limpo!" -ForegroundColor Green
        Write-Log "Status: SUCESSO"
    } else {
        Write-Host "[AVISO] Código de saída: $($resultados.DNSCache)" -ForegroundColor Yellow
        Write-Log "Status: Código $($resultados.DNSCache)"
    }
} catch {
    Write-Host "[ERRO] Falha ao limpar cache DNS: $($_.Exception.Message)" -ForegroundColor Red
    Write-Log "Erro: $($_.Exception.Message)"
}

# ============================================================================
# RESUMO FINAL
# ============================================================================
Write-Progress -Activity "Reset de Rede" -Status "Concluído!" -PercentComplete 100 -Completed

Clear-Host
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║   🎉 RESET DE REDE CONCLUÍDO COM SUCESSO!            ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "┌─ RESUMO ───────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│                                                        │" -ForegroundColor Cyan
Write-Host "│  $(if($resultados.TCPIP -eq 0){'✓'}else{'✗'}) Stack TCP/IP resetado                    │" -ForegroundColor $(if($resultados.TCPIP -eq 0){'Green'}else{'Red'})
Write-Host "│  $(if($resultados.Winsock -eq 0){'✓'}else{'✗'}) Stack Winsock resetado                  │" -ForegroundColor $(if($resultados.Winsock -eq 0){'Green'}else{'Red'})
Write-Host "│  $(if($resultados.DNS -eq 0){'✓'}else{'✗'}) Configurações DNS resetadas                │" -ForegroundColor $(if($resultados.DNS -eq 0){'Green'}else{'Red'})
Write-Host "│  $(if($resultados.Adapters -eq 1){'✓'}else{'✗'}) Adaptadores de rede resetados          │" -ForegroundColor $(if($resultados.Adapters -eq 1){'Green'}else{'Red'})
Write-Host "│  $(if($resultados.DNSCache -eq 0){'✓'}else{'✗'}) Cache DNS limpo                        │" -ForegroundColor $(if($resultados.DNSCache -eq 0){'Green'}else{'Red'})
Write-Host "│                                                        │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""
Write-Host "📂 LOG DETALHADO SALVO EM:" -ForegroundColor Cyan
Write-Host "   $LogFile" -ForegroundColor White
Write-Host ""
Write-Host "───────────────────────────────────────────────────────────" -ForegroundColor Gray
Write-Host ""
Write-Host "⚠️  IMPORTANTE:" -ForegroundColor Yellow
Write-Host "   Uma REINICIALIZAÇÃO é recomendada para aplicar todas" -ForegroundColor White
Write-Host "   as mudanças corretamente." -ForegroundColor White
Write-Host ""
Write-Host "   Se você tiver configurações de rede personalizadas" -ForegroundColor White
Write-Host "   (IP estático, DNS customizado, etc.), será necessário" -ForegroundColor White
Write-Host "   reconfigurá-las após a reinicialização." -ForegroundColor White
Write-Host ""
Write-Host "───────────────────────────────────────────────────────────" -ForegroundColor Gray
Write-Host ""
Write-Host "Sistema mm.ti Lab - PC Toolkit v$ScriptVersion" -ForegroundColor Gray
Write-Host "Script criado por Marlon Motta e equipe" -ForegroundColor Gray
Write-Host "Email: marlonmotta.ti@gmail.com" -ForegroundColor Gray
Write-Host ""

Write-Log "========== FIM DO RESET DE REDE =========="

Write-Host "Pressione qualquer tecla para fechar..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')


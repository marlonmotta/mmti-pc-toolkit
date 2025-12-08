#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Reparo do Windows Store e Apps UWP
    
.DESCRIPTION
    Script para reparar problemas com Windows Store e aplicativos UWP
    Sistema mm.ti Lab v1.0
    
.NOTES
    Script criado por: Marlon Motta e equipe
    Email: marlonmotta.ti@gmail.com
    Versão: 1.0
#>

# ============================================================================
# CONFIGURAÇÕES INICIAIS
# ============================================================================
$Host.UI.RawUI.WindowTitle = "Reparo do Windows Store - mm.ti Lab"
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
Write-Host "║        REPARO DO WINDOWS STORE E APPS UWP            ║" -ForegroundColor Cyan
Write-Host "║                  mm.ti Lab Toolkit                     ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  Este script irá:                                     ║" -ForegroundColor Cyan
Write-Host "║  1. Parar serviços do Windows Store                   ║" -ForegroundColor Cyan
Write-Host "║  2. Limpar cache do Windows Store                     ║" -ForegroundColor Cyan
Write-Host "║  3. Resetar aplicativos UWP                           ║" -ForegroundColor Cyan
Write-Host "║  4. Reinstalar Windows Store                          ║" -ForegroundColor Cyan
Write-Host "║  5. Reiniciar serviços                                ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  ⏱️  TEMPO: 5-10 minutos                             ║" -ForegroundColor Yellow
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
$LogFile = "$LogDir\repair-store_$timestamp.log"

function Write-Log {
    param([string]$Message)
    $logMessage = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message"
    Add-Content -Path $LogFile -Value $logMessage
}

Write-Log "========== INÍCIO DO REPARO DO WINDOWS STORE =========="
Write-Log "Sistema: $([Environment]::OSVersion.VersionString)"

# Variáveis de resultado
$resultados = @{
    Services = 0
    Cache = 0
    ResetApps = 0
    ReinstallStore = 0
    RestartServices = 0
}

# ============================================================================
# ETAPA 1: Parar Serviços do Windows Store
# ============================================================================
Clear-Host
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [1/5] Parando Serviços do Windows Store             │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Reparo Windows Store" -Status "Parando serviços" -PercentComplete 10

Write-Log "========== Parar Serviços =========="
try {
    Write-Host "Parando serviços relacionados ao Windows Store..." -ForegroundColor White
    
    $services = @("WSService", "wuauserv", "bits")
    foreach ($service in $services) {
        try {
            Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
            Write-Host "  - Serviço $service parado" -ForegroundColor Gray
            Write-Log "Serviço $service parado"
        } catch {
            Write-Log "Aviso: Não foi possível parar $service"
        }
    }
    
    $resultados.Services = 1
    Write-Host "[OK] Serviços parados!" -ForegroundColor Green
    Write-Log "Status: SUCESSO"
} catch {
    Write-Host "[AVISO] Alguns serviços não puderam ser parados" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 2: Limpar Cache do Windows Store
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [2/5] Limpando Cache do Windows Store               │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Reparo Windows Store" -Status "Limpando cache" -PercentComplete 30

Write-Log "========== Limpeza Cache =========="
try {
    Write-Host "Limpando cache do Windows Store..." -ForegroundColor White
    
    $cachePaths = @(
        "$env:LOCALAPPDATA\Packages\Microsoft.WindowsStore_*\LocalCache",
        "$env:LOCALAPPDATA\Packages\Microsoft.WindowsStore_*\TempState",
        "$env:LOCALAPPDATA\Packages\Microsoft.WindowsStore_*\AC\INetCache"
    )
    
    foreach ($pathPattern in $cachePaths) {
        $paths = Get-ChildItem -Path (Split-Path $pathPattern -Parent) -Filter (Split-Path $pathPattern -Leaf) -ErrorAction SilentlyContinue
        foreach ($path in $paths) {
            if (Test-Path $path.FullName) {
                Remove-Item $path.FullName -Recurse -Force -ErrorAction SilentlyContinue
                Write-Log "Cache removido: $($path.FullName)"
            }
        }
    }
    
    $resultados.Cache = 1
    Write-Host "[OK] Cache do Windows Store limpo!" -ForegroundColor Green
    Write-Log "Status: SUCESSO"
} catch {
    Write-Host "[AVISO] Alguns arquivos de cache não puderam ser removidos" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 3: Resetar Aplicativos UWP
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [3/5] Resetando Aplicativos UWP                     │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Reparo Windows Store" -Status "Resetando apps UWP" -PercentComplete 50

Write-Log "========== Reset Apps UWP =========="
try {
    Write-Host "Resetando aplicativos UWP..." -ForegroundColor White
    
    # Resetar Windows Store
    $storeApp = Get-AppxPackage -Name "Microsoft.WindowsStore" -ErrorAction SilentlyContinue
    if ($storeApp) {
        Write-Host "  - Resetando Windows Store..." -ForegroundColor Gray
        Get-AppxPackage -Name "Microsoft.WindowsStore" | Reset-AppxPackage -ErrorAction SilentlyContinue
        Write-Log "Windows Store resetado"
    }
    
    # Resetar outros apps UWP comuns que podem ter problemas
    $problemApps = @("Microsoft.WindowsCalculator", "Microsoft.Windows.Photos")
    foreach ($appName in $problemApps) {
        $app = Get-AppxPackage -Name $appName -ErrorAction SilentlyContinue
        if ($app) {
            Write-Host "  - Resetando $appName..." -ForegroundColor Gray
            Get-AppxPackage -Name $appName | Reset-AppxPackage -ErrorAction SilentlyContinue
            Write-Log "$appName resetado"
        }
    }
    
    $resultados.ResetApps = 1
    Write-Host "[OK] Aplicativos UWP resetados!" -ForegroundColor Green
    Write-Log "Status: SUCESSO"
} catch {
    Write-Host "[AVISO] Alguns aplicativos não puderam ser resetados" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 4: Reinstalar Windows Store
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [4/5] Reinstalando Windows Store                    │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Reparo Windows Store" -Status "Reinstalando Windows Store" -PercentComplete 70

Write-Log "========== Reinstalação Windows Store =========="
try {
    Write-Host "Reinstalando Windows Store..." -ForegroundColor White
    
    # Remover Windows Store
    $storePackage = Get-AppxPackage -Name "Microsoft.WindowsStore" -ErrorAction SilentlyContinue
    if ($storePackage) {
        Write-Host "  - Removendo Windows Store..." -ForegroundColor Gray
        Remove-AppxPackage -Package $storePackage.PackageFullName -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 3
        Write-Log "Windows Store removido"
    }
    
    # Reinstalar Windows Store
    Write-Host "  - Reinstalando Windows Store..." -ForegroundColor Gray
    $storeProvisioned = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq "Microsoft.WindowsStore" }
    if ($storeProvisioned) {
        Add-AppxPackage -Register "$env:SystemRoot\SystemApps\Microsoft.WindowsStore_*\AppxManifest.xml" -DisableDevelopmentMode -ErrorAction SilentlyContinue
        Write-Log "Windows Store reinstalado"
    }
    
    $resultados.ReinstallStore = 1
    Write-Host "[OK] Windows Store reinstalado!" -ForegroundColor Green
    Write-Log "Status: SUCESSO"
} catch {
    Write-Host "[AVISO] Windows Store pode precisar ser reinstalado manualmente" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# ETAPA 5: Reiniciar Serviços
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ [5/5] Reiniciando Serviços                          │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Reparo Windows Store" -Status "Reiniciando serviços" -PercentComplete 90

Write-Log "========== Reiniciar Serviços =========="
try {
    Write-Host "Reiniciando serviços..." -ForegroundColor White
    
    $services = @("WSService", "wuauserv", "bits")
    foreach ($service in $services) {
        try {
            Start-Service -Name $service -ErrorAction SilentlyContinue
            Write-Host "  - Serviço $service reiniciado" -ForegroundColor Gray
            Write-Log "Serviço $service reiniciado"
        } catch {
            Write-Log "Aviso: Não foi possível reiniciar $service"
        }
    }
    
    $resultados.RestartServices = 1
    Write-Host "[OK] Serviços reiniciados!" -ForegroundColor Green
    Write-Log "Status: SUCESSO"
} catch {
    Write-Host "[AVISO] Alguns serviços não puderam ser reiniciados" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# RESUMO FINAL
# ============================================================================
Write-Progress -Activity "Reparo Windows Store" -Status "Concluído!" -PercentComplete 100 -Completed

Clear-Host
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  🎉 REPARO DO WINDOWS STORE CONCLUÍDO COM SUCESSO!  ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "┌─ RESUMO ───────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│                                                        │" -ForegroundColor Cyan
Write-Host "│  $(if($resultados.Services -eq 1){'✓'}else{'✗'}) Serviços parados e reiniciados              │" -ForegroundColor $(if($resultados.Services -eq 1){'Green'}else{'Red'})
Write-Host "│  $(if($resultados.Cache -eq 1){'✓'}else{'✗'}) Cache do Windows Store limpo                  │" -ForegroundColor $(if($resultados.Cache -eq 1){'Green'}else{'Red'})
Write-Host "│  $(if($resultados.ResetApps -eq 1){'✓'}else{'✗'}) Aplicativos UWP resetados                 │" -ForegroundColor $(if($resultados.ResetApps -eq 1){'Green'}else{'Red'})
Write-Host "│  $(if($resultados.ReinstallStore -eq 1){'✓'}else{'✗'}) Windows Store reinstalado             │" -ForegroundColor $(if($resultados.ReinstallStore -eq 1){'Green'}else{'Red'})
Write-Host "│                                                        │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""
Write-Host "📂 LOG DETALHADO SALVO EM:" -ForegroundColor Cyan
Write-Host "   $LogFile" -ForegroundColor White
Write-Host ""
Write-Host "───────────────────────────────────────────────────────────" -ForegroundColor Gray
Write-Host ""
Write-Host "💡 PRÓXIMOS PASSOS:" -ForegroundColor Yellow
Write-Host "   1. Reinicie o computador para aplicar todas as mudanças" -ForegroundColor White
Write-Host "   2. Abra o Windows Store e verifique se está funcionando" -ForegroundColor White
Write-Host "   3. Se necessário, reinstale aplicativos UWP que não" -ForegroundColor White
Write-Host "      estão funcionando corretamente" -ForegroundColor White
Write-Host ""
Write-Host "───────────────────────────────────────────────────────────" -ForegroundColor Gray
Write-Host ""
Write-Host "Sistema mm.ti Lab - PC Toolkit v$ScriptVersion" -ForegroundColor Gray
Write-Host "Script criado por Marlon Motta e equipe" -ForegroundColor Gray
Write-Host "Email: marlonmotta.ti@gmail.com" -ForegroundColor Gray
Write-Host ""

Write-Log "========== FIM DO REPARO DO WINDOWS STORE =========="

Write-Host "Pressione qualquer tecla para fechar..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')


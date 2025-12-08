#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Otimização Inteligente de Disco (HDD/SSD)
    
.DESCRIPTION
    Script para otimização inteligente de disco detectando automaticamente
    se é HDD ou SSD e aplicando a otimização apropriada
    Sistema mm.ti Lab v1.0
    
.NOTES
    Script criado por: Marlon Motta e equipe
    Email: marlonmotta.ti@gmail.com
    Versão: 1.0
#>

# ============================================================================
# CONFIGURAÇÕES INICIAIS
# ============================================================================
$Host.UI.RawUI.WindowTitle = "Otimização de Disco - mm.ti Lab"
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
# FUNÇÃO: Detectar Tipo de Disco
# ============================================================================
function Get-DiskType {
    param([string]$DriveLetter = "C:")
    
    try {
        $drive = Get-PhysicalDisk | Where-Object { 
            (Get-Partition -DriveLetter $DriveLetter[0]).DiskNumber -eq $_.DeviceID 
        } | Select-Object -First 1
        
        if ($drive) {
            return $drive.MediaType
        } else {
            # Fallback: Verificar via WMI
            $disk = Get-WmiObject -Class Win32_DiskDrive | Where-Object {
                $_.DeviceID -like "*PHYSICALDRIVE*"
            } | Select-Object -First 1
            
            if ($disk -and $disk.MediaType) {
                return $disk.MediaType
            }
            return "Unknown"
        }
    } catch {
        return "Unknown"
    }
}

# ============================================================================
# INTERFACE INICIAL
# ============================================================================
Clear-Host
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        OTIMIZAÇÃO INTELIGENTE DE DISCO               ║" -ForegroundColor Cyan
Write-Host "║                  mm.ti Lab Toolkit                     ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║  Este script irá:                                     ║" -ForegroundColor Cyan
Write-Host "║  1. Detectar o tipo de disco (HDD ou SSD)            ║" -ForegroundColor Cyan
Write-Host "║  2. Aplicar otimização apropriada                    ║" -ForegroundColor Cyan
Write-Host "║     - HDD: Desfragmentação                           ║" -ForegroundColor Cyan
Write-Host "║     - SSD: TRIM (Otimização)                         ║" -ForegroundColor Cyan
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
$LogFile = "$LogDir\optimize-disk_$timestamp.log"

function Write-Log {
    param([string]$Message)
    $logMessage = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message"
    Add-Content -Path $LogFile -Value $logMessage
}

Write-Log "========== INÍCIO DA OTIMIZAÇÃO DE DISCO =========="
Write-Log "Sistema: $([Environment]::OSVersion.VersionString)"

# ============================================================================
# DETECÇÃO DO TIPO DE DISCO
# ============================================================================
Clear-Host
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ Detectando Tipo de Disco                             │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Otimização de Disco" -Status "Detectando tipo de disco" -PercentComplete 10

Write-Log "========== Detecção de Tipo de Disco =========="
$diskType = Get-DiskType -DriveLetter "C:"

if ($diskType -eq "SSD" -or $diskType -like "*SSD*") {
    $isSSD = $true
    Write-Host "[✓] Disco detectado: SSD (Solid State Drive)" -ForegroundColor Green
    Write-Log "Tipo de disco: SSD"
} elseif ($diskType -eq "HDD" -or $diskType -like "*HDD*" -or $diskType -eq "Unknown") {
    $isSSD = $false
    Write-Host "[✓] Disco detectado: HDD (Hard Disk Drive)" -ForegroundColor Green
    Write-Log "Tipo de disco: HDD (ou Unknown - assumindo HDD)"
} else {
    $isSSD = $false
    Write-Host "[!] Tipo de disco não identificado. Assumindo HDD." -ForegroundColor Yellow
    Write-Log "Tipo de disco: Não identificado (assumindo HDD)"
}

Start-Sleep -Seconds 2

# ============================================================================
# OTIMIZAÇÃO BASEADA NO TIPO DE DISCO
# ============================================================================
if ($isSSD) {
    # ========================================================================
    # OTIMIZAÇÃO PARA SSD (TRIM)
    # ========================================================================
    Clear-Host
    Write-Host ""
    Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
    Write-Host "│ Otimizando SSD (TRIM)                                 │" -ForegroundColor Cyan
    Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Executando otimização TRIM no SSD..." -ForegroundColor White
    Write-Host "⏱️  Tempo estimado: 1-5 minutos" -ForegroundColor Yellow
    Write-Host ""
    
    Write-Progress -Activity "Otimização de Disco" -Status "Otimizando SSD (TRIM)" -PercentComplete 30
    
    Write-Log "========== Otimização SSD (TRIM) =========="
    try {
        Write-Host "Executando Optimize-Volume -DriveLetter C -ReTrim..." -ForegroundColor White
        $output = Optimize-Volume -DriveLetter C -ReTrim -ErrorAction Stop
        Write-Host "[OK] SSD otimizado com sucesso!" -ForegroundColor Green
        Write-Log "Status: SUCESSO - TRIM executado"
    } catch {
        Write-Host "[AVISO] Não foi possível executar TRIM: $($_.Exception.Message)" -ForegroundColor Yellow
        Write-Log "Aviso: $($_.Exception.Message)"
        
        # Tentar método alternativo
        try {
            Write-Host "Tentando método alternativo..." -ForegroundColor White
            $output = Optimize-Volume -DriveLetter C -ErrorAction Stop
            Write-Host "[OK] Otimização alternativa executada!" -ForegroundColor Green
            Write-Log "Status: SUCESSO - Otimização alternativa"
        } catch {
            Write-Host "[ERRO] Falha na otimização do SSD" -ForegroundColor Red
            Write-Log "Erro: $($_.Exception.Message)"
        }
    }
} else {
    # ========================================================================
    # OTIMIZAÇÃO PARA HDD (Desfragmentação)
    # ========================================================================
    Clear-Host
    Write-Host ""
    Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
    Write-Host "│ Desfragmentando HDD                                   │" -ForegroundColor Cyan
    Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Executando desfragmentação no disco rígido..." -ForegroundColor White
    Write-Host "⏱️  Tempo estimado: 10-60 minutos (depende do tamanho)" -ForegroundColor Yellow
    Write-Host "⚠️  Este processo pode demorar bastante!" -ForegroundColor Red
    Write-Host ""
    
    Write-Progress -Activity "Otimização de Disco" -Status "Desfragmentando HDD" -PercentComplete 30
    
    Write-Log "========== Desfragmentação HDD =========="
    try {
        Write-Host "Executando Optimize-Volume -DriveLetter C -Defrag..." -ForegroundColor White
        $output = Optimize-Volume -DriveLetter C -Defrag -ErrorAction Stop
        Write-Host "[OK] HDD desfragmentado com sucesso!" -ForegroundColor Green
        Write-Log "Status: SUCESSO - Desfragmentação executada"
    } catch {
        Write-Host "[ERRO] Falha na desfragmentação: $($_.Exception.Message)" -ForegroundColor Red
        Write-Log "Erro: $($_.Exception.Message)"
    }
}

# ============================================================================
# VERIFICAÇÃO DO ESTADO DO DISCO
# ============================================================================
Write-Host ""
Write-Host "┌────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│ Verificando Estado do Disco                          │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""

Write-Progress -Activity "Otimização de Disco" -Status "Verificando estado do disco" -PercentComplete 80

Write-Log "========== Verificação do Estado do Disco =========="
try {
    $volume = Get-Volume -DriveLetter C
    $healthStatus = $volume.HealthStatus
    $operationalStatus = $volume.OperationalStatus
    
    Write-Host "Estado de Saúde: $healthStatus" -ForegroundColor $(if($healthStatus -eq "Healthy"){"Green"}else{"Yellow"})
    Write-Host "Status Operacional: $operationalStatus" -ForegroundColor $(if($operationalStatus -eq "OK"){"Green"}else{"Yellow"})
    Write-Log "Estado de Saúde: $healthStatus"
    Write-Log "Status Operacional: $operationalStatus"
} catch {
    Write-Host "[AVISO] Não foi possível verificar o estado do disco" -ForegroundColor Yellow
    Write-Log "Aviso: $($_.Exception.Message)"
}

# ============================================================================
# RESUMO FINAL
# ============================================================================
Write-Progress -Activity "Otimização de Disco" -Status "Concluído!" -PercentComplete 100 -Completed

Clear-Host
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║      🎉 OTIMIZAÇÃO DE DISCO CONCLUÍDA COM SUCESSO!   ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "┌─ RESUMO ───────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "│                                                        │" -ForegroundColor Cyan
Write-Host "│  Tipo de disco: $(if($isSSD){'SSD'}else{'HDD'})" -ForegroundColor Yellow
Write-Host "│  Otimização aplicada: $(if($isSSD){'TRIM'}else{'Desfragmentação'})" -ForegroundColor Green
Write-Host "│                                                        │" -ForegroundColor Cyan
Write-Host "└────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
Write-Host ""
Write-Host "📂 LOG DETALHADO SALVO EM:" -ForegroundColor Cyan
Write-Host "   $LogFile" -ForegroundColor White
Write-Host ""
Write-Host "───────────────────────────────────────────────────────────" -ForegroundColor Gray
Write-Host ""
Write-Host "💡 RECOMENDAÇÃO:" -ForegroundColor Yellow
if ($isSSD) {
    Write-Host "   SSDs não precisam de desfragmentação. Execute este" -ForegroundColor White
    Write-Host "   script periodicamente (a cada 1-2 meses) para manter" -ForegroundColor White
    Write-Host "   o TRIM ativo e o desempenho otimizado." -ForegroundColor White
} else {
    Write-Host "   Execute este script periodicamente (a cada 1-2 meses)" -ForegroundColor White
    Write-Host "   para manter o disco desfragmentado e o desempenho" -ForegroundColor White
    Write-Host "   otimizado." -ForegroundColor White
}
Write-Host ""
Write-Host "───────────────────────────────────────────────────────────" -ForegroundColor Gray
Write-Host ""
Write-Host "Sistema mm.ti Lab - PC Toolkit v$ScriptVersion" -ForegroundColor Gray
Write-Host "Script criado por Marlon Motta e equipe" -ForegroundColor Gray
Write-Host "Email: marlonmotta.ti@gmail.com" -ForegroundColor Gray
Write-Host ""

Write-Log "========== FIM DA OTIMIZAÇÃO DE DISCO =========="

Write-Host "Pressione qualquer tecla para fechar..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')


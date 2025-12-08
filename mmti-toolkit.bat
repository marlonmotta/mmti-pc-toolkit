@echo off
:: ============================================================================
:: mm.ti Lab - PC Toolkit - Menu Principal Interativo
:: Sistema mm.ti Lab v1.0
:: ============================================================================

setlocal enabledelayedexpansion
chcp 65001 >nul
title mm.ti Lab - PC Toolkit - Menu Principal

:MAIN_MENU
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║         mm.ti Lab - PC Toolkit - Menu Principal       ║
echo ║                  Sistema v1.0                          ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo ┌────────────────────────────────────────────────────────┐
echo │                    MÓDULOS DISPONÍVEIS                 │
echo └────────────────────────────────────────────────────────┘
echo.
echo  [1] 🔧 REPAIR - Reparos do Sistema
echo      └─ Reparo rápido, completo, rede e Windows Store
echo.
echo  [2] 🧹 MAINTENANCE - Manutenção e Limpeza
echo      └─ Limpeza de temporários, atualizações e otimização
echo.
echo  [3] ⚡ OPTIMIZATION - Otimização (Em desenvolvimento)
echo.
echo  [4] 📊 DIAGNOSTICS - Diagnóstico (Em desenvolvimento)
echo.
echo  [5] 🛡️  SECURITY - Segurança (Em desenvolvimento)
echo.
echo  [6] 🚀 AUTOMATION - Automação (Em desenvolvimento)
echo.
echo  [7] 🌐 NETWORK - Rede (Em desenvolvimento)
echo.
echo  [8] 🎯 SPECIALIZED - Especializadas (Em desenvolvimento)
echo.
echo ┌────────────────────────────────────────────────────────┐
echo │                    OPÇÕES GERAIS                       │
echo └────────────────────────────────────────────────────────┘
echo.
echo  [0] Sair
echo  [H] Ajuda / Documentação
echo.
echo ───────────────────────────────────────────────────────────
echo.

set /p "opcao=Digite o número da opção: "

if /i "%opcao%"=="0" goto END
if /i "%opcao%"=="H" goto HELP
if "%opcao%"=="1" goto MODULE_01
if "%opcao%"=="2" goto MODULE_02
if "%opcao%"=="3" goto NOT_AVAILABLE
if "%opcao%"=="4" goto NOT_AVAILABLE
if "%opcao%"=="5" goto NOT_AVAILABLE
if "%opcao%"=="6" goto NOT_AVAILABLE
if "%opcao%"=="7" goto NOT_AVAILABLE
if "%opcao%"=="8" goto NOT_AVAILABLE

echo.
echo [ERRO] Opção inválida!
timeout /t 2 >nul
goto MAIN_MENU

:MODULE_01
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║         MÓDULO 01: REPAIR - Reparos do Sistema        ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo  [1] WINrepair Lite - Reparo rápido (SFC + DISM)
echo  [2] WINrepair Full - Reparo completo do sistema
echo  [3] Repair Network - Reset de configurações de rede
echo  [4] Repair Store - Reparo do Windows Store e apps UWP
echo.
echo  [0] Voltar ao menu principal
echo.
echo ───────────────────────────────────────────────────────────
echo.

set /p "subopcao=Digite o número da opção: "

if "%subopcao%"=="0" goto MAIN_MENU
if "%subopcao%"=="1" (
    echo.
    echo [INFO] Executando WINrepair Lite...
    echo.
    cd /d "%~dp0windows\01-repair"
    call WINrepair-lite.bat
    cd /d "%~dp0"
    pause
    goto MAIN_MENU
)
if "%subopcao%"=="2" (
    echo.
    echo [INFO] Executando WINrepair Full...
    echo.
    cd /d "%~dp0windows\01-repair"
    call WINrepair-full.bat
    cd /d "%~dp0"
    pause
    goto MAIN_MENU
)
if "%subopcao%"=="3" (
    echo.
    echo [INFO] Executando Repair Network...
    echo.
    cd /d "%~dp0windows\01-repair"
    powershell -ExecutionPolicy Bypass -File repair-network.ps1
    cd /d "%~dp0"
    pause
    goto MAIN_MENU
)
if "%subopcao%"=="4" (
    echo.
    echo [INFO] Executando Repair Store...
    echo.
    cd /d "%~dp0windows\01-repair"
    powershell -ExecutionPolicy Bypass -File repair-store.ps1
    cd /d "%~dp0"
    pause
    goto MAIN_MENU
)

echo.
echo [ERRO] Opção inválida!
timeout /t 2 >nul
goto MODULE_01

:MODULE_02
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║      MÓDULO 02: MAINTENANCE - Manutenção e Limpeza   ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo  [1] Clean Temp - Limpeza rápida de temporários
echo  [2] Clean System - Limpeza profunda do sistema
echo  [3] Clean Updates - Remove atualizações antigas
echo  [4] Optimize Disk - Otimização inteligente HDD/SSD
echo.
echo  [0] Voltar ao menu principal
echo.
echo ───────────────────────────────────────────────────────────
echo.

set /p "subopcao=Digite o número da opção: "

if "%subopcao%"=="0" goto MAIN_MENU
if "%subopcao%"=="1" (
    echo.
    echo [INFO] Executando Clean Temp...
    echo.
    cd /d "%~dp0windows\02-maintenance"
    powershell -ExecutionPolicy Bypass -File clean-temp.ps1
    cd /d "%~dp0"
    pause
    goto MAIN_MENU
)
if "%subopcao%"=="2" (
    echo.
    echo [INFO] Executando Clean System...
    echo.
    cd /d "%~dp0windows\02-maintenance"
    powershell -ExecutionPolicy Bypass -File clean-system.ps1
    cd /d "%~dp0"
    pause
    goto MAIN_MENU
)
if "%subopcao%"=="3" (
    echo.
    echo [INFO] Executando Clean Updates...
    echo.
    cd /d "%~dp0windows\02-maintenance"
    powershell -ExecutionPolicy Bypass -File clean-updates.ps1
    cd /d "%~dp0"
    pause
    goto MAIN_MENU
)
if "%subopcao%"=="4" (
    echo.
    echo [INFO] Executando Optimize Disk...
    echo.
    cd /d "%~dp0windows\02-maintenance"
    powershell -ExecutionPolicy Bypass -File optimize-disk.ps1
    cd /d "%~dp0"
    pause
    goto MAIN_MENU
)

echo.
echo [ERRO] Opção inválida!
timeout /t 2 >nul
goto MODULE_02

:NOT_AVAILABLE
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║              MÓDULO EM DESENVOLVIMENTO                ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo Este módulo ainda está em desenvolvimento.
echo.
echo Acompanhe as atualizações no repositório:
echo https://github.com/marlonmotta/mmti-pc-toolkit
echo.
pause
goto MAIN_MENU

:HELP
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║                    AJUDA / DOCUMENTAÇÃO               ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo 📚 DOCUMENTAÇÃO:
echo.
echo   • README Principal: README.md
echo   • Documentação Técnica: README-TECH.md
echo   • Guia de Contribuição: CONTRIBUTING.md
echo   • Changelog: CHANGELOG.md
echo.
echo 🌐 RECURSOS ONLINE:
echo.
echo   • Site Oficial: https://marlonmotta.github.io/mmti-pc-toolkit/
echo   • Repositório: https://github.com/marlonmotta/mmti-pc-toolkit
echo.
echo ⚙️  REQUISITOS:
echo.
echo   • Windows 10 ou 11
echo   • Privilégios de Administrador
echo   • PowerShell 5.1+
echo.
echo 📞 SUPORTE:
echo.
echo   • Email: marlonmotta.ti@gmail.com
echo   • Issues: https://github.com/marlonmotta/mmti-pc-toolkit/issues
echo.
echo ───────────────────────────────────────────────────────────
echo.
pause
goto MAIN_MENU

:END
cls
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║                  OBRIGADO POR USAR!                   ║
echo ║            mm.ti Lab - PC Toolkit v1.0                ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo Sistema mm.ti Lab - PC Toolkit
echo Criado por Marlon Motta e equipe
echo.
timeout /t 2 >nul
exit /b 0


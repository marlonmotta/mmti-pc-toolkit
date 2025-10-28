# 🔧 Módulo 01: Repair (Reparos do Sistema)

> Scripts para reparar problemas do Windows

**Status:** ✅ Completo (5 scripts)

---

## 📋 Scripts Disponíveis

### 1. Repair Lite
**Arquivos:** `repair-lite.bat` | `repair-lite.ps1`

**O que faz:**
- Verificação DISM CheckHealth
- Análise DISM ScanHealth
- Reparo DISM RestoreHealth
- Verificação SFC ScanNow

**Tempo:** 15-60 minutos

**Como usar:**
```powershell
.\repair-lite.ps1
```

---

### 2. Repair Full
**Arquivos:** `repair-full.bat` | `repair-full.ps1`

**O que faz:**
- Tudo do Repair Lite +
- Limpeza de cache do Windows Update
- Limpeza de arquivos temporários
- Component Store Cleanup
- CHKDSK (opcional)

**Tempo:** 30-90 minutos

**Como usar:**
```powershell
.\repair-full.ps1
```

---

### 3. Auto-Enter Helper
**Arquivo:** `auto-enter-helper.vbs`

**O que faz:**
- Sistema anti-travamento para DISM
- Envia Enter automaticamente a cada 2 minutos
- Funciona em background

**Uso:** Executado automaticamente pelos scripts BAT

---

## 🚀 Início Rápido

### PowerShell
```powershell
# Abrir PowerShell como Administrador
cd caminho\para\mmti-pc-toolkit\windows\01-repair

# Reparo rápido
.\repair-lite.ps1

# Reparo completo
.\repair-full.ps1
```

### Batch
1. Navegar até a pasta
2. Clique direito no arquivo `.bat`
3. "Executar como Administrador"

---

## ⚙️ Requisitos

- ✅ Windows 7, 8, 10 ou 11
- ✅ Privilégios de Administrador
- ✅ 5-20 GB de espaço livre
- ✅ Conexão com internet (recomendado)

---

## 📊 Logs

Logs salvos em:
```
C:\mmti-toolkit-logs\
```

---

**© 2025 Marlon Motta - mm.ti Lab | GPL-3.0**


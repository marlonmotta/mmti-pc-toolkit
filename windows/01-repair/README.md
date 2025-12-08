# 🔧 Módulo 01: Repair (Reparos do Sistema)

> Scripts para reparar problemas do Windows

**Status:** ✅ Completo (6 scripts)

---

## 📋 Scripts Disponíveis

### 1. Repair Lite
**Arquivos:** `WINrepair-lite.bat` | `WINrepair-lite.ps1`

**O que faz:**
- Verificação DISM CheckHealth
- Análise DISM ScanHealth
- Reparo DISM RestoreHealth
- Verificação SFC ScanNow

**Tempo:** 15-60 minutos

**Como usar:**
```powershell
.\WINrepair-lite.ps1
```

---

### 2. Repair Full
**Arquivos:** `WINrepair-full.bat` | `WINrepair-full.ps1`

**O que faz:**
- Tudo do Repair Lite +
- Limpeza de cache do Windows Update
- Limpeza de arquivos temporários
- Component Store Cleanup
- CHKDSK (opcional)

**Tempo:** 30-90 minutos

**Como usar:**
```powershell
.\WINrepair-full.ps1
```

---

### 3. Repair Network
**Arquivo:** `repair-network.ps1`

**O que faz:**
- Reset do stack TCP/IP
- Reset do stack Winsock
- Reset de configurações DNS (IPv4 e IPv6)
- Reset de adaptadores de rede
- Limpeza de cache DNS

**Tempo:** 2-5 minutos

**Como usar:**
```powershell
.\repair-network.ps1
```

---

### 4. Repair Store
**Arquivo:** `repair-store.ps1`

**O que faz:**
- Para e reinicia serviços do Windows Store
- Limpa cache do Windows Store
- Reseta aplicativos UWP
- Reinstala Windows Store
- Corrige problemas com apps UWP

**Tempo:** 5-10 minutos

**Como usar:**
```powershell
.\repair-store.ps1
```

---

### 5. Auto-Enter Helper
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
.\WINrepair-lite.ps1

# Reparo completo
.\WINrepair-full.ps1
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


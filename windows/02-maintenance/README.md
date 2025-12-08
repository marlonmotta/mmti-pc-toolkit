# 🧹 Módulo 02: Maintenance (Manutenção e Limpeza)

> Scripts para limpeza e manutenção preventiva do Windows

**Status:** ✅ Completo (4 scripts)

---

## 📋 Scripts Disponíveis

### 1. Clean System
**Arquivo:** `clean-system.ps1`

**O que faz:**
- Limpeza de %TEMP% (sistema e usuário)
- Limpeza de cache de navegadores (Chrome, Edge, Firefox)
- Esvaziar lixeira
- Limpeza de prefetch
- Limpeza de logs antigos (>30 dias)
- Mostra espaço liberado e total de arquivos processados

**Tempo:** 5-15 minutos

**Como usar:**
```powershell
.\clean-system.ps1
```

---

### 2. Clean Temp
**Arquivo:** `clean-temp.ps1`

**O que faz:**
- Limpeza rápida de temporários (sistema e usuário)
- Esvaziar lixeira
- Limpeza de logs básicos (CBS, DISM)
- Mostra espaço liberado

**Tempo:** 1-3 minutos

**Como usar:**
```powershell
.\clean-temp.ps1
```

---

### 3. Clean Updates
**Arquivo:** `clean-updates.ps1`

**O que faz:**
- Remove atualizações antigas do Windows
- DISM Component Cleanup (com ResetBase)
- Limpeza de cache do Windows Update
- Libera 5-10 GB (esperado)

**Tempo:** 10-30 minutos

**Como usar:**
```powershell
.\clean-updates.ps1
```

---

### 4. Optimize Disk
**Arquivo:** `optimize-disk.ps1`

**O que faz:**
- Detecta automaticamente HDD vs SSD
- **HDD:** Desfragmentação completa
- **SSD:** TRIM (Otimização)
- Verifica estado de saúde do disco
- Otimização inteligente baseada no tipo

**Tempo:** 
- SSD: 1-5 minutos
- HDD: 10-60 minutos (depende do tamanho)

**Como usar:**
```powershell
.\optimize-disk.ps1
```

---

## 🚀 Início Rápido

### PowerShell
```powershell
# Abrir PowerShell como Administrador
cd caminho\para\mmti-pc-toolkit\windows\02-maintenance

# Limpeza rápida
.\clean-temp.ps1

# Limpeza profunda
.\clean-system.ps1

# Limpar atualizações antigas
.\clean-updates.ps1

# Otimizar disco
.\optimize-disk.ps1
```

---

## ⚙️ Requisitos

- ✅ Windows 10 ou 11
- ✅ Privilégios de Administrador
- ✅ PowerShell 5.1+
- ✅ Espaço livre no disco (para operações)

---

## 📊 Logs

Logs salvos em:
```
C:\mmti-toolkit-logs\
```

**Formato:**
```
YYYY-MM-DD_script-name.log
```

---

## 💡 Recomendações

- **Clean Temp:** Execute semanalmente ou quando precisar de espaço rápido
- **Clean System:** Execute mensalmente para manutenção preventiva
- **Clean Updates:** Execute a cada 3-6 meses ou quando precisar liberar espaço
- **Optimize Disk:** Execute mensalmente (SSD) ou a cada 2-3 meses (HDD)

---

**© 2025 Marlon Motta - mm.ti Lab | GPL-3.0**

---

## 🤝 Quer Contribuir?

Veja [CONTRIBUTING.md](../../CONTRIBUTING.md)

---

**© 2025 Marlon Motta - mm.ti Lab | GPL-3.0**


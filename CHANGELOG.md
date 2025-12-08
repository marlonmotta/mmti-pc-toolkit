# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

---

## [0.1.0-alpha] - 2025-10-28

### Adicionado

**Estrutura:**
- ✅ Estrutura multi-plataforma (windows/, linux/, docs/, shared/)
- ✅ Sistema de módulos (8 módulos organizados)
- ✅ Site GitHub Pages integrado

**Módulo 01: Repair**
- ✅ `repair-lite.bat` - Reparo rápido do sistema (SFC + DISM)
- ✅ `repair-lite.ps1` - Versão PowerShell do reparo rápido
- ✅ `repair-full.bat` - Reparo completo do sistema
- ✅ `repair-full.ps1` - Versão PowerShell do reparo completo
- ✅ `repair-network.ps1` - Reset completo de configurações de rede
- ✅ `repair-store.ps1` - Reparo do Windows Store e apps UWP
- ✅ `auto-enter-helper.vbs` - Sistema anti-travamento para DISM

**Módulo 02: Maintenance**
- ✅ `clean-system.ps1` - Limpeza profunda do sistema
- ✅ `clean-temp.ps1` - Limpeza rápida de arquivos temporários
- ✅ `clean-updates.ps1` - Remove atualizações antigas do Windows
- ✅ `optimize-disk.ps1` - Otimização inteligente HDD/SSD

**Site (GitHub Pages):**
- ✅ `index.html` - Página principal com tabela de scripts
- ✅ `style.css` - Design responsivo e moderno
- ✅ `search.js` - Sistema de busca em tempo real
- ✅ `copy.js` - Botões para copiar comandos
- ✅ `scripts-data.js` - Dados estruturados dos scripts

**Ferramentas:**
- ✅ `mmti-toolkit.bat` - Menu principal interativo

**Documentação:**
- ✅ `README.md` - Documentação principal para usuários
- ✅ `README-TECH.md` - Documentação técnica para desenvolvedores
- ✅ `CONTRIBUTING.md` - Guia de contribuição
- ✅ `LICENSE` - Licença GPL-3.0
- ✅ `.gitignore` - Arquivos ignorados pelo Git
- ✅ READMEs em cada módulo

**Sistema de Logging:**
- ✅ Logs centralizados em `C:\mmti-toolkit-logs\`
- ✅ Formato de data padronizado (YYYY-MM-DD_script-name.log)
- ✅ Níveis de log (INFO, SUCCESS, WARNING, ERROR)

### Características

- 🌐 Multi-plataforma desde o início (Windows completo, Linux preparado)
- 🔧 8 scripts funcionais e testados
- 🌐 Site profissional no GitHub Pages
- 📊 Sistema de busca e filtros
- 📋 Botões para copiar comandos
- 📝 Logging detalhado em todos os scripts
- 🎨 Interface moderna e responsiva
- 📱 Mobile-friendly
- 🔐 GPL-3.0 - Software livre

### Baseado Em

Este projeto é a evolução do [mmti-windows-repair](https://github.com/marlonmotta/mmti-windows-repair), expandindo de apenas reparos para uma suíte completa.

---

## [Unreleased]

### Adicionado (2025-01-XX)

**Correções:**
- ✅ Corrigido encoding UTF-8 com BOM em todos os scripts PowerShell
- ✅ Corrigidos blocos catch para usar `$($_.Exception.Message)` corretamente
- ✅ Atualizado `WINrepair-full.ps1` com versão corrigida

**Módulo 02: Maintenance - Concluído:**
- ✅ `clean-system.ps1` - Implementado com limpeza completa
- ✅ `clean-temp.ps1` - Implementado com limpeza rápida
- ✅ `clean-updates.ps1` - Implementado com DISM Component Cleanup
- ✅ `optimize-disk.ps1` - Implementado com detecção automática HDD/SSD
- ✅ README do módulo 02 atualizado com documentação completa

### Planejado para v0.2.0

**Módulo 03: Optimization**
- Otimização de inicialização
- Otimização para gaming
- Debloat de apps do Windows
- Otimização de serviços

**Módulo 04: Diagnostics**
- Modo diagnóstico inteligente
- Relatórios HTML avançados
- Monitor de temperatura
- Análise de performance

**Melhorias:**
- Sistema de backup automático antes de operações críticas
- Relatórios HTML com gráficos
- Mais scripts de rede

### Planejado para v1.0.0

- Todos os 8 módulos completos (50+ scripts)
- Suporte inicial a Linux
- Interface gráfica (GUI) opcional
- Sistema de plugins

---

## Tipos de Mudanças

- `Adicionado` - para novas funcionalidades
- `Modificado` - para mudanças em funcionalidades existentes
- `Descontinuado` - para funcionalidades que serão removidas
- `Removido` - para funcionalidades removidas
- `Corrigido` - para correção de bugs
- `Segurança` - para vulnerabilidades corrigidas

---

**© 2025 Marlon Motta - mm.ti Lab | GPL-3.0**


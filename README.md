# 🛠️ mmti-pc-toolkit

![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux-blue)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue)
![Maintenance](https://img.shields.io/badge/Maintained-Yes-green)

> Suíte completa e multi-plataforma de scripts para manutenção, diagnóstico, otimização e automação de computadores

**Desenvolvido por:** [Marlon Motta](https://github.com/marlonmotta) - mm.ti Lab  
**Projeto anterior:** [mmti-windows-repair](https://github.com/marlonmotta/mmti-windows-repair)

---

## 🌐 Site Oficial

**Visite nosso site para navegação fácil e download direto:**

### 🔗 [https://marlonmotta.github.io/mmti-pc-toolkit/](https://marlonmotta.github.io/mmti-pc-toolkit/)

No site você encontra:
- 📋 Tabela completa de scripts com busca
- 📋 Botões para copiar comandos
- 📖 Documentação interativa
- ⬇️ Downloads diretos

---

## 📋 Sobre o Projeto

Este é um projeto **open source** (GPL-3.0) criado para facilitar o trabalho de técnicos de informática, sysadmins e entusiastas. Todos os scripts são gratuitos e podem ser modificados e compartilhados livremente.

**Objetivo:** Centralizar ferramentas profissionais que aceleram diagnósticos, reparos, otimizações e automação em computadores.

### 🌟 Evolução do mmti-windows-repair

Este projeto é a **evolução** do [mmti-windows-repair](https://github.com/marlonmotta/mmti-windows-repair), expandindo de apenas reparos para uma suíte completa de ferramentas.

---

## 🖥️ Plataformas Suportadas

| Plataforma | Status | Módulos | Scripts |
|------------|--------|---------|---------|
| **Windows 10/11** | ✅ Pronto | 8 módulos | 9+ scripts |
| **Linux** | 🚧 Em desenvolvimento | TBD | TBD |
| **macOS** | 📅 Planejado | - | - |

---

## 📂 Módulos Disponíveis

### 🔧 01. Repair (Reparos do Sistema)
**Scripts:** 4 | **Status:** ✅ Completo

- `repair-lite` - Reparo rápido (SFC + DISM)
- `repair-full` - Reparo completo do sistema
- `repair-network` - Reset completo de configurações de rede
- `repair-store` - Reparo do Windows Store e apps UWP

### 🧹 02. Maintenance (Manutenção e Limpeza)
**Scripts:** 4 | **Status:** ✅ Completo

- `clean-system` - Limpeza profunda do sistema
- `clean-temp` - Limpeza rápida de temporários
- `clean-updates` - Remove atualizações antigas do Windows
- `optimize-disk` - Otimização inteligente HDD/SSD

### ⚡ 03. Optimization (Otimização de Performance)
**Status:** 🚧 Em desenvolvimento

### 📊 04. Diagnostics (Diagnóstico e Relatórios)
**Status:** 🚧 Em desenvolvimento

### 🛡️ 05. Security (Segurança e Proteção)
**Status:** 🚧 Em desenvolvimento

### 🚀 06. Automation (Automação e Setup)
**Status:** 🚧 Em desenvolvimento

### 🌐 07. Network (Ferramentas de Rede)
**Status:** 🚧 Em desenvolvimento

### 🎯 08. Specialized (Ferramentas Especializadas)
**Status:** 🚧 Em desenvolvimento

---

## 📥 Como Usar

### Opção 1: Site (Mais Fácil)
1. Acesse [https://marlonmotta.github.io/mmti-pc-toolkit/](https://marlonmotta.github.io/mmti-pc-toolkit/)
2. Navegue pela tabela de scripts
3. Clique no botão "Copiar" para copiar o comando
4. Cole no PowerShell como Administrador

### Opção 2: Clone o Repositório
```bash
git clone https://github.com/marlonmotta/mmti-pc-toolkit.git
cd mmti-pc-toolkit
```

### Opção 3: Download ZIP
1. Clique no botão verde "Code" → "Download ZIP"
2. Extraia o arquivo
3. Navegue até a pasta do script desejado

---

## 🚀 Execução Rápida

### Windows

**PowerShell:**
```powershell
# Abra PowerShell como Administrador
cd caminho\para\mmti-pc-toolkit\windows

# Execute o script desejado
.\01-repair\repair-lite.ps1
```

**Batch:**
```batch
# Clique direito no arquivo .bat
# Selecione "Executar como Administrador"
```

**Menu Interativo:**
```powershell
# Execute o menu principal
.\mmti-toolkit.bat
```

### Linux (Futuro)
```bash
chmod +x script.sh
sudo ./script.sh
```

---

## ⚙️ Requisitos

### Windows
- ✅ Windows 10 ou 11 (Windows 7/8 para alguns scripts)
- ✅ Privilégios de Administrador
- ✅ PowerShell 5.1+ (já incluído no Windows 10/11)
- ✅ 5-20 GB de espaço livre no disco C:
- ✅ Conexão com internet (recomendado)

### Como Habilitar Execução de Scripts PowerShell
Se for a primeira vez executando scripts PowerShell:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 📝 Scripts em Destaque

### 🔧 Windows Repair Full
Reparo completo do sistema Windows com DISM, SFC e CHKDSK

**Uso:**
```powershell
.\windows\01-repair\repair-full.ps1
```

### 🧹 System Cleanup
Limpeza profunda de arquivos temporários, cache e lixeira

**Uso:**
```powershell
.\windows\02-maintenance\clean-system.ps1
```

### 🌐 Network Reset
Reset completo de configurações de rede para resolver problemas de conectividade

**Uso:**
```powershell
.\windows\01-repair\repair-network.ps1
```

---

## 📊 Logs

Todos os scripts salvam logs detalhados em:

**Windows:**
```
C:\mmti-toolkit-logs\
```

**Formato:**
```
YYYY-MM-DD_script-name.log
```

---

## 🤝 Como Contribuir

Contribuições são muito bem-vindas! Este é um projeto colaborativo.

### Formas de Contribuir

1. **Criar novos scripts**
   - Fork o repositório
   - Adicione seu script no módulo apropriado
   - Envie um Pull Request

2. **Melhorar scripts existentes**
   - Corrija bugs
   - Adicione funcionalidades
   - Melhore a documentação

3. **Reportar problemas**
   - Abra uma [Issue](https://github.com/marlonmotta/mmti-pc-toolkit/issues)
   - Descreva o problema com detalhes
   - Inclua versão do Windows e logs

4. **Tradução**
   - Ajude a traduzir para outros idiomas

### Diretrizes

- ✅ Scripts devem ter comentários em português
- ✅ Incluir descrição clara do que faz
- ✅ Adicionar exemplos de uso
- ✅ Testar em ambiente seguro antes de enviar
- ✅ Seguir estrutura de módulos existente
- ✅ Manter licença GPL-3.0

**Leia mais:** [CONTRIBUTING.md](CONTRIBUTING.md)

---

## 📜 Licença

Este projeto está licenciado sob a **GNU General Public License v3.0 (GPL-3.0)**.

### O que isso significa?

✅ **Você pode:**
- Usar para qualquer propósito (pessoal ou comercial)
- Modificar o código-fonte
- Distribuir cópias
- Distribuir versões modificadas

⚠️ **Você deve:**
- Manter a mesma licença (GPL-3.0)
- Disponibilizar o código-fonte de versões modificadas
- Documentar mudanças feitas
- Incluir avisos de copyright e licença

Leia o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## ⚠️ Avisos Importantes

- **Backup:** Sempre faça backup antes de executar scripts de sistema
- **Teste:** Teste scripts em máquina virtual quando possível
- **Responsabilidade:** Use por sua conta e risco
- **Antivírus:** Alguns scripts podem ser detectados como falso-positivo

---

## 📚 Documentação Adicional

- **[README-TECH.md](README-TECH.md)** - Documentação técnica para desenvolvedores
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Guia para contribuidores
- **[CHANGELOG.md](CHANGELOG.md)** - Histórico de versões
- **Módulos:**
  - [01-Repair](windows/01-repair/README.md)
  - [02-Maintenance](windows/02-maintenance/README.md)

---

## 🎯 Roadmap

### v0.1.0-alpha (Atual)
- [x] Estrutura multi-plataforma
- [x] Site GitHub Pages
- [x] Módulo 01: Repair (4 scripts)
- [x] Módulo 02: Maintenance (4 scripts)
- [x] Menu principal interativo

### v0.2.0 (Próximo)
- [ ] Módulo 03: Optimization (10+ scripts)
- [ ] Módulo 04: Diagnostics (8+ scripts)
- [ ] Relatórios HTML avançados
- [ ] Sistema de logging melhorado

### v1.0.0 (Futuro)
- [ ] Todos os 8 módulos completos
- [ ] Modo diagnóstico inteligente
- [ ] Suporte inicial a Linux
- [ ] Interface gráfica (GUI) opcional

---

## 📞 Suporte e Contato

### Encontrou um bug? Tem uma sugestão?

- 🐛 [Abra uma Issue](https://github.com/marlonmotta/mmti-pc-toolkit/issues)
- 💬 [Discussions](https://github.com/marlonmotta/mmti-pc-toolkit/discussions)
- 📧 Email: marlonmotta.ti@gmail.com
- 🌐 Site: [https://marlonmotta.github.io/mmti-pc-toolkit/](https://marlonmotta.github.io/mmti-pc-toolkit/)

---

## 🙏 Agradecimentos

- Comunidade de técnicos de informática
- Todos que testaram e deram feedback
- Contribuidores do projeto
- Usuários do [mmti-windows-repair](https://github.com/marlonmotta/mmti-windows-repair)
- **Você, por usar este projeto!** 😊

---

## ⭐ Gostou? Dê uma Estrela!

Se este projeto foi útil para você, considere dar uma ⭐ no repositório!

Isso ajuda outras pessoas a encontrarem a ferramenta e motiva a continuar desenvolvendo.

[![GitHub stars](https://img.shields.io/github/stars/marlonmotta/mmti-pc-toolkit?style=social)](https://github.com/marlonmotta/mmti-pc-toolkit/stargazers)

---

## 📈 Status do Projeto

![GitHub last commit](https://img.shields.io/github/last-commit/marlonmotta/mmti-pc-toolkit)
![GitHub issues](https://img.shields.io/github/issues/marlonmotta/mmti-pc-toolkit)
![GitHub pull requests](https://img.shields.io/github/issues-pr/marlonmotta/mmti-pc-toolkit)

---

**Continue explorando. Continue aprendendo.** 🔥💻🎯

**Sistema mm.ti Lab - PC Toolkit v0.1.0-alpha**

_Feito com ❤️ por [Marlon Motta](https://github.com/marlonmotta) e comunidade_

---

**© 2025 Marlon Motta - mm.ti Lab | Licença GPL-3.0**


# 🔧 mmti-pc-toolkit - Documentação Técnica

> Guia completo para desenvolvedores, contribuidores e técnicos avançados

**Autor:** Marlon Motta - mm.ti Lab  
**Email:** marlonmotta.ti@gmail.com  
**GitHub:** https://github.com/marlonmotta/mmti-pc-toolkit  
**Licença:** GPL-3.0

---

## 📑 Índice

1. [Arquitetura do Projeto](#arquitetura-do-projeto)
2. [Estrutura de Arquivos](#estrutura-de-arquivos)
3. [Padrões de Código](#padrões-de-código)
4. [Como Criar Novos Scripts](#como-criar-novos-scripts)
5. [Sistema de Logging](#sistema-de-logging)
6. [Testes](#testes)
7. [Como Customizar para Seu Uso](#como-customizar-para-seu-uso)
8. [Debugging](#debugging)
9. [Contribuindo](#contribuindo)

---

## 🏗️ Arquitetura do Projeto

### Estrutura Multi-Plataforma

O projeto é organizado para suportar múltiplas plataformas desde o início:

```
mmti-pc-toolkit/
│
├── windows/          ← Scripts Windows (8 módulos)
├── linux/            ← Scripts Linux (futuro)
├── docs/             ← Site GitHub Pages
├── shared/           ← Recursos compartilhados
└── tools/            ← Ferramentas auxiliares
```

### Módulos

Cada plataforma é dividida em **8 módulos especializados**:

1. **01-repair** - Reparos do sistema
2. **02-maintenance** - Manutenção e limpeza
3. **03-optimization** - Otimização de performance
4. **04-diagnostics** - Diagnóstico e relatórios
5. **05-security** - Segurança e proteção
6. **06-automation** - Automação e setup
7. **07-network** - Ferramentas de rede
8. **08-specialized** - Ferramentas especializadas

---

## 📂 Estrutura de Arquivos

### Raiz do Projeto

```
mmti-pc-toolkit/
├── README.md                 ← Documentação principal (usuários)
├── README-TECH.md            ← Este arquivo (desenvolvedores)
├── CONTRIBUTING.md           ← Guia de contribuição
├── LICENSE                   ← GPL-3.0
├── CHANGELOG.md              ← Histórico de versões
└── .gitignore                ← Arquivos ignorados pelo Git
```

### Windows Scripts

```
windows/
├── mmti-toolkit.bat          ← Menu principal interativo
│
├── 01-repair/
│   ├── repair-lite.bat
│   ├── repair-lite.ps1
│   ├── repair-full.bat
│   ├── repair-full.ps1
│   ├── repair-network.ps1
│   ├── repair-store.ps1
│   ├── auto-enter-helper.vbs
│   └── README.md
│
├── 02-maintenance/
│   ├── clean-system.ps1
│   ├── clean-temp.ps1
│   ├── clean-updates.ps1
│   ├── optimize-disk.ps1
│   └── README.md
│
└── 03-08.../
    └── README.md (placeholders)
```

### Site (GitHub Pages)

```
docs/
├── index.html                ← Página principal
├── css/
│   └── style.css
├── js/
│   ├── search.js            ← Sistema de busca
│   ├── copy.js              ← Copiar para clipboard
│   └── scripts-data.js      ← Dados dos scripts
└── assets/
    └── logo.png
```

---

## 💻 Padrões de Código

### PowerShell Scripts

#### Header Obrigatório

```powershell
<#
.SYNOPSIS
    Título curto do script
    
.DESCRIPTION
    Descrição detalhada do que o script faz
    
.PARAMETER ParameterName
    Descrição do parâmetro (se houver)
    
.EXAMPLE
    PS> .\script.ps1
    Exemplo de uso
    
.NOTES
    Autor: Marlon Motta
    Email: marlonmotta.ti@gmail.com
    Sistema: mm.ti Lab
    Projeto: mmti-pc-toolkit
    GitHub: https://github.com/marlonmotta/mmti-pc-toolkit
    Licença: GPL-3.0
    Versão: 1.0.0
    Data: DD/MM/YYYY
    
.LINK
    https://github.com/marlonmotta/mmti-pc-toolkit
#>
```

#### Verificação de Privilégios

TODO script deve verificar se está rodando como Admin:

```powershell
# Verifica privilégios de Administrador
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERRO: Este script precisa ser executado como Administrador!" -ForegroundColor Red
    Write-Host "Clique direito no arquivo e selecione 'Executar como Administrador'" -ForegroundColor Yellow
    pause
    exit 1
}
```

#### Sistema de Logging

```powershell
# Configuração de log
$LogDir = "C:\mmti-toolkit-logs"
$LogFile = Join-Path $LogDir "$(Get-Date -Format 'yyyy-MM-dd')_script-name.log"

# Criar diretório se não existir
if (-not (Test-Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
}

# Função de log
function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogMessage = "[$Timestamp] [$Level] $Message"
    Add-Content -Path $LogFile -Value $LogMessage
    Write-Host $LogMessage
}

# Usar:
Write-Log "Iniciando script..." "INFO"
Write-Log "Erro encontrado" "ERROR"
```

#### Tratamento de Erros

```powershell
try {
    # Código que pode gerar erro
    $result = Some-Command
    Write-Log "Operação bem-sucedida" "SUCCESS"
}
catch {
    Write-Log "Erro: $_" "ERROR"
    # Tratamento do erro
}
```

#### Barra de Progresso

```powershell
Write-Progress -Activity "Nome da Operação" `
               -Status "Processando..." `
               -PercentComplete 50
```

---

### Batch Scripts

#### Header Obrigatório

```batch
@echo off
REM ========================================
REM Script: Nome do Script
REM Descrição: Breve descrição
REM 
REM Autor: Marlon Motta
REM Email: marlonmotta.ti@gmail.com
REM Sistema: mm.ti Lab
REM Projeto: mmti-pc-toolkit
REM GitHub: https://github.com/marlonmotta/mmti-pc-toolkit
REM Licença: GPL-3.0
REM Versão: 1.0.0
REM Data: DD/MM/YYYY
REM ========================================
```

#### Verificação de Admin

```batch
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERRO: Execute como Administrador!
    pause
    exit /b 1
)
```

#### Codificação

```batch
chcp 65001 >nul
```

---

## 🛠️ Como Criar Novos Scripts

### Passo 1: Escolher o Módulo

Determine em qual módulo o script se encaixa:

- **Reparo?** → 01-repair
- **Limpeza?** → 02-maintenance
- **Otimização?** → 03-optimization
- **Diagnóstico?** → 04-diagnostics
- **Segurança?** → 05-security
- **Automação?** → 06-automation
- **Rede?** → 07-network
- **Especializado?** → 08-specialized

### Passo 2: Nomear o Script

Padrão: `ação-objeto.ps1` ou `ação-objeto.bat`

**Exemplos:**
- `clean-temp.ps1`
- `optimize-startup.ps1`
- `diagnose-network.ps1`
- `backup-registry.ps1`

### Passo 3: Criar o Arquivo

```powershell
# Usar template do header (veja acima)
# Adicionar verificação de admin
# Implementar logging
# Adicionar tratamento de erros
# Documentar inline
```

### Passo 4: Testar

```powershell
# Testar em máquina virtual
# Testar com diferentes versões do Windows
# Verificar logs
# Confirmar que não quebra nada
```

### Passo 5: Documentar

Adicionar ao README do módulo:

```markdown
### Nome do Script
**Arquivo:** `nome-script.ps1`

**O que faz:**
- Item 1
- Item 2

**Como usar:**
```powershell
.\nome-script.ps1
```

**Tempo estimado:** X minutos
```

### Passo 6: Atualizar Site

Adicionar em `docs/js/scripts-data.js`:

```javascript
{
    id: "win-nome-script",
    name: "Nome do Script",
    platform: "windows",
    module: "02-maintenance",
    difficulty: "easy",
    description: "Descrição curta",
    command: "powershell -File windows/02-maintenance/nome-script.ps1",
    fileSize: "XX KB",
    requiresAdmin: true,
    featured: false,
    popularity: 3,
    tags: ["tag1", "tag2"],
    downloadUrl: "https://raw.githubusercontent.com/marlonmotta/mmti-pc-toolkit/main/windows/02-maintenance/nome-script.ps1"
}
```

---

## 📊 Sistema de Logging

### Localização

Todos os logs são salvos em:
```
C:\mmti-toolkit-logs\
```

### Formato de Nome

```
YYYY-MM-DD_script-name.log
```

### Níveis de Log

- **INFO** - Informações gerais
- **SUCCESS** - Operação bem-sucedida
- **WARNING** - Aviso
- **ERROR** - Erro

### Exemplo de Log

```
[2025-10-28 14:30:15] [INFO] Iniciando limpeza do sistema...
[2025-10-28 14:30:20] [SUCCESS] Pasta TEMP limpa: 2.5 GB liberados
[2025-10-28 14:30:25] [WARNING] Não foi possível deletar C:\temp\arquivo.tmp
[2025-10-28 14:30:30] [ERROR] Erro ao acessar C:\Windows\SomeDir
[2025-10-28 14:35:45] [INFO] Processo concluído
```

---

## 🧪 Testes

### Checklist Antes de Publicar

- [ ] Script executado como Admin
- [ ] Testado em Windows 10
- [ ] Testado em Windows 11
- [ ] Logs gerados corretamente
- [ ] Erros tratados graciosamente
- [ ] Sem hardcoded paths
- [ ] Comentários claros
- [ ] Header completo
- [ ] README do módulo atualizado
- [ ] Site atualizado

### Ambientes de Teste

**Recomendado:**
1. Máquina virtual (Windows 10)
2. Máquina virtual (Windows 11)
3. Ambiente de produção (com cautela)

**Ferramentas:**
- VirtualBox
- Hyper-V
- VMware

---

## 🔄 Como Customizar para Seu Uso

### Para Outros Técnicos Usando Este Projeto

Se você quer usar este projeto como base para seus próprios scripts, siga estes passos:

#### 1. Fazer Fork do Projeto

```bash
# No GitHub, clique em "Fork"
# Clone seu fork
git clone https://github.com/SEU-USUARIO/mmti-pc-toolkit.git
```

#### 2. Substituir Informações do Autor

**Buscar e substituir em TODO o projeto:**

| Original | Substitua por |
|----------|---------------|
| `marlonmotta` | `seu-usuario` |
| `marlonmotta.ti@gmail.com` | `seu-email@exemplo.com` |
| `Marlon Motta` | `Seu Nome` |
| `mm.ti Lab` | `Seu Sistema/Empresa` |

**Arquivos principais para editar:**

- `README.md` (header e footer)
- `README-TECH.md` (este arquivo)
- `CONTRIBUTING.md`
- `LICENSE` (linha de copyright)
- Cada script (header comentado)
- `docs/index.html` (footer e links)
- `docs/js/scripts-data.js` (URLs de download)

#### 3. Atualizar URLs

```
https://github.com/marlonmotta/mmti-pc-toolkit
    ↓
https://github.com/SEU-USUARIO/mmti-pc-toolkit

https://marlonmotta.github.io/mmti-pc-toolkit/
    ↓
https://SEU-USUARIO.github.io/mmti-pc-toolkit/
```

#### 4. Customizar Visual (Opcional)

**Logo:**
- Substituir `docs/assets/logo.png`

**Cores do site:**
- Editar `docs/css/style.css`
- Variáveis CSS no início do arquivo

**Nome do projeto:**
- Se quiser renomear completamente

#### 5. Manter Licença GPL-3.0

⚠️ **IMPORTANTE:** Como este projeto é GPL-3.0, seu fork também DEVE ser GPL-3.0.

**No LICENSE, mantenha:**
```
Based on mmti-pc-toolkit by Marlon Motta
Original: https://github.com/marlonmotta/mmti-pc-toolkit
```

#### 6. Script de Busca e Substituição (Windows)

Crie um `customize.ps1`:

```powershell
$oldAuthor = "Marlon Motta"
$newAuthor = "Seu Nome"
$oldEmail = "marlonmotta.ti@gmail.com"
$newEmail = "seu-email@exemplo.com"
$oldUser = "marlonmotta"
$newUser = "seu-usuario"
$oldSystem = "mm.ti Lab"
$newSystem = "Seu Sistema"

Get-ChildItem -Recurse -File | ForEach-Object {
    (Get-Content $_.FullName) |
    ForEach-Object {
        $_ -replace $oldAuthor,$newAuthor `
           -replace $oldEmail,$newEmail `
           -replace $oldUser,$newUser `
           -replace $oldSystem,$newSystem
    } | Set-Content $_.FullName
}

Write-Host "Personalização concluída!" -ForegroundColor Green
```

Execute:
```powershell
.\customize.ps1
```

---

## 🐛 Debugging

### PowerShell

#### Habilitar Verbose

```powershell
$VerbosePreference = "Continue"
```

#### Debug Points

```powershell
Write-Debug "Valor da variável: $var"
```

#### Breakpoints

No PowerShell ISE:
- F9 para adicionar breakpoint
- F5 para executar com debug

### Batch

#### Echo para Debug

```batch
echo DEBUG: Valor = %var%
```

#### Pausar Execução

```batch
pause
```

### Logs

Sempre consulte os logs em `C:\mmti-toolkit-logs\`

---

## 🤝 Contribuindo

### Workflow de Contribuição

1. **Fork** o repositório
2. **Clone** seu fork
3. **Crie uma branch** para sua feature
4. **Faça suas mudanças**
5. **Teste** extensivamente
6. **Commit** com mensagem descritiva
7. **Push** para seu fork
8. **Abra um Pull Request**

### Mensagens de Commit

Use Conventional Commits:

```
feat: Adiciona script de otimização de RAM
fix: Corrige erro no clean-system.ps1
docs: Atualiza README do módulo 02
refactor: Melhora função de logging
test: Adiciona testes para repair-network
```

### Code Review

Seu PR será revisado para:
- ✅ Funcionalidade
- ✅ Qualidade do código
- ✅ Documentação
- ✅ Testes
- ✅ Compatibilidade

---

## 📚 Recursos Adicionais

### Links Úteis

- [PowerShell Documentation](https://docs.microsoft.com/powershell/)
- [Batch Scripting](https://ss64.com/nt/)
- [GPL-3.0 License](https://www.gnu.org/licenses/gpl-3.0.html)

### Projetos Similares

- [Chris Titus Tech WinUtil](https://github.com/ChrisTitusTech/winutil)
- [Windows Debloater](https://github.com/Sycnex/Windows10Debloater)

---

## 💡 Dicas de Desenvolvimento

### Performance

- Minimize operações de I/O
- Use pipelines do PowerShell
- Evite loops desnecessários
- Cache resultados quando possível

### Segurança

- SEMPRE valide inputs
- Nunca execute comandos baseados em input do usuário sem validação
- Use caminhos relativos quando possível
- Documente requisitos de permissões

### Manutenibilidade

- Código limpo e legível
- Comentários onde necessário
- Funções reutilizáveis
- Evite duplicação

---

## 🎓 Conceitos Avançados

### Módulos PowerShell

Considere criar módulos `.psm1` para funções reutilizáveis:

```powershell
# common-functions.psm1
function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

Export-ModuleMember -Function Write-ColorOutput
```

Importar:
```powershell
Import-Module .\common-functions.psm1
```

### Assinatura de Scripts

Para distribuição empresarial, considere assinar scripts:

```powershell
$cert = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert
Set-AuthenticodeSignature -FilePath .\script.ps1 -Certificate $cert
```

---

## 📞 Suporte Técnico

**Dúvidas técnicas?**

- 📧 Email: marlonmotta.ti@gmail.com
- 💬 [GitHub Discussions](https://github.com/marlonmotta/mmti-pc-toolkit/discussions)
- 🐛 [Issues](https://github.com/marlonmotta/mmti-pc-toolkit/issues)

---

## 📜 Licença

Este projeto e toda sua documentação estão sob licença **GPL-3.0**.

Ao contribuir, você concorda em licenciar suas contribuições sob a mesma licença.

---

**Happy Coding!** 🚀💻

**© 2025 Marlon Motta - mm.ti Lab | GPL-3.0**


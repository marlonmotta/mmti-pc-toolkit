# 🤝 Guia de Contribuição - mmti-pc-toolkit

Obrigado pelo interesse em contribuir com o **mmti-pc-toolkit**! 🎉

Este documento fornece diretrizes para contribuir com o projeto de forma efetiva.

---

## 📋 Índice

1. [Código de Conduta](#código-de-conduta)
2. [Como Posso Contribuir?](#como-posso-contribuir)
3. [Diretrizes de Desenvolvimento](#diretrizes-de-desenvolvimento)
4. [Processo de Pull Request](#processo-de-pull-request)
5. [Padrões de Código](#padrões-de-código)
6. [Reportando Bugs](#reportando-bugs)
7. [Sugerindo Melhorias](#sugerindo-melhorias)

---

## 📜 Código de Conduta

### Nossa Promessa

Queremos fazer deste projeto um ambiente acolhedor e inclusivo para todos, independente de:
- Experiência
- Gênero
- Identidade de gênero
- Orientação sexual
- Deficiência
- Aparência pessoal
- Raça
- Etnia
- Idade
- Religião
- Nacionalidade

### Comportamento Esperado

✅ **Seja respeitoso** com outros contribuidores  
✅ **Seja construtivo** em críticas e feedback  
✅ **Seja paciente** com novatos  
✅ **Seja colaborativo** e ajude outros  
✅ **Seja profissional** em toda comunicação  

### Comportamento Inaceitável

❌ Assédio, intimidação ou discriminação  
❌ Comentários ofensivos ou degradantes  
❌ Ataques pessoais ou políticos  
❌ Publicação de informações privadas sem permissão  
❌ Outras condutas não profissionais  

---

## 💡 Como Posso Contribuir?

### 1. Criar Novos Scripts

**Passos:**
1. Verifique se já não existe script similar
2. Escolha o módulo apropriado (01-08)
3. Crie o script seguindo os padrões
4. Teste extensivamente
5. Documente bem
6. Abra um Pull Request

**Ideias de scripts:**
- Consulte [Issues](https://github.com/marlonmotta/mmti-pc-toolkit/issues) com label `enhancement`
- Veja [IDEAS_PROJETO_COMPLETO.md](prompt-agents/mmti-pc-toolkit/IDEIAS_PROJETO_COMPLETO.md)

### 2. Melhorar Scripts Existentes

**O que você pode fazer:**
- Corrigir bugs
- Adicionar funcionalidades
- Melhorar performance
- Melhorar mensagens de erro
- Adicionar validações
- Melhorar logs

### 3. Melhorar Documentação

**Áreas que precisam de atenção:**
- README dos módulos
- Comentários inline nos scripts
- Exemplos de uso
- FAQ
- Tradução para outros idiomas

### 4. Testar

**Testamos em:**
- Windows 10 (diferentes builds)
- Windows 11
- Windows 7/8 (quando aplicável)
- Diferentes configurações de hardware

**Reporte:**
- Bugs encontrados
- Problemas de compatibilidade
- Sugestões de melhorias

### 5. Traduzir

**Idiomas que queremos suportar:**
- Inglês
- Espanhol
- Francês
- Alemão

### 6. Design

**Ajude com:**
- Logo do projeto
- Icons dos módulos
- Design do site
- Screenshots

---

## 🛠️ Diretrizes de Desenvolvimento

### Configurar Ambiente Local

```bash
# 1. Fork o projeto no GitHub

# 2. Clone seu fork
git clone https://github.com/SEU-USUARIO/mmti-pc-toolkit.git
cd mmti-pc-toolkit

# 3. Adicione o repositório original como upstream
git remote add upstream https://github.com/marlonmotta/mmti-pc-toolkit.git

# 4. Crie uma branch para sua feature
git checkout -b feature/minha-feature

# 5. Faça suas mudanças

# 6. Commit
git add .
git commit -m "feat: Descrição da feature"

# 7. Push para seu fork
git push origin feature/minha-feature

# 8. Abra um Pull Request no GitHub
```

### Sincronizar com Upstream

```bash
# Buscar mudanças do repositório original
git fetch upstream

# Merge com sua branch main
git checkout main
git merge upstream/main

# Push para seu fork
git push origin main
```

---

## 🔀 Processo de Pull Request

### Antes de Abrir um PR

**Checklist:**
- [ ] Código testado em pelo menos Windows 10 ou 11
- [ ] Comentários adicionados onde necessário
- [ ] Documentação atualizada (README, etc)
- [ ] Sem erros de sintaxe
- [ ] Segue padrões de código do projeto
- [ ] Commit messages seguem convenção
- [ ] Branch atualizada com main

### Abrir o Pull Request

1. **Título descritivo:**
   ```
   feat(maintenance): Adiciona script de limpeza de registro
   fix(repair): Corrige erro no repair-network
   docs(readme): Atualiza instruções de instalação
   ```

2. **Descrição completa:**
   ```markdown
   ## Descrição
   Breve descrição do que foi mudado

   ## Motivação
   Por que essa mudança é necessária?

   ## Tipo de mudança
   - [ ] Bug fix
   - [ ] Nova feature
   - [ ] Breaking change
   - [ ] Documentação

   ## Como foi testado?
   - Windows 10 (Build XXXXX)
   - Testado cenário X, Y, Z

   ## Screenshots (se aplicável)
   ```

3. **Aguarde review:**
   - Mantenedores irão revisar
   - Podem pedir mudanças
   - Seja receptivo ao feedback

4. **Após aprovação:**
   - PR será merged
   - Branch pode ser deletada

---

## 💻 Padrões de Código

### PowerShell

**Header obrigatório:**
```powershell
<#
.SYNOPSIS
    Título do script
    
.DESCRIPTION
    Descrição completa
    
.NOTES
    Autor: Seu Nome (para novos scripts) ou Marlon Motta (para modificações)
    Contribuidor: Seu Nome (se modificou script existente)
    Email: seu-email@exemplo.com
    Sistema: mm.ti Lab
    Licença: GPL-3.0
    Versão: 1.0.0
    Data: DD/MM/YYYY
#>
```

**Verificação de Admin:**
```powershell
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERRO: Execute como Administrador!" -ForegroundColor Red
    pause
    exit 1
}
```

**Logging:**
```powershell
$LogDir = "C:\mmti-toolkit-logs"
$LogFile = Join-Path $LogDir "$(Get-Date -Format 'yyyy-MM-dd')_script-name.log"
```

**Nomenclatura:**
- Variáveis: `$PascalCase`
- Funções: `Verb-Noun` (ex: `Get-SystemInfo`)
- Constantes: `$UPPER_CASE`

### Batch

**Header:**
```batch
REM ========================================
REM Script: Nome
REM Autor: Seu Nome
REM Sistema: mm.ti Lab
REM Licença: GPL-3.0
REM ========================================
```

**Codificação UTF-8:**
```batch
chcp 65001 >nul
```

### Comentários

**Bons comentários:**
```powershell
# Calcula espaço total liberado em GB
$FreeSpaceGB = [math]::Round($FreeSpace / 1GB, 2)
```

**Evite:**
```powershell
# Define variável
$x = 10  # ❌ Óbvio, não adiciona valor
```

---

## 🐛 Reportando Bugs

### Antes de Reportar

1. **Verifique** se já não foi reportado
2. **Teste** em ambiente limpo
3. **Colete** informações do sistema

### Template de Bug Report

```markdown
**Descrição do Bug**
Descrição clara e concisa do problema.

**Como Reproduzir**
1. Execute script X
2. Com parâmetro Y
3. Em ambiente Z
4. Veja erro

**Comportamento Esperado**
O que deveria acontecer.

**Comportamento Atual**
O que está acontecendo.

**Screenshots/Logs**
Se aplicável, anexe logs de C:\mmti-toolkit-logs\

**Ambiente:**
 - OS: [e.g. Windows 11 Pro 22H2]
 - PowerShell: [e.g. 5.1.22621.608]
 - Script: [e.g. clean-system.ps1 v1.0.0]

**Contexto Adicional**
Qualquer outra informação relevante.
```

### Labels

Use labels apropriadas:
- `bug` - Algo não está funcionando
- `critical` - Bug crítico que impede uso
- `documentation` - Problema na documentação
- `duplicate` - Issue duplicada
- `good first issue` - Bom para iniciantes
- `help wanted` - Precisamos de ajuda

---

## 💡 Sugerindo Melhorias

### Template de Feature Request

```markdown
**Sua feature está relacionada a um problema?**
Descrição clara do problema.

**Descreva a solução que você gostaria**
Como você imagina que deveria funcionar.

**Descreva alternativas consideradas**
Outras formas de resolver o problema.

**Contexto adicional**
Screenshots, exemplos, links, etc.
```

---

## 🏷️ Convenção de Commits

Usamos **Conventional Commits**:

### Formato

```
<tipo>[escopo opcional]: <descrição>

[corpo opcional]

[footer opcional]
```

### Tipos

- `feat` - Nova feature
- `fix` - Correção de bug
- `docs` - Mudanças na documentação
- `style` - Formatação (não afeta código)
- `refactor` - Refatoração
- `perf` - Melhoria de performance
- `test` - Adicionar testes
- `chore` - Tarefas de manutenção

### Exemplos

```bash
feat(maintenance): adiciona script de limpeza de registro
fix(repair): corrige erro ao executar DISM
docs(readme): atualiza instruções de instalação
refactor(logging): melhora função de log
perf(cleanup): otimiza algoritmo de busca de arquivos
```

### Escopo

Indica qual módulo foi afetado:
- `repair`
- `maintenance`
- `optimization`
- `diagnostics`
- `security`
- `automation`
- `network`
- `specialized`
- `site`
- `docs`

---

## 🧪 Testes

### Ambientes de Teste

**Mínimo necessário:**
- Windows 10 ou 11
- Máquina virtual recomendada

**Idealmente:**
- Windows 10 (várias builds)
- Windows 11
- Diferentes configurações de hardware

### Checklist de Teste

- [ ] Script executa sem erros
- [ ] Logging funciona corretamente
- [ ] Mensagens de erro são claras
- [ ] Tratamento de exceções funciona
- [ ] Não deixa arquivos/processos órfãos
- [ ] Pode ser executado múltiplas vezes
- [ ] Funciona com privilégios de admin
- [ ] Funciona em diferentes versões do Windows

---

## 📞 Comunicação

### Onde Tirar Dúvidas?

- 💬 [GitHub Discussions](https://github.com/marlonmotta/mmti-pc-toolkit/discussions) - Perguntas gerais
- 🐛 [Issues](https://github.com/marlonmotta/mmti-pc-toolkit/issues) - Bugs e features
- 📧 Email: marlonmotta.ti@gmail.com - Contato direto

### Tempo de Resposta

- Issues/PRs: Geralmente 2-5 dias úteis
- Discussões: Variável
- Email: 5-7 dias úteis

---

## 🎓 Recursos para Aprender

### PowerShell
- [Microsoft PowerShell Docs](https://docs.microsoft.com/powershell/)
- [PowerShell Gallery](https://www.powershellgallery.com/)
- [PowerShell.org](https://powershell.org/)

### Batch
- [SS64 Batch Reference](https://ss64.com/nt/)
- [Batch Scripting Guide](https://www.tutorialspoint.com/batch_script/)

### Git & GitHub
- [GitHub Docs](https://docs.github.com/)
- [Pro Git Book](https://git-scm.com/book/en/v2)
- [GitHub Skills](https://skills.github.com/)

---

## 🏆 Reconhecimento

Contribuidores serão:
- Listados no README principal
- Creditados nos scripts que criarem/modificarem
- Mencionados no CHANGELOG

**Top contribuidores** podem se tornar **mantenedores** do projeto!

---

## 📜 Licença

Ao contribuir, você concorda que suas contribuições serão licenciadas sob a **GPL-3.0**, a mesma licença do projeto.

---

## 🙏 Agradecimentos

Obrigado por considerar contribuir com o **mmti-pc-toolkit**!

Cada contribuição, por menor que seja, faz diferença e ajuda a comunidade de técnicos de informática. 💙

---

**Happy Contributing!** 🚀

**© 2025 Marlon Motta - mm.ti Lab | GPL-3.0**


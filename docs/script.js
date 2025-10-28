// Dados dos scripts
const scriptsData = [
    // Módulo 01 - Repair
    {
        name: "Reparo Completo do Sistema",
        category: "repair",
        description: "Executa DISM, SFC e verificação de disco para reparo completo do Windows",
        command: "WINrepair-full.bat",
        file: "windows/01-repair/WINrepair-full.bat"
    },
    {
        name: "Reparo Rápido",
        category: "repair", 
        description: "Versão simplificada com apenas SFC e verificação básica",
        command: "WINrepair-lite.bat",
        file: "windows/01-repair/WINrepair-lite.bat"
    },
    {
        name: "Reparo de Rede",
        category: "repair",
        description: "Reset completo de configurações de rede TCP/IP e DNS",
        command: "WINrepair-network.bat",
        file: "windows/01-repair/WINrepair-network.bat"
    },
    {
        name: "Reparo de Windows Update",
        category: "repair",
        description: "Corrige problemas com Windows Update e serviços relacionados",
        command: "WINrepair-update.bat",
        file: "windows/01-repair/WINrepair-update.bat"
    },
    {
        name: "Reparo de Windows Store",
        category: "repair",
        description: "Reset e reparo de aplicativos da Microsoft Store",
        command: "WINrepair-store.bat",
        file: "windows/01-repair/WINrepair-store.bat"
    },
    {
        name: "Reparo de Ícones",
        category: "repair",
        description: "Corrige ícones corrompidos e reconstrói cache de ícones",
        command: "WINrepair-icons.bat",
        file: "windows/01-repair/WINrepair-icons.bat"
    },

    // Módulo 02 - Maintenance
    {
        name: "Limpeza Completa do Sistema",
        category: "maintenance",
        description: "Limpeza profunda de arquivos temporários, cache e logs",
        command: "WINmaintenance-clean.bat",
        file: "windows/02-maintenance/WINmaintenance-clean.bat"
    },
    {
        name: "Otimização de SSD",
        category: "maintenance",
        description: "Otimização específica para unidades SSD",
        command: "WINmaintenance-ssd.bat",
        file: "windows/02-maintenance/WINmaintenance-ssd.bat"
    },
    {
        name: "Backup de Configurações",
        category: "maintenance",
        description: "Backup automático de configurações importantes do sistema",
        command: "WINmaintenance-backup.bat",
        file: "windows/02-maintenance/WINmaintenance-backup.bat"
    },
    {
        name: "Manutenção de Drivers",
        category: "maintenance",
        description: "Verificação e atualização de drivers do sistema",
        command: "WINmaintenance-drivers.bat",
        file: "windows/02-maintenance/WINmaintenance-drivers.bat"
    },

    // Módulo 03 - Optimization
    {
        name: "Otimização de Performance",
        category: "optimization",
        description: "Ajustes avançados para máximo desempenho do sistema",
        command: "WINoptimization-performance.bat",
        file: "windows/03-optimization/WINoptimization-performance.bat"
    },
    {
        name: "Otimização de Inicialização",
        category: "optimization",
        description: "Reduz tempo de boot e otimiza programas de inicialização",
        command: "WINoptimization-startup.bat",
        file: "windows/03-optimization/WINoptimization-startup.bat"
    },
    {
        name: "Otimização de Memória",
        category: "optimization",
        description: "Otimização de uso de RAM e arquivo de paginação",
        command: "WINoptimization-memory.bat",
        file: "windows/03-optimization/WINoptimization-memory.bat"
    },
    {
        name: "Otimização de Rede",
        category: "optimization",
        description: "Ajustes avançados de configurações de rede",
        command: "WINoptimization-network.bat",
        file: "windows/03-optimization/WINoptimization-network.bat"
    },

    // Módulo 04 - Diagnostics
    {
        name: "Diagnóstico Completo",
        category: "diagnostics",
        description: "Análise completa do sistema e geração de relatório",
        command: "WINdiagnostics-full.bat",
        file: "windows/04-diagnostics/WINdiagnostics-full.bat"
    },
    {
        name: "Teste de Hardware",
        category: "diagnostics",
        description: "Verificação de componentes de hardware",
        command: "WINdiagnostics-hardware.bat",
        file: "windows/04-diagnostics/WINdiagnostics-hardware.bat"
    },
    {
        name: "Análise de Performance",
        category: "diagnostics",
        description: "Monitoramento e análise de performance do sistema",
        command: "WINdiagnostics-performance.bat",
        file: "windows/04-diagnostics/WINdiagnostics-performance.bat"
    },
    {
        name: "Relatório de Sistema",
        category: "diagnostics",
        description: "Geração de relatório detalhado do sistema",
        command: "WINdiagnostics-report.bat",
        file: "windows/04-diagnostics/WINdiagnostics-report.bat"
    },

    // Módulo 05 - Security
    {
        name: "Verificação de Segurança",
        category: "security",
        description: "Scan completo de segurança com Windows Defender",
        command: "WINsecurity-scan.bat",
        file: "windows/05-security/WINsecurity-scan.bat"
    },
    {
        name: "Configuração de Firewall",
        category: "security",
        description: "Configuração avançada do Windows Firewall",
        command: "WINsecurity-firewall.bat",
        file: "windows/05-security/WINsecurity-firewall.bat"
    },
    {
        name: "Limpeza de Malware",
        category: "security",
        description: "Ferramentas avançadas de remoção de malware",
        command: "WINsecurity-malware.bat",
        file: "windows/05-security/WINsecurity-malware.bat"
    },
    {
        name: "Auditoria de Segurança",
        category: "security",
        description: "Auditoria completa de configurações de segurança",
        command: "WINsecurity-audit.bat",
        file: "windows/05-security/WINsecurity-audit.bat"
    },

    // Módulo 06 - Automation
    {
        name: "Automação de Tarefas",
        category: "automation",
        description: "Criação e gerenciamento de tarefas automatizadas",
        command: "WINautomation-tasks.bat",
        file: "windows/06-automation/WINautomation-tasks.bat"
    },
    {
        name: "Backup Automático",
        category: "automation",
        description: "Sistema de backup automático configurável",
        command: "WINautomation-backup.bat",
        file: "windows/06-automation/WINautomation-backup.bat"
    },
    {
        name: "Monitoramento de Sistema",
        category: "automation",
        description: "Monitoramento automático e alertas do sistema",
        command: "WINautomation-monitor.bat",
        file: "windows/06-automation/WINautomation-monitor.bat"
    },
    {
        name: "Manutenção Agendada",
        category: "automation",
        description: "Agendamento de tarefas de manutenção",
        command: "WINautomation-schedule.bat",
        file: "windows/06-automation/WINautomation-schedule.bat"
    },

    // Módulo 07 - Network
    {
        name: "Configuração de Rede",
        category: "network",
        description: "Configuração avançada de parâmetros de rede",
        command: "WINnetwork-config.bat",
        file: "windows/07-network/WINnetwork-config.bat"
    },
    {
        name: "Diagnóstico de Rede",
        category: "network",
        description: "Ferramentas de diagnóstico e troubleshooting de rede",
        command: "WINnetwork-diagnose.bat",
        file: "windows/07-network/WINnetwork-diagnose.bat"
    },
    {
        name: "Otimização de Rede",
        category: "network",
        description: "Otimização de performance de rede",
        command: "WINnetwork-optimize.bat",
        file: "windows/07-network/WINnetwork-optimize.bat"
    },
    {
        name: "Monitoramento de Rede",
        category: "network",
        description: "Monitoramento de tráfego e conexões de rede",
        command: "WINnetwork-monitor.bat",
        file: "windows/07-network/WINnetwork-monitor.bat"
    },

    // Módulo 08 - Specialized
    {
        name: "Ferramentas de Gaming",
        category: "specialized",
        description: "Otimizações específicas para jogos",
        command: "WINspecialized-gaming.bat",
        file: "windows/08-specialized/WINspecialized-gaming.bat"
    },
    {
        name: "Ferramentas de Desenvolvimento",
        category: "specialized",
        description: "Configuração de ambiente de desenvolvimento",
        command: "WINspecialized-dev.bat",
        file: "windows/08-specialized/WINspecialized-dev.bat"
    },
    {
        name: "Ferramentas de Servidor",
        category: "specialized",
        description: "Configurações específicas para Windows Server",
        command: "WINspecialized-server.bat",
        file: "windows/08-specialized/WINspecialized-server.bat"
    },
    {
        name: "Ferramentas de Virtualização",
        category: "specialized",
        description: "Configurações para ambientes virtualizados",
        command: "WINspecialized-vm.bat",
        file: "windows/08-specialized/WINspecialized-vm.bat"
    }
];

// Variáveis globais
let filteredScripts = [...scriptsData];
let currentCategory = 'all';

// Elementos DOM
const searchInput = document.getElementById('searchInput');
const clearSearch = document.getElementById('clearSearch');
const filterButtons = document.querySelectorAll('.filter-btn');
const scriptsTableBody = document.getElementById('scriptsTableBody');
const noResults = document.getElementById('noResults');
const toast = document.getElementById('toast');
const toastMessage = document.getElementById('toastMessage');

// Inicialização
document.addEventListener('DOMContentLoaded', function() {
    renderScripts();
    setupEventListeners();
});

// Event Listeners
function setupEventListeners() {
    // Busca
    searchInput.addEventListener('input', handleSearch);
    clearSearch.addEventListener('click', clearSearchInput);
    
    // Filtros
    filterButtons.forEach(button => {
        button.addEventListener('click', () => handleFilter(button.dataset.category));
    });
}

// Função de busca
function handleSearch() {
    const searchTerm = searchInput.value.toLowerCase().trim();
    
    if (searchTerm === '') {
        filteredScripts = [...scriptsData];
    } else {
        filteredScripts = scriptsData.filter(script => 
            script.name.toLowerCase().includes(searchTerm) ||
            script.description.toLowerCase().includes(searchTerm) ||
            script.category.toLowerCase().includes(searchTerm) ||
            script.command.toLowerCase().includes(searchTerm)
        );
    }
    
    applyCurrentFilter();
}

// Função de filtro
function handleFilter(category) {
    currentCategory = category;
    
    // Atualizar botões ativos
    filterButtons.forEach(button => {
        button.classList.remove('active');
        if (button.dataset.category === category) {
            button.classList.add('active');
        }
    });
    
    applyCurrentFilter();
}

// Aplicar filtro atual
function applyCurrentFilter() {
    let scriptsToShow = [...filteredScripts];
    
    if (currentCategory !== 'all') {
        scriptsToShow = scriptsToShow.filter(script => script.category === currentCategory);
    }
    
    renderScripts(scriptsToShow);
}

// Renderizar scripts na tabela
function renderScripts(scripts = filteredScripts) {
    if (scripts.length === 0) {
        scriptsTableBody.innerHTML = '';
        noResults.style.display = 'block';
        return;
    }
    
    noResults.style.display = 'none';
    
    scriptsTableBody.innerHTML = scripts.map(script => `
        <tr>
            <td>
                <div class="script-name">${script.name}</div>
            </td>
            <td>
                <span class="script-category category-${script.category}">${getCategoryName(script.category)}</span>
            </td>
            <td>
                <div class="script-description">${script.description}</div>
            </td>
            <td>
                <div class="script-command">${script.command}</div>
            </td>
            <td>
                <div class="action-buttons">
                    <button class="action-btn copy-btn" onclick="copyCommand('${script.command}')">
                        <i class="fas fa-copy"></i> Copiar
                    </button>
                    <button class="action-btn info-btn" onclick="showInfo('${script.name}', '${script.description}', '${script.file}')">
                        <i class="fas fa-info-circle"></i> Info
                    </button>
                </div>
            </td>
        </tr>
    `).join('');
}

// Obter nome da categoria
function getCategoryName(category) {
    const categoryNames = {
        'repair': 'Reparo',
        'maintenance': 'Manutenção',
        'optimization': 'Otimização',
        'diagnostics': 'Diagnósticos',
        'security': 'Segurança',
        'automation': 'Automação',
        'network': 'Rede',
        'specialized': 'Especializado'
    };
    return categoryNames[category] || category;
}

// Copiar comando
function copyCommand(command) {
    navigator.clipboard.writeText(command).then(() => {
        showToast('Comando copiado para a área de transferência!');
    }).catch(err => {
        console.error('Erro ao copiar: ', err);
        showToast('Erro ao copiar comando');
    });
}

// Mostrar informações do script
function showInfo(name, description, file) {
    const info = `
Nome: ${name}
Descrição: ${description}
Arquivo: ${file}

Para usar este script:
1. Baixe o arquivo do GitHub
2. Execute como administrador
3. Siga as instruções na tela

GitHub: https://github.com/marlonmotta/mmti-pc-toolkit
    `;
    
    alert(info);
}

// Limpar busca
function clearSearchInput() {
    searchInput.value = '';
    handleSearch();
}

// Mostrar toast
function showToast(message) {
    toastMessage.textContent = message;
    toast.classList.add('show');
    
    setTimeout(() => {
        toast.classList.remove('show');
    }, 3000);
}

// Smooth scroll para links internos
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Adicionar animação de entrada para elementos
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observar elementos para animação
document.addEventListener('DOMContentLoaded', () => {
    const animatedElements = document.querySelectorAll('.stat-card, .about-text, .contribute-text');
    animatedElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
});

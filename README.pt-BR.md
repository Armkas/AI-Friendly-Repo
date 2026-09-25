# AI-Native Repository Standard

[🇺🇸 English](README.md) | [🇨🇳 简体中文](README.zh-CN.md) | [🇹🇼 繁體中文](README.zh-TW.md) | [🇯🇵 日本語](README.ja.md) | [🇪🇸 Español](README.es.md) | [🇫🇷 Français](README.fr.md) | [🇩🇪 Deutsch](README.de.md) | [🇷🇺 Русский](README.ru.md) | [🇺🇦 Українська](README.uk.md) | [🇧🇷 Português](README.pt-BR.md) | [🇰🇷 한국어](README.ko.md) | [🇮🇳 हिन्दी](README.hi.md) | [🇸🇦 العربية](README.ar.md)

> **Don't just give AI more context. Give it a native workspace.**
> **Não dê apenas mais contexto à IA. Dê a ela um espaço de trabalho nativo.**

Um padrão, gerador CLI (scaffold) e arquitetura de referência para construir repositórios que agentes de codificação de IA podem entender, navegar, modificar e verificar de forma autônoma.

---

## 🚀 Início Rápido: O Scaffold CLI

Você não precisa mais copiar arquivos manualmente. Fornecemos uma CLI poderosa para gerar instantaneamente um espaço de trabalho AI-Native adaptado ao seu Agent Runtime e à complexidade do projeto.

**Execute o seguinte comando em qualquer diretório vazio:**

```bash
npx ai-native-repo init .
```

### A Matriz de 12 Modelos (Templates)
A CLI pedirá interativamente que você escolha nossa matriz de 12 modelos (4 Runtimes × 3 Níveis):

**Etapa 1: Escolha o seu Agent Runtime**
- `claude-code`: Ganchos e habilidades puras do ecossistema Anthropic.
- `codex`: Estrutura pura do agente OpenAI/Codex.
- `cursor`: Otimizado para correspondência global `.cursor/rules/*.mdc`.
- `gemini-cli`: Ambiente puro Google Gemini.

**Etapa 2: Escolha o seu nível de complexidade (Tier)**
- `light`: Arquivos de contexto mínimos para scripts simples ou protótipos.
- `standard`: O padrão. Arquitetura completa para serviços em produção.
- `full`: Nível empresarial. Inclui ganchos de verificação, configuração de MCP e avaliação de comportamento do agente.

*Alternativamente, pule os prompts com sinalizadores:*
```bash
npx ai-native-repo init . --runtime cursor --tier standard
```

---

## ⚠️ Agnóstico ao Modelo, Ciente do Runtime

**"A semântica é unificada, mas os runtimes são fragmentados."**

A partir de 2026, a indústria percebeu que a construção de um repositório nativo de IA exige a separação de três camadas:
1. **O Modelo** (ex: OpenAI, Anthropic, Google).
2. **O Runtime do Agente** (ex: Cursor, Claude Code, Gemini CLI).
3. **O Padrão do Repositório**: A verdade semântica do seu projeto.

Embora a semântica seja **Agnóstica ao Modelo**, ela deve ser **Ciente do Runtime**. 
- **Claude Code (Anthropic)** espera `.claude/settings.json`.
- **Cursor** espera `.cursor/rules/*.mdc`.

---

## 🏗 Os 8 Pilares da Arquitetura AI-Native

1. **Contexto (O "O que")**: *`PROJECT_MAP`, `Domains`, `Architecture`*
2. **Regras (As "Instruções e Restrições")**: *`AGENTS.md`, `CLAUDE.md`, `.cursor/rules/`*
3. **Contratos (O "Como se conectam")**: *`Protocols`, `Schemas`, `API Definitions`*
4. **Habilidades (O "Como fazer uma tarefa específica")**: *`SKILL.md`*
5. **Workflows (O "Como orquestrar")**: *`SOPs`*
6. **Ferramentas (O "Como tocar o mundo")**: *`MCP Servers`, `Scripts CLI`*
7. **Verificação (A "Evidência")**: *`Tests`, `Validators`, `Hooks`*
8. **Limite Humano / Agente (A "Barreira de confiança")**: *`MANUAL_TASKS.md`*

---

## 📂 Guia do Desenvolvedor

```text
AI-Native-Repo/
│
├── spec/                        # O Padrão: Teorias e filosofia
├── cli/                         # Código-fonte para a ferramenta CLI
├── template-source/             # A ÚNICA Fonte de Verdade para os templates
│   ├── common/                  
│   └── runtimes/                
│
├── scripts/
│   ├── generate-templates.js    
│   └── validate.sh              
└── anr.yaml                     # O Manifesto legível por máquina
```

# AI-Native Repository Standard

[🇺🇸 English](README.md) | [🇨🇳 简体中文](README.zh-CN.md) | [🇹🇼 繁體中文](README.zh-TW.md) | [🇯🇵 日本語](README.ja.md) | [🇪🇸 Español](README.es.md) | [🇫🇷 Français](README.fr.md) | [🇩🇪 Deutsch](README.de.md) | [🇷🇺 Русский](README.ru.md) | [🇺🇦 Українська](README.uk.md) | [🇧🇷 Português](README.pt-BR.md) | [🇰🇷 한국어](README.ko.md) | [🇮🇳 हिन्दी](README.hi.md) | [🇸🇦 العربية](README.ar.md)

> **Don't just give AI more context. Give it a native workspace.**
> **Ne vous contentez pas de donner plus de contexte à l'IA. Donnez-lui un espace de travail natif.**

Un standard, un générateur CLI et une architecture de référence pour construire des dépôts que les agents de codage IA peuvent comprendre, naviguer, modifier et vérifier de manière autonome.

---

## 🚀 Démarrage rapide : Le générateur CLI

Vous n'avez plus besoin de copier manuellement des fichiers. Nous fournissons un puissant outil en ligne de commande (CLI) pour générer instantanément un espace de travail IA natif adapté à votre environnement d'agent et à la complexité de votre projet.

**Exécutez la commande suivante dans un répertoire vide :**

```bash
npx ai-native-repo init .
```

### La Matrice des 12 Modèles
La CLI vous demandera de choisir parmi notre matrice de 12 modèles (4 Runtimes × 3 Niveaux) :

**Étape 1 : Choisissez votre Agent Runtime**
- `claude-code` : Hooks et compétences de l'écosystème Anthropic.
- `codex` : Structure pure de l'agent OpenAI/Codex.
- `cursor` : Optimisé pour la correspondance globale `.cursor/rules/*.mdc`.
- `gemini-cli` : Environnement pur Google Gemini.

**Étape 2 : Choisissez votre niveau de complexité (Tier)**
- `light` : Les fichiers de contexte minimum pour des scripts simples.
- `standard` : Par défaut. Architecture complète pour les services en production.
- `full` : Niveau entreprise. Inclut les hooks de vérification, la configuration MCP, et l'évaluation du comportement de l'agent.

*Alternativement, ignorez les invites avec les paramètres :*
```bash
npx ai-native-repo init . --runtime cursor --tier standard
```

---

## ⚠️ Agnostique au Modèle, Conscient de l'Environnement

À partir de 2026, l'industrie a réalisé que la construction d'un dépôt IA natif nécessite de séparer trois couches distinctes :
1. **Le Modèle** (ex. modèles OpenAI, Anthropic, Google) : Détermine l'intelligence brute.
2. **Le Runtime de l'Agent** (ex. Cursor, Claude Code, Gemini CLI) : Détermine *comment* les fichiers sont lus et *quand* les hooks sont exécutés.
3. **Le Standard du Dépôt** : La vérité sémantique universelle de votre projet.

Bien que la sémantique métier de votre projet soit **Agnostique au Modèle**, elle doit être **Consciente de l'Environnement**. 
- **Claude Code d'Anthropic** attend `.claude/settings.json`.
- **Cursor** attend `.cursor/rules/*.mdc`.

### Dépôts de Référence vs Dépôts Consommateurs
- **Ce dépôt (Référence)** : Ce dépôt GitHub est le *dépôt de référence* global.
- **Votre Dépôt (Consommateur)** : Le dépôt généré par la CLI. Il doit contenir exactement **un** adaptateur d'environnement et **un** niveau, garantissant que l'agent IA n'est jamais confus par des règles concurrentes.

---

## 🏗 Les 8 piliers de l'architecture IA Native

Ce standard élève le dépôt d'un "livre à lire pour l'IA" à un "espace de travail à opérer pour l'IA". Il définit 8 couches :

### 1. Contexte ("Quoi")
*`PROJECT_MAP`, `Domains`, `Architecture`*
Dit à l'IA ce qu'est le système, où se trouvent les choses et pourquoi elles ont été construites ainsi.

### 2. Règles ("Instructions & Contraintes")
*`AGENTS.md`, `CLAUDE.md`, `.cursor/rules/`*
Comment le code doit être formaté et quelles limites doivent être respectées.

### 3. Contrats ("Comment ils se connectent")
*`Protocols`, `Schemas`, `API Definitions`*
Frontières explicites entre les composants.

### 4. Compétences ("Comment faire une tâche spécifique")
*`SKILL.md`*
Capacités atomiques réutilisables.

### 5. Flux de travail ("Comment orchestrer")
*`SOPs`*
Procédures à plusieurs étapes.

### 6. Outils ("Comment interagir avec le monde")
*`MCP Servers`, `Scripts CLI`*
Capacités structurées que l'agent peut utiliser.

### 7. Vérification ("Les Preuves")
*`Tests`, `Validators`, `Hooks`*
Vérification du code + Vérification du comportement de l'agent. Le travail d'un agent n'est pas terminé tant que le script de validation ne renvoie pas le code 0.

### 8. Frontière Humain / Agent ("Barrière de confiance")
*`MANUAL_TASKS.md`*
Ce que l'IA peut faire de manière autonome vs ce qu'un humain doit faire.

---

## 📂 Guide du Développeur

Si vous souhaitez contribuer au Standard :

```text
AI-Native-Repo/
│
├── spec/                        # Le standard (philosophie)
├── cli/                         # Code source de la CLI
├── template-source/             # Source de vérité UNIQUE
│   ├── common/                  
│   └── runtimes/                
│
├── scripts/                     # Scripts de génération et de validation
└── anr.yaml                     # Manifeste lisible par machine
```

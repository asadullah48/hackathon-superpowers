# Claude Code Project Configuration Guide

> Complete guide to configuring Claude Code for maximum productivity

## Table of Contents

1. [Quick Start](#quick-start)
2. [Directory Structure](#directory-structure)
3. [CLAUDE.md - Project Memory](#claudemd---project-memory)
4. [settings.json - Hooks & Environment](#settingsjson---hooks--environment)
5. [MCP Servers - External Integrations](#mcp-servers---external-integrations)
6. [LSP Servers - Code Intelligence](#lsp-servers---code-intelligence)
7. [Skills - Domain Knowledge](#skills---domain-knowledge)
8. [Agents - Specialized Assistants](#agents---specialized-assistants)
9. [Commands - Slash Commands](#commands---slash-commands)
10. [GitHub Actions Workflows](#github-actions-workflows)
11. [Best Practices](#best-practices)

---

## Quick Start

### 1. Create the .claude directory
```bash
mkdir -p .claude/{agents,commands,hooks,skills}
```

### 2. Add a CLAUDE.md file

Create `CLAUDE.md` in your project root with your project's key information.
```markdown
# Project Name

## Quick Facts
- **Stack**: React, TypeScript, Node.js
- **Test Command**: `npm run test`
- **Lint Command**: `npm run lint`

## Key Directories
- `src/components/` - React components
- `src/api/` - API layer
- `tests/` - Test files

## Code Style
- TypeScript strict mode
- Prefer interfaces over types
- No `any` - use `unknown`
```

### 3. Add settings.json with hooks

Create `.claude/settings.json`:
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "[ \"$(git branch --show-current)\" != \"main\" ] || { echo '{\"block\": true, \"message\": \"Cannot edit on main branch\"}' >&2; exit 2; }",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```

### 4. Add your first skill

Create `.claude/skills/testing-patterns/SKILL.md`:
```markdown
---
name: testing-patterns
description: Jest testing patterns for this project. Use when writing tests, creating mocks, or following TDD workflow.
---

# Testing Patterns

## Test Structure
- Use `describe` blocks for grouping
- Use `it` for individual tests
- Follow AAA pattern: Arrange, Act, Assert

## Mocking
- Use factory functions: `getMockUser(overrides)`
- Mock external dependencies, not internal modules
```

---

## Directory Structure
```
your-project/
├── CLAUDE.md                      # Project memory
├── .mcp.json                      # MCP server configuration
├── .claude/
│   ├── settings.json              # Hooks, environment, permissions
│   ├── settings.local.json        # Personal overrides (gitignored)
│   ├── settings.md                # Human-readable documentation
│   ├── .gitignore                 # Ignore local/personal files
│   │
│   ├── agents/                    # Custom AI agents
│   │   └── code-reviewer.md
│   │
│   ├── commands/                  # Slash commands
│   │   ├── onboard.md
│   │   ├── pr-review.md
│   │   └── ticket.md
│   │
│   ├── hooks/                     # Hook scripts
│   │   ├── skill-eval.sh
│   │   ├── skill-eval.js
│   │   └── skill-rules.json
│   │
│   ├── skills/                    # Domain knowledge
│   │   ├── README.md
│   │   ├── testing-patterns/
│   │   │   └── SKILL.md
│   │   └── graphql-schema/
│   │       └── SKILL.md
│   │
│   └── rules/                     # Modular instructions
│       ├── code-style.md
│       └── security.md
│
└── .github/
    └── workflows/
        ├── pr-claude-code-review.yml
        └── scheduled-claude-code-quality.yml
```

---

## CLAUDE.md - Project Memory

CLAUDE.md is Claude's persistent memory that loads automatically at session start.

### Locations (in order of precedence):

1. `.claude/CLAUDE.md` (project, in .claude folder)
2. `./CLAUDE.md` (project root)
3. `~/.claude/CLAUDE.md` (user-level, all projects)

### What to include:

- Project stack and architecture overview
- Key commands (test, build, lint, deploy)
- Code style guidelines
- Important directories and their purposes
- Critical rules and constraints

### Example CLAUDE.md:
```markdown
# Hackathon Superpowers

## Quick Facts
- **Purpose**: Claude Code skills marketplace for hackathons
- **Stack**: Bash scripts, Markdown, CAPS playbooks
- **Test Command**: `./scripts/test-skills.sh`

## Key Directories
- `skills/` - Ready-to-use Claude Code skills
- `caps-playbooks/` - Universal CAPS format playbooks
- `scripts/` - Conversion and sync automation
- `templates/` - Skill boilerplate templates

## Development Workflow
1. Create CAPS playbook in `caps-playbooks/`
2. Convert using `./scripts/caps-to-skills.sh`
3. Sync to Claude Desktop via `./scripts/sync-to-claude-desktop.sh`
4. Test in new conversation

## Code Style
- Bash scripts: Use `set -euo pipefail`
- YAML frontmatter: Required fields (name, description)
- Markdown: Use triple backticks for code blocks
- Paths: Always use forward slashes, even on Windows

## Critical Rules
- NEVER edit on main branch directly
- ALWAYS validate CAPS format before committing
- Skills MUST have allowed-tools specified
- Descriptions MUST include trigger keywords
```

---

## settings.json - Hooks & Environment

The main configuration file for hooks, environment variables, and permissions.

### Location: `.claude/settings.json`

### Hook Events

| Event | When It Fires | Use Case |
|-------|---------------|----------|
| PreToolUse | Before tool execution | Block edits on main, validate commands |
| PostToolUse | After tool completes | Auto-format, run tests, lint |
| UserPromptSubmit | User submits prompt | Add context, suggest skills |
| Stop | Agent finishes | Decide if Claude should continue |

### Hook Response Format
```json
{
  "block": true,           // Block the action (PreToolUse only)
  "message": "Reason",     // Message to show user
  "feedback": "Info",      // Non-blocking feedback
  "suppressOutput": true,  // Hide command output
  "continue": false        // Whether to continue
}
```

### Exit Codes

- `0` - Success
- `2` - Blocking error (PreToolUse only)
- Other - Non-blocking error

### Example settings.json:
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "[ \"$(git branch --show-current)\" != \"main\" ] || { echo '{\"block\": true, \"message\": \"Cannot edit on main branch\"}' >&2; exit 2; }",
            "timeout": 5
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "prettier --write \"$CLAUDE_TOOL_RESULT_PATH\" 2>&1",
            "timeout": 10
          }
        ]
      }
    ]
  },
  "enabledPlugins": {
    "typescript-lsp@claude-plugins-official": true
  }
}
```

---

## MCP Servers - External Integrations

MCP (Model Context Protocol) servers let Claude Code connect to external tools like JIRA, GitHub, Slack, databases, and more.

### Location: `.mcp.json` (project root, committed to git)

### How MCP Works
```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   Claude Code   │────▶│   MCP Server    │────▶│  External API   │
│                 │◀────│  (local bridge) │◀────│  (JIRA, GitHub) │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

### .mcp.json Format
```json
{
  "mcpServers": {
    "server-name": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-name"],
      "env": {
        "API_KEY": "${API_KEY}"
      }
    }
  }
}
```

### Example: JIRA Integration
```json
{
  "mcpServers": {
    "jira": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-jira"],
      "env": {
        "JIRA_HOST": "${JIRA_HOST}",
        "JIRA_EMAIL": "${JIRA_EMAIL}",
        "JIRA_API_TOKEN": "${JIRA_API_TOKEN}"
      }
    }
  }
}
```

### Common MCP Servers

**Issue Tracking:**
- `@anthropic/mcp-jira` - JIRA integration
- `@anthropic/mcp-linear` - Linear integration

**Code & DevOps:**
- `@anthropic/mcp-github` - GitHub integration
- `@anthropic/mcp-sentry` - Sentry error tracking

**Communication:**
- `@anthropic/mcp-slack` - Slack integration

**Databases:**
- `@anthropic/mcp-postgres` - PostgreSQL integration

---

## LSP Servers - Code Intelligence

LSP (Language Server Protocol) gives Claude real-time understanding of your code—type information, errors, completions, and navigation.

### Enabling LSP
```json
{
  "enabledPlugins": {
    "typescript-lsp@claude-plugins-official": true,
    "pyright-lsp@claude-plugins-official": true
  }
}
```

### Available LSP Plugins

| Plugin | Language | Install Binary First |
|--------|----------|----------------------|
| typescript-lsp | TypeScript/JavaScript | `npm install -g typescript-language-server typescript` |
| pyright-lsp | Python | `pip install pyright` |
| rust-lsp | Rust | `rustup component add rust-analyzer` |

---

## Skills - Domain Knowledge

Skills are markdown documents that teach Claude project-specific patterns and conventions.

### Location: `.claude/skills/{skill-name}/SKILL.md`

### SKILL.md Format
```markdown
---
name: skill-name
description: What this skill does and when to use it. Include keywords users would mention.
allowed-tools: Read, Grep, Glob
model: claude-sonnet-4-20250514
---

# Skill Title

## When to Use
- Trigger condition 1
- Trigger condition 2

## Core Patterns

### Pattern Name
\`\`\`typescript
// Example code
\`\`\`

## Anti-Patterns

### What NOT to Do
\`\`\`typescript
// Bad example
\`\`\`

## Integration
Related skill: other-skill
```

### Frontmatter Fields

| Field | Required | Max Length | Description |
|-------|----------|------------|-------------|
| name | Yes | 64 chars | Lowercase letters, numbers, hyphens only |
| description | Yes | 1024 chars | What it does and when to use it |
| allowed-tools | No | - | Comma-separated tool list |
| model | No | - | Specific model (e.g., claude-sonnet-4) |

---

## Agents - Specialized Assistants

Agents are AI assistants with focused purposes and their own prompts.

### Location: `.claude/agents/{agent-name}.md`

### Agent Format
```markdown
---
name: code-reviewer
description: Reviews code for quality, security, and conventions. Use after writing or modifying code.
model: opus
---

# Agent System Prompt

You are a senior code reviewer...

## Your Process
1. Run `git diff` to see changes
2. Apply review checklist
3. Provide feedback

## Checklist
- [ ] No TypeScript `any`
- [ ] Error handling present
- [ ] Tests included
```

---

## Commands - Slash Commands

Custom commands invoked with `/command-name`.

### Location: `.claude/commands/{command-name}.md`

### Command Format
```markdown
---
description: Brief description shown in command list
allowed-tools: Bash(git:*), Read, Grep
---

# Command Instructions

Your task is to: $ARGUMENTS

## Steps
1. Do this first
2. Then do this
```

### Variables

- `$ARGUMENTS` - All arguments as single string
- `$1, $2, $3` - Individual positional arguments

### Inline Bash
```markdown
Current branch: !`git branch --show-current`
Recent commits: !`git log --oneline -5`
```

---

## GitHub Actions Workflows

Automate code review, quality checks, and maintenance with Claude Code.

### PR Code Review
```yaml
name: PR - Claude Code Review
on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: anthropics/claude-code-action@beta
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          model: claude-opus-4-5-20251101
          prompt: |
            Review this PR using .claude/agents/code-reviewer.md standards.
            Run `git diff origin/main...HEAD` to see changes.
```

### Scheduled Workflows

| Workflow | Schedule | Purpose |
|----------|----------|---------|
| Code Quality | Weekly (Sunday) | Review random directories, auto-fix issues |
| Docs Sync | Monthly (1st) | Ensure docs align with code changes |
| Dependency Audit | Biweekly | Safe dependency updates with testing |

---

## Best Practices

### 1. Start with CLAUDE.md

Your CLAUDE.md is the foundation. Include:
- Stack overview
- Key commands
- Critical rules
- Directory structure

### 2. Build Skills Incrementally

Don't try to document everything at once:
- Start with your most common patterns
- Add skills as pain points emerge
- Keep each skill focused on one domain

### 3. Use Hooks for Automation

Let hooks handle repetitive tasks:
- Auto-format on save
- Run tests when test files change
- Regenerate types when schemas change
- Block edits on protected branches

### 4. Create Agents for Complex Workflows

Agents are great for:
- Code review (with your team's checklist)
- PR creation and management
- Debugging workflows
- Onboarding to tasks

### 5. Leverage GitHub Actions

Automate maintenance:
- PR reviews on every PR
- Weekly quality sweeps
- Monthly docs alignment
- Dependency updates

### 6. Version Control Your Config

Commit everything except:
- `settings.local.json` (personal preferences)
- `CLAUDE.local.md` (personal notes)
- User-specific credentials

---

## Learn More

- [Claude Code Documentation](https://claude.ai/code)
- [Claude Code Action - GitHub Action](https://github.com/anthropics/claude-code-action)
- [Anthropic API](https://docs.anthropic.com)

## License

MIT - Use this as a template for your own projects.

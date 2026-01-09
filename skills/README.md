# Claude Code Skills

This directory contains production-ready Claude Code skills for hackathon development and cloud-native applications.

## Available Skills

| Skill | Status | Description | Use When |
|-------|--------|-------------|----------|
| **agents-md-generator** | ✅ Ready | Generate comprehensive AGENTS.md documentation | Setting up new repos, onboarding AI agents |
| **caps-format-validator** | ✅ Ready | Validate CAPS playbooks for compatibility | Creating/updating CAPS playbooks |
| **kubernetes-health-check** | ✅ Ready | Verify K8s cluster health and resources | Before deployments, troubleshooting |
| **phase3-ai-chatbot** | 🚧 In Progress | MCP + OpenAI + ChatKit patterns | Building AI chatbots |
| **phase4-k8s-local** | 🚧 In Progress | Local Kubernetes with Minikube & Helm | Development environment setup |
| **phase5-k8s-cloud** | 🚧 In Progress | Cloud K8s with Dapr & Kafka | Production deployments |
| **dapr-integration** | 🚧 In Progress | Event-driven architecture with Dapr | Microservices communication |
| **mcp-server** | 🚧 In Progress | MCP server development patterns | Extending Claude capabilities |
| **caps-playbook** | 🚧 In Progress | CAPS format creation & conversion | Building universal playbooks |

## Skill Format

Each skill follows this structure:
```
skill-name/
├── SKILL.md           # Main instructions (<500 lines)
├── references/        # Detailed domain knowledge (optional)
├── scripts/           # Executable code (optional)
└── assets/            # Templates, boilerplate (optional)
```

## SKILL.md Requirements

### Frontmatter (Required)
```yaml
---
name: skill-name
description: |
  What this skill does and when to use it.
  Include trigger keywords users would naturally mention.
allowed-tools: bash_tool,view,str_replace,create_file
---
```

### Content Structure

1. **When to Use** - Clear trigger conditions
2. **Core Patterns** - Step-by-step workflows with examples
3. **Anti-Patterns** - What NOT to do with explanations
4. **Best Practices** - Domain-specific guidelines
5. **Troubleshooting** - Common issues and solutions
6. **Related Skills** - Integration points

## Installation

### Option 1: Clone Repository
```bash
git clone https://github.com/asadullah48/hackathon-superpower.git
cd hackathon-superpower
```

### Option 2: Install via Claude Code Plugin Marketplace
```
/plugin
Search: asadullah48/hackathon-superpower
Install: superpowers-marketplace
```

### Option 3: Manual Sync (Windows WSL)
```bash
# Sync to Claude Desktop
./scripts/sync-to-claude-desktop.sh

# Restart Claude Desktop
```

## Creating New Skills

### Quick Start

1. **Use the template:**
```bash
cp -r templates/skill-template skills/new-skill-name
cd skills/new-skill-name
```

2. **Edit SKILL.md:**
   - Update frontmatter (name, description, allowed-tools)
   - Fill in "When to Use" section with trigger keywords
   - Add core patterns with code examples
   - Document anti-patterns
   - Include troubleshooting guide

3. **Test thoroughly:**
   - Open new Claude Desktop conversation
   - Trigger the skill with natural language
   - Verify it activates correctly
   - Test edge cases

### Best Practices

#### 1. Description is Everything

Your description determines when Claude triggers the skill. Include:
- **What** it does (capability)
- **When** to use it (trigger phrases)
- Third-person voice (not "I can help")

**Bad:**
```yaml
description: Kubernetes tool
```

**Good:**
```yaml
description: |
  Verify Kubernetes cluster health, resource availability, and readiness
  before deploying applications. Use when checking cluster status,
  validating resources, or troubleshooting deployment issues.
```

#### 2. Use Gerund Naming

**Preferred:**
- `processing-pdfs` ✅
- `analyzing-data` ✅
- `creating-widgets` ✅

**Avoid:**
- `process-pdf` ❌
- `analyze` ❌
- `widget-creator` ❌

#### 3. Handle Variations, Not Requirements

❌ **Too Specific:**
"Create bar chart with sales data using Recharts"

✅ **Flexible:**
"Create visualizations—adaptable to data shape, chart type, library"

#### 4. Keep SKILL.md Focused

- Under 500 lines
- Put detailed docs in `references/`
- Use code examples, not long explanations
- Link to official documentation

#### 5. Specify Allowed Tools
```yaml
allowed-tools: bash_tool,view,str_replace,create_file
```

Common tools:
- `bash_tool` - Execute commands
- `view` - Read files
- `str_replace` - Edit files
- `create_file` - Create new files
- `web_search` - Search the web

## Troubleshooting

### Skill Not Loading

**Check these:**

1. **Frontmatter format:**
```yaml
---
name: skill-name
description: Description here
allowed-tools: bash_tool
---
```

2. **File location:**
```
skills/skill-name/SKILL.md  ✅
skills/skill-name.md        ❌
```

3. **Name format:**
- Lowercase only
- Hyphens (not underscores)
- Max 64 characters
- Must match directory name

4. **Empty allowed-tools:**
```yaml
allowed-tools:    # ❌ EMPTY - will fail!
```

### Skill Not Triggering

**Improve your description:**

1. Add trigger keywords users would say
2. Include multiple phrasings
3. Use third-person voice
4. Describe WHEN to use it

**Example:**
```yaml
description: |
  Verify Kubernetes cluster health before deployments.
  Use when checking cluster status, validating resources,
  troubleshooting pods, or ensuring readiness.
  Keywords: kubernetes, k8s, cluster, health check, pods,
  deployments, resources, readiness, troubleshooting.
```

### Skills in Wrong Location (Windows WSL)

**Problem:** Skills in `~/.claude/skills/` (WSL) but Claude Desktop reads from Windows filesystem.

**Solution:**
```bash
# Correct Windows path via WSL
/mnt/c/Users/YourName/AppData/Roaming/Claude/skills/

# Use sync script
./scripts/sync-to-claude-desktop.sh
```

## Contributing

1. Fork the repository
2. Create skill in `skills/` directory
3. Follow SKILL.md format
4. Test thoroughly
5. Update this README
6. Submit pull request

## License

MIT License - see [LICENSE](../LICENSE)

## Support

- **Issues:** [GitHub Issues](https://github.com/asadullah48/hackathon-superpower/issues)
- **Discussions:** [GitHub Discussions](https://github.com/asadullah48/hackathon-superpower/discussions)
- **Contact:** [@asadullah48](https://github.com/asadullah48)

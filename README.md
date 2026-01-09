# 🚀 Hackathon Superpowers

**Universal Claude Skills & CAPS Playbooks for Agentic AI Development**

A production-ready collection of Claude Code skills and CAPS (Coding Agent Playbook Spec) playbooks designed for cloud-native hackathons, agentic AI workflows, and rapid application development.

[![GitHub](https://img.shields.io/github/license/asadullah48/hackathon-superpower)](LICENSE)
[![Skills](https://img.shields.io/badge/skills-9-blue)](skills/)
[![CAPS](https://img.shields.io/badge/CAPS-compatible-green)](caps-playbooks/)

## 📦 What's Inside

### Claude Code Skills (Ready to Use)
- **agents-md-generator** - Auto-generate AGENTS.md documentation for AI agents
- **caps-format-validator** - Validate CAPS playbooks for Claude Code & Goose compatibility
- **kubernetes-health-check** - Verify K8s cluster health before deployments
- **phase3-ai-chatbot** - MCP + OpenAI + ChatKit integration patterns
- **phase4-k8s-local** - Local Kubernetes setup with Minikube & Helm
- **phase5-k8s-cloud** - Cloud deployment with Dapr & Kafka
- **dapr-integration** - Event-driven architecture with Dapr
- **mcp-server** - MCP server development patterns
- **caps-playbook** - CAPS format creation & conversion

### CAPS Playbooks (Universal Format)
All skills available as CAPS playbooks for cross-agent compatibility:
- Works with Claude Code, Goose, Aider, and other CAPS-compatible agents
- Standardized format for consistent behavior
- Easy conversion to agent-specific formats

## 🎯 Use Cases

### Hackathon Workflows
```bash
# Health check before demo
Use kubernetes-health-check

# Generate documentation
Use agents-md-generator

# Validate your CAPS playbooks
Use caps-format-validator
```

### Production Development
- **Cloud-Native Apps** - K8s, Dapr, Kafka, event-driven architecture
- **AI Integration** - MCP servers, OpenAI, RAG chatbots
- **Infrastructure** - Local & cloud Kubernetes deployment
- **Documentation** - Auto-generated AGENTS.md for onboarding

## 🚀 Quick Start

### Option 1: Install as Claude Desktop Skills

1. **Clone the repository:**
```bash
git clone https://github.com/asadullah48/hackathon-superpower.git
cd hackathon-superpower
```

2. **Sync to Claude Desktop:**
```bash
# Windows (WSL)
./scripts/sync-to-claude-desktop.sh

# The script copies skills to:
# /mnt/c/Users/YourName/AppData/Roaming/Claude/skills/
```

3. **Restart Claude Desktop**

4. **Use in conversation:**
```
Use kubernetes-health-check to verify my cluster
```

### Option 2: Use CAPS Playbooks with Any Agent
```bash
# Convert CAPS to your agent's format
./scripts/caps-to-skills.sh

# CAPS playbooks work with:
# - Claude Code
# - Goose
# - Aider
# - Any CAPS-compatible agent
```

## 📁 Repository Structure
```
hackathon-superpowers/
├── skills/                    # Ready-to-use Claude Code skills
│   ├── agents-md-generator/
│   ├── kubernetes-health-check/
│   └── caps-format-validator/
├── caps-playbooks/           # Universal CAPS format
│   ├── agents-md-generator/
│   ├── kubernetes-health-check/
│   └── caps-format-validator/
├── scripts/                  # Automation tools
│   ├── caps-to-skills.sh    # Convert CAPS → Skills
│   └── sync-to-claude-desktop.sh
├── templates/                # Boilerplate templates
├── examples/                 # Example usage
└── docs/                     # Documentation
```

## 🛠️ Available Skills

| Skill | Description | Use When |
|-------|-------------|----------|
| `agents-md-generator` | Generate comprehensive AGENTS.md | Setting up new repos |
| `caps-format-validator` | Validate CAPS playbooks | Creating/updating playbooks |
| `kubernetes-health-check` | K8s cluster verification | Before deployments |
| `phase3-ai-chatbot` | AI chatbot with MCP | Building conversational AI |
| `phase4-k8s-local` | Local K8s setup | Development environment |
| `phase5-k8s-cloud` | Cloud K8s deployment | Production deployment |
| `dapr-integration` | Event-driven with Dapr | Microservices architecture |
| `mcp-server` | MCP server development | Extending Claude capabilities |

## 📖 Documentation

- **[CLAUDE.md](CLAUDE.md)** - Project memory & conventions
- **[Skills Guide](docs/skills-guide.md)** - Creating production-grade skills
- **[CAPS Format](docs/caps-format.md)** - Understanding CAPS playbooks
- **[Claude Code Setup](docs/claude-code-config.md)** - Complete configuration guide

## 🎓 Learning Resources

### Creating Your Own Skills

This repository demonstrates production-grade skill development:

1. **Start with CAPS playbook** - Universal format
2. **Convert to skill** - Agent-specific format
3. **Test thoroughly** - Ensure reliability
4. **Document well** - Clear descriptions & examples

See [docs/skills-guide.md](docs/skills-guide.md) for detailed guidance.

### CAPS Format Benefits

- **Universal Compatibility** - One format, multiple agents
- **Version Control Friendly** - Markdown-based
- **Community Standard** - Growing ecosystem
- **Easy Conversion** - Scripts provided

## 🤝 Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Add your skill in both `skills/` and `caps-playbooks/`
4. Update README.md
5. Submit a pull request

### Skill Contribution Guidelines

- Follow CAPS format specifications
- Include comprehensive descriptions
- Provide working examples
- Test across different scenarios
- Document edge cases

## 🏆 Built For

**Panaversity Hackathon III** - Cloud-Native Agentic Applications
- Infrastructure as Code
- Event-Driven Architecture
- AI-Powered Workflows
- Universal Agent Compatibility

## 📜 License

MIT License - see [LICENSE](LICENSE) file

## 🙏 Acknowledgments

- Inspired by [Anthropic's Claude Code](https://claude.ai/code)
- CAPS format by the agentic AI community
- Built during Panaversity Hackathons
- Influenced by production experience building generative agents

## 📧 Contact

**Asadullah** - [@asadullah48](https://github.com/asadullah48)

**LinkedIn** - Share your skills & experiences!

---

⭐ **Star this repo** if you find it useful!

🔗 **Share** with developers building agentic AI systems!

🚀 **Contribute** your own hackathon superpowers!

---
title: AGENTS.MD Generator
description: Automatically generate comprehensive AGENTS.md files that teach AI agents how to work with a repository's structure, conventions, and guidelines
version: 1.0.0
author: Asadullah (asadullah48)
allowed_tools:
  - bash_tool
  - view
  - create_file
  - str_replace
---

# AGENTS.MD Generator

## Purpose
Generate AGENTS.md files that serve as onboarding documentation for AI coding agents. This file teaches agents about project structure, coding conventions, build processes, and development workflows.

## Prerequisites
- Access to the target repository
- Understanding of the project's technology stack
- Write permissions to create AGENTS.md at repository root

## Instructions

### Step 1: Analyze Repository Structure

First, explore the repository to understand its organization:
```bash
# Get overview of directory structure
find . -type d -maxdepth 3 | grep -v node_modules | grep -v .git | head -20

# Identify key configuration files
ls -la | grep -E '\.(json|yaml|yml|toml|config)$'

# Check for existing documentation
ls -la | grep -iE '(readme|contributing|changelog)'
```

### Step 2: Identify Project Type

Determine the project category:
- **Frontend**: React, Next.js, Vue (package.json with frontend dependencies)
- **Backend**: FastAPI, Express, Django (requirements.txt, go.mod)
- **Full-stack**: Both frontend and backend components
- **Infrastructure**: Kubernetes manifests, Terraform, Docker Compose
- **Library**: Focused on exports and public API

### Step 3: Generate AGENTS.md Structure

Create AGENTS.md with these essential sections:
```markdown
# AGENTS.md - AI Agent Guide for [Project Name]

## Project Overview
[2-3 sentence description]

## Repository Structure
[Directory tree with descriptions]

## Technology Stack
### Core Technologies
- [Language]: [Version]
- [Framework]: [Version]

### Key Dependencies
- [Package]: [Purpose]

## Development Workflow
### Setup
[Setup commands]

### Common Tasks
[Development, testing, build commands]

## Coding Conventions
### File Organization
[Patterns and when to use them]

### Naming Conventions
[File, function, component naming rules]

## Testing Strategy
[How tests are organized and run]

## Agent-Specific Notes
[Decision trees for common tasks]
```

### Step 4: Customize by Project Type

**For Next.js Projects:**
- Document App Router vs Pages Router
- Server vs Client Component patterns
- Data fetching strategies
- Route organization

**For FastAPI Projects:**
- Router organization
- Pydantic model patterns
- Dependency injection
- Async/await conventions

**For Kubernetes Projects:**
- Manifest organization
- Resource naming conventions
- Label standards
- Configuration management

### Step 5: Add Decision Trees

Include guidance for common scenarios:
```markdown
## Decision Trees for AI Agents

### When Adding a New API Endpoint:
1. Define Pydantic models in /models
2. Create router function in /routers
3. Add service layer logic in /services
4. Write tests in /tests
5. Update API documentation

### When Creating a New Component:
1. Determine Server vs Client Component
2. Place in /components/{category}
3. Extract reusable logic to hooks
4. Add prop type definitions
5. Consider error boundaries
```

### Step 6: Validate Generated File

Check completeness:
- [ ] Clear project overview
- [ ] Complete directory structure
- [ ] All technologies listed with versions
- [ ] Step-by-step setup instructions
- [ ] Specific coding conventions
- [ ] Common patterns with examples
- [ ] Agent decision guidance
- [ ] Troubleshooting section

## Validation

Success criteria:
- [ ] AGENTS.md file created at repository root
- [ ] File is readable markdown format
- [ ] All major directories explained
- [ ] Setup instructions are complete
- [ ] Code examples are syntactically correct
- [ ] No sensitive information included
- [ ] AI agent can understand project structure from file alone

## Troubleshooting

**Issue**: Generated AGENTS.md too generic
**Solution**: Provide more context about project-specific patterns and conventions

**Issue**: Missing technology information
**Solution**: Ensure package.json, requirements.txt, etc. are up to date

**Issue**: AGENTS.md outdated after changes
**Solution**: Regenerate when major structural changes occur

## Best Practices

1. **Be Specific**: Don't say "follow best practices" - spell out exact conventions
2. **Include Examples**: Show code examples for common patterns
3. **Think Like an Agent**: What helps AI understand the codebase quickly?
4. **Keep Updated**: Regenerate after major structural changes
5. **Test It**: Ask an AI agent to build something using only AGENTS.md

## Related Playbooks
- **spec-kit-plus**: Generate AGENTS.md from specification files
- **docusaurus-deploy**: Include AGENTS.md in documentation site

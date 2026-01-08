---
title: CAPS Format Validator
description: Validate CAPS (Coding Agent Playbook Spec) playbooks for correctness, completeness, and compatibility with Claude Code and Goose
version: 1.0.0
author: Asadullah (asadullah48)
allowed_tools:
  - bash_tool
  - view
---

# CAPS Format Validator

## Purpose
Validate CAPS playbooks to ensure correct formatting, completeness, and compatibility with both Claude Code Skills and Goose Recipes. Catch errors early before conversion or deployment.

## Prerequisites
- CAPS playbook file to validate (playbook.md)
- Python 3 (optional, for YAML validation)
- Basic understanding of CAPS format

## CAPS Format Requirements

Every valid CAPS playbook must have:
1. YAML frontmatter between `---` markers
2. `title` field in frontmatter
3. `description` field in frontmatter
4. `allowed_tools` array in frontmatter
5. Main content after frontmatter
6. `## Instructions` or `## Steps` section

## Instructions

### Step 1: Check File Structure
```bash
# Verify file exists
if [ ! -f "playbook.md" ]; then
    echo "❌ Error: playbook.md not found"
    exit 1
fi

# Check file not empty
if [ ! -s "playbook.md" ]; then
    echo "❌ Error: playbook.md is empty"
    exit 1
fi

echo "✅ File structure valid"
```

### Step 2: Validate YAML Frontmatter
```bash
# Extract frontmatter
awk '/^---$/{if (count==0) {count++; next} else {exit}} count==1' playbook.md > frontmatter.yaml

# Check frontmatter exists
if [ ! -s frontmatter.yaml ]; then
    echo "❌ Error: No YAML frontmatter found"
    echo "   Frontmatter must be between --- markers at start"
    exit 1
fi

# Validate YAML syntax (if Python available)
if command -v python3 > /dev/null; then
    python3 << 'PYEOF'
import yaml
import sys

try:
    with open('frontmatter.yaml', 'r') as f:
        yaml.safe_load(f)
    print("✅ YAML syntax valid")
except yaml.YAMLError as e:
    print(f"❌ Error: Invalid YAML syntax")
    print(f"   {e}")
    sys.exit(1)
PYEOF
fi
```

### Step 3: Check Required Fields
```bash
# Check for title
if ! grep -q "^title:" playbook.md; then
    echo "❌ Missing required field: title"
    exit 1
else
    echo "✅ Field present: title"
fi

# Check for description
if ! grep -q "^description:" playbook.md; then
    echo "❌ Missing required field: description"
    exit 1
else
    echo "✅ Field present: description"
fi

# Check for allowed_tools
if ! grep -q "^allowed_tools:" playbook.md; then
    echo "❌ Missing required field: allowed_tools"
    exit 1
else
    echo "✅ Field present: allowed_tools"
fi

# Verify allowed_tools is an array
if grep -A 1 "^allowed_tools:" playbook.md | grep -q "^\s*-"; then
    echo "✅ allowed_tools properly formatted as array"
else
    echo "❌ allowed_tools must be YAML array"
    echo "   Example:"
    echo "   allowed_tools:"
    echo "     - kubectl"
    echo "     - helm"
    exit 1
fi
```

### Step 4: Validate Content Structure
```bash
# Check for Instructions section
if grep -q "^## Instructions\|^## Steps" playbook.md; then
    echo "✅ Instructions section found"
else
    echo "❌ Missing ## Instructions or ## Steps section"
    exit 1
fi

# Check for code blocks
if grep -q '```' playbook.md; then
    echo "✅ Code examples present"
else
    echo "⚠️  Warning: No code blocks found"
fi

# Check for step markers
STEP_COUNT=$(grep -c "^###.*Step" playbook.md || echo 0)
if [ "$STEP_COUNT" -gt 0 ]; then
    echo "✅ Found $STEP_COUNT instruction steps"
else
    echo "⚠️  Warning: No step markers found"
fi
```

### Step 5: Test Conversion Compatibility
```bash
# Test Claude Code Skills conversion
NAME=$(grep "^title:" playbook.md | head -1 | sed 's/title: *//' | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
DESC=$(grep "^description:" playbook.md | head -1 | sed 's/description: *//')

if [ -z "$NAME" ] || [ -z "$DESC" ]; then
    echo "❌ Cannot extract title/description for Skills format"
    exit 1
fi

echo "✅ Claude Skills compatible"

# Test Goose Recipes conversion
TITLE=$(grep "^title:" playbook.md | head -1 | sed 's/title: *//')
if [ -z "$TITLE" ]; then
    echo "❌ Cannot extract title for Recipes format"
    exit 1
fi

echo "✅ Goose Recipes compatible"
```

### Step 6: Check Best Practices
```bash
# Check for Prerequisites section
if grep -q "^## Prerequisites" playbook.md; then
    echo "✅ Prerequisites section present"
else
    echo "⚠️  Warning: No Prerequisites section"
fi

# Check for Validation section
if grep -q "^## Validation\|^## Success Criteria" playbook.md; then
    echo "✅ Validation criteria present"
else
    echo "⚠️  Warning: No validation criteria"
fi

# Check for Troubleshooting
if grep -q "^## Troubleshooting" playbook.md; then
    echo "✅ Troubleshooting section present"
else
    echo "⚠️  Warning: No troubleshooting guide"
fi
```

## Validation

Playbook is valid when:
- [ ] Has YAML frontmatter between `---` markers
- [ ] Includes title, description, allowed_tools
- [ ] allowed_tools is YAML array
- [ ] Has ## Instructions section
- [ ] Includes code examples
- [ ] Can convert to Claude Skills
- [ ] Can convert to Goose Recipes
- [ ] Passes validator with zero errors

## Common Errors

**Error**: Missing frontmatter
```markdown
❌ Wrong:
# My Playbook

✅ Correct:
---
title: My Playbook
---
```

**Error**: Incorrect tool format
```markdown
❌ Wrong:
allowed_tools: kubectl, helm

✅ Correct:
allowed_tools:
  - kubectl
  - helm
```

## Troubleshooting

**Problem**: Validator crashes
```bash
bash -x ./caps-validator.sh playbook.md
```

**Problem**: False positives
```bash
# Check for invisible characters
cat -A playbook.md | head -20
```

## Best Practices

1. **Test Before Committing**: Always validate locally
2. **Use Templates**: Start with valid template
3. **Include Examples**: Show commands and output
4. **Add Validation**: Define success criteria
5. **Version Playbooks**: Use semantic versioning

## Related Playbooks
- **agents-md-generator**: Generate AGENTS.md files
- **caps-to-skills**: Convert validated playbooks
- **caps-to-recipes**: Convert to Goose format

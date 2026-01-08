#!/bin/bash

# caps-to-skills.sh
# Converts CAPS playbooks to Claude Code Skills

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}🔄 Converting CAPS Playbooks to Claude Skills${NC}"
echo "================================================"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CAPS_DIR="${REPO_ROOT}/caps-playbooks"
SKILLS_DIR="${REPO_ROOT}/skills"

if [ ! -d "$CAPS_DIR" ]; then
    echo -e "${RED}❌ Error: caps-playbooks/ directory not found${NC}"
    exit 1
fi

mkdir -p "$SKILLS_DIR"

CONVERTED=0

for playbook_dir in "$CAPS_DIR"/*; do
    if [ -d "$playbook_dir" ] && [ -f "$playbook_dir/playbook.md" ]; then
        playbook_name=$(basename "$playbook_dir")
        playbook_file="$playbook_dir/playbook.md"
        
        # Extract frontmatter
        title=$(grep "^title:" "$playbook_file" | head -1 | sed 's/title: *//')
        description=$(grep "^description:" "$playbook_file" | head -1 | sed 's/description: *//')
        
        # Extract allowed_tools
        tools=$(awk '/^allowed_tools:/,/^[a-z]/' "$playbook_file" | grep '^\s*-' | sed 's/^\s*- *//' | paste -sd "," -)
        
        # Extract content after frontmatter
        content=$(awk '/^---$/{ if (count==1) {flag=1; next} count++} flag' "$playbook_file")
        
        # Create skill directory
        skill_dir="$SKILLS_DIR/$playbook_name"
        mkdir -p "$skill_dir"
        
        # Generate SKILL.md
        cat > "$skill_dir/SKILL.md" << SKILLEOF
---
name: ${playbook_name}
description: ${description}
allowed-tools: ${tools}
---

${content}
SKILLEOF
        
        echo -e "${GREEN}✓${NC} Converted: $playbook_name"
        ((CONVERTED++))
    fi
done

echo ""
echo "================================================"
echo -e "${GREEN}✨ Conversion Complete!${NC}"
echo "   Converted: $CONVERTED playbook(s)"
echo "   Output: $SKILLS_DIR"

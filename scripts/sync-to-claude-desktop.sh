#!/bin/bash

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Directories
SKILLS_DIR="skills"
# Windows path for Claude Desktop (WSL)
CLAUDE_SKILLS_DIR="/mnt/c/Users/Asad/.claude/skills"

echo -e "${BLUE}🚀 Syncing Skills to Claude Desktop (Windows)${NC}"
echo "================================================"

# Create Claude skills directory
mkdir -p "$CLAUDE_SKILLS_DIR"

skill_count=0
synced_count=0

# Count valid skills
for skill_dir in "$SKILLS_DIR"/*/ ; do
    if [ -f "${skill_dir}SKILL.md" ]; then
        ((skill_count++))
    fi
done

echo -e "${BLUE}📦 Found $skill_count skill(s) with SKILL.md${NC}"
echo ""

# Sync each valid skill
for skill_dir in "$SKILLS_DIR"/*/ ; do
    skill_name=$(basename "$skill_dir")
    skill_file="${skill_dir}SKILL.md"
    
    if [ -f "$skill_file" ]; then
        target_dir="$CLAUDE_SKILLS_DIR/$skill_name"
        mkdir -p "$target_dir"
        cp "$skill_file" "$target_dir/"
        echo -e "${GREEN}✓${NC} Synced: $skill_name"
        ((synced_count++))
    fi
done

echo ""
echo "================================================"
echo -e "${GREEN}✨ Sync Complete!${NC}"
echo -e "   Synced: $synced_count"
echo ""
echo "Skills location: $CLAUDE_SKILLS_DIR"
echo ""
echo -e "${YELLOW}💡 Restart Claude Desktop to load new skills${NC}"

#!/bin/bash

# caps-to-recipes.sh
# Converts CAPS playbooks to Goose Recipes

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}🔄 Converting CAPS Playbooks to Goose Recipes${NC}"
echo "================================================"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CAPS_DIR="${REPO_ROOT}/caps-playbooks"
RECIPES_DIR="${REPO_ROOT}/recipes"

if [ ! -d "$CAPS_DIR" ]; then
    echo -e "${RED}❌ Error: caps-playbooks/ directory not found${NC}"
    exit 1
fi

mkdir -p "$RECIPES_DIR"

CONVERTED=0

for playbook_dir in "$CAPS_DIR"/*; do
    if [ -d "$playbook_dir" ] && [ -f "$playbook_dir/playbook.md" ]; then
        playbook_name=$(basename "$playbook_dir")
        playbook_file="$playbook_dir/playbook.md"
        
        # Extract metadata
        title=$(grep "^title:" "$playbook_file" | head -1 | sed 's/title: *//')
        description=$(grep "^description:" "$playbook_file" | head -1 | sed 's/description: *//')
        version=$(grep "^version:" "$playbook_file" | head -1 | sed 's/version: *//' || echo "1.0.0")
        
        # Create recipe directory
        recipe_dir="$RECIPES_DIR/$playbook_name"
        mkdir -p "$recipe_dir"
        
        # Generate recipe.yaml
        cat > "$recipe_dir/recipe.yaml" << RECIPEEOF
name: ${title}
description: ${description}
version: ${version}
extensions:
  - kubectl
  - helm
RECIPEEOF
        
        # Copy playbook as instructions
        cp "$playbook_file" "$recipe_dir/instructions.md"
        
        echo -e "${GREEN}✓${NC} Converted: $playbook_name"
        ((CONVERTED++))
    fi
done

echo ""
echo "================================================"
echo -e "${GREEN}✨ Conversion Complete!${NC}"
echo "   Converted: $CONVERTED playbook(s)"
echo "   Output: $RECIPES_DIR"

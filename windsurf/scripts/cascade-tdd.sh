#!/bin/bash

# Script to generate a prompt for Cascade workflows and optionally install globally
# This script will:
# 1. Generate and copy workflow prompts for Cascade
# 2. Install multiple workflows from the ./workflows folder
# 3. Optionally install the script globally for use from any directory

set -e  # Exit on any error

# Colors for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the absolute path to this repository and script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_PATH="$SCRIPT_DIR/$(basename "${BASH_SOURCE[0]}")"

# Function to uninstall the script globally
uninstall_globally() {
  echo -e "${BLUE}Uninstalling Agentic TDD command...${NC}"
  
  # Remove the symlink from ~/.local/bin
  if [ -L "$HOME/.local/bin/cascade-tdd" ]; then
    rm -f "$HOME/.local/bin/cascade-tdd"
    echo -e "${GREEN}✅ Removed symlink from ~/.local/bin${NC}"
  else
    echo -e "${YELLOW}No symlink found in ~/.local/bin${NC}"
  fi
  
  # Remove PATH entry and alias from shell config if needed
  SHELL_CONFIG=""
  if [[ -f ~/.zshrc ]]; then
    SHELL_CONFIG=~/.zshrc
  elif [[ -f ~/.bashrc ]]; then
    SHELL_CONFIG=~/.bashrc
  fi
  
  if [[ -n "$SHELL_CONFIG" ]]; then
    # Check if the PATH entry was added by this script
    if grep -q "# Added by cascade-tdd.sh" "$SHELL_CONFIG"; then
      echo -e "${BLUE}Removing PATH entry and alias from $SHELL_CONFIG...${NC}"
      # Create a temporary file without the PATH entry and alias
      TMP_FILE=$(mktemp)
      sed '/# Added by cascade-tdd.sh/d' "$SHELL_CONFIG" | \
      sed '/export PATH="\$HOME\/\.local\/bin:\$PATH"/d' | \
      sed '/# Alias for cascade-tdd command/d' | \
      sed '/alias cascade-tdd=/d' > "$TMP_FILE"
      # Replace the original file
      mv "$TMP_FILE" "$SHELL_CONFIG"
      echo -e "${GREEN}✅ Removed PATH entry and alias from $SHELL_CONFIG${NC}"
      echo -e "${YELLOW}Note: You need to run 'source $SHELL_CONFIG' or start a new terminal session for the changes to take effect.${NC}"
    else
      echo -e "${YELLOW}No PATH entry found in $SHELL_CONFIG${NC}"
    fi
  fi
  
  echo -e "${GREEN}✅ Global Agentic TDD command uninstallation complete!${NC}"
  exit 0
}

# Function to install the script globally
install_globally() {
  echo -e "${BLUE}Installing Agentic TDD command globally...${NC}"
  
  # 1. Use existing Codeium Windsurf directories
  echo -e "${BLUE}Setting up Codeium Windsurf directories...${NC}"
  WINDSURF_INSTALL_PATH="$HOME/.codeium/windsurf/workflows"
  mkdir -p "$WINDSURF_INSTALL_PATH"
  
  # Create ~/.local/bin directory if it doesn't exist
  mkdir -p "$HOME/.local/bin"
  
  # Create a symlink to this script in ~/.local/bin
  ln -sf "$SCRIPT_PATH" "$HOME/.local/bin/cascade-tdd"
  chmod +x "$HOME/.local/bin/cascade-tdd"
  
  # Copy workflow files to the Windsurf directory
  if [ -d "$SCRIPT_DIR/../workflows" ]; then
    cp "$SCRIPT_DIR/../workflows"/*.md $WINDSURF_INSTALL_PATH
    echo -e "${GREEN}✅ Copied workflow files to $WINDSURF_INSTALL_PATH${NC}"
  else
    echo -e "${YELLOW}Warning: Could not find workflow files in $SCRIPT_DIR/../workflows${NC}"
  fi
  echo -e "${GREEN}✅ Created symlink to cascade-tdd.sh in ~/.local/bin${NC}"
  
  # Check if ~/.local/bin is in PATH
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    # Determine which shell config file to use
    SHELL_CONFIG=""
    if [[ -f ~/.zshrc ]]; then
      SHELL_CONFIG=~/.zshrc
    elif [[ -f ~/.bashrc ]]; then
      SHELL_CONFIG=~/.bashrc
    else
      echo -e "${YELLOW}Warning: Could not find .zshrc or .bashrc. You will need to manually add ~/.local/bin to your PATH.${NC}"
    fi
  
    if [[ -n "$SHELL_CONFIG" ]]; then
      echo -e "${BLUE}Adding ~/.local/bin to PATH in $SHELL_CONFIG...${NC}"
      echo '' >> "$SHELL_CONFIG"
      echo '# Added by cascade-tdd.sh' >> "$SHELL_CONFIG"
      echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_CONFIG"
      echo '' >> "$SHELL_CONFIG"
      echo '# Alias for cascade-tdd command' >> "$SHELL_CONFIG"
      echo 'alias cascade-tdd="$HOME/.local/bin/cascade-tdd"' >> "$SHELL_CONFIG"
      echo -e "${GREEN}✅ PATH and alias updated in $SHELL_CONFIG${NC}"
      echo -e "${YELLOW}Note: You need to run 'source $SHELL_CONFIG' or start a new terminal session for the changes to take effect.${NC}"
    fi
  else
    echo -e "${GREEN}✅ ~/.local/bin is already in PATH${NC}"
  fi
  
  echo -e "${GREEN}✅ Global Agentic TDD command installation complete!${NC}"
  echo -e "${BLUE}You can now run the command from any directory using:${NC}"
  echo -e "${YELLOW}cascade-tdd <JIRA-TASK-ID>${NC}"
  echo -e "${BLUE}After opening a new terminal or running:${NC}"
  echo -e "${YELLOW}source $SHELL_CONFIG${NC}"
  echo -e "${BLUE}The command is available both as an alias and as an executable in your PATH.${NC}"
  
  exit 0
}

# Check for install/uninstall flags
if [ "$1" = "--install" ] || [ "$1" = "-i" ]; then
  install_globally
fi

if [ "$1" = "--uninstall" ] || [ "$1" = "-u" ]; then
  uninstall_globally
fi

# Function to list available workflows
list_workflows() {
  echo -e "${BLUE}Available workflows:${NC}"
  
  WINDSURF_INSTALL_PATH="$HOME/.codeium/windsurf/workflows"
  if [ -d "$WINDSURF_INSTALL_PATH" ]; then
    # List workflows in the installation directory
    WORKFLOWS=$(find "$WINDSURF_INSTALL_PATH" -name "*.md" -type f -exec basename {} \; | sort)
    
    if [ -z "$WORKFLOWS" ]; then
      echo -e "${YELLOW}No workflows found in $WINDSURF_INSTALL_PATH${NC}"
      
      # Check if we have workflows in the repository
      if [ -d "$SCRIPT_DIR/../workflows" ]; then
        echo -e "${BLUE}Workflows available in repository (not installed):${NC}"
        find "$SCRIPT_DIR/../workflows" -name "*.md" -type f -exec basename {} \; | sort | while read -r workflow; do
          WORKFLOW_NAME="${workflow%.md}"
          echo -e "  ${YELLOW}$WORKFLOW_NAME${NC} (not installed, use --install to install)"
        done
      fi
    else
      echo "$WORKFLOWS" | while read -r workflow; do
        WORKFLOW_NAME="${workflow%.md}"
        echo -e "  ${YELLOW}$WORKFLOW_NAME${NC}"
      done
    fi
  else
    echo -e "${YELLOW}Workflow directory not found at $WINDSURF_INSTALL_PATH${NC}"
    
    # Check if we have workflows in the repository
    if [ -d "$SCRIPT_DIR/../workflows" ]; then
      echo -e "${BLUE}Workflows available in repository (not installed):${NC}"
      find "$SCRIPT_DIR/../workflows" -name "*.md" -type f -exec basename {} \; | sort | while read -r workflow; do
        WORKFLOW_NAME="${workflow%.md}"
        echo -e "  ${YELLOW}$WORKFLOW_NAME${NC} (not installed, use --install to install)"
      done
    fi
  fi
  
  exit 0
}

# Check if help flag is provided
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  echo -e "${BLUE}Cascade Workflows Helper${NC}"
  echo -e "${YELLOW}Usage:${NC}"
  echo -e "  ./cascade-tdd.sh <JIRA-TASK-ID> [WORKFLOW-NAME]    Generate prompt for a JIRA task using specified workflow (default: agentic-tdd-jira)"
  echo -e "  ./cascade-tdd.sh --list|-l                         List available workflows"
  echo -e "  ./cascade-tdd.sh --install|-i                      Install this script globally and all workflows"
  echo -e "  ./cascade-tdd.sh --uninstall|-u                    Uninstall the global script"
  echo -e "  ./cascade-tdd.sh --help|-h                         Show this help message"
  exit 0
fi

# Check if list flag is provided
if [ "$1" = "--list" ] || [ "$1" = "-l" ]; then
  list_workflows
fi

# Get the current repository info
REPO_PATH=$(pwd)
REPO_NAME=$(basename "$REPO_PATH")

# Check if a JIRA task ID was provided
if [ -z "$1" ]; then
  echo -e "${RED}Error: Please provide a JIRA task ID${NC}"
  echo -e "Usage: ./cascade-tdd.sh <JIRA-TASK-ID> [WORKFLOW-NAME]"
  echo -e "       ./cascade-tdd.sh --list       List available workflows"
  echo -e "       ./cascade-tdd.sh --install    Install globally"
  echo -e "       ./cascade-tdd.sh --uninstall  Uninstall globally"
  echo -e "       ./cascade-tdd.sh --help       Show help"
  exit 1
fi

JIRA_TASK="$1"
WORKFLOW_NAME="agentic-tdd-jira"  # Default workflow name

# Check if a specific workflow was provided as the second argument
if [ ! -z "$2" ]; then
  WORKFLOW_NAME="$2"
fi

# Path to the workflow file - use the existing one
WORKFLOW_FILE="$HOME/.codeium/windsurf/workflows/${WORKFLOW_NAME}.md"

# Check if the workflow file exists
if [ ! -f "$WORKFLOW_FILE" ]; then
  echo -e "${YELLOW}Warning: Workflow file not found at $WORKFLOW_FILE${NC}"
  echo -e "${BLUE}Checking if we can copy it from the repository...${NC}"
  
  # Try to copy from the repository if available
  if [ -f "$SCRIPT_DIR/../workflows/${WORKFLOW_NAME}.md" ]; then
    mkdir -p "$(dirname "$WORKFLOW_FILE")"
    cp "$SCRIPT_DIR/../workflows/${WORKFLOW_NAME}.md" "$WORKFLOW_FILE"
    echo -e "${GREEN}✅ Copied workflow file to $WORKFLOW_FILE${NC}"
  else
    echo -e "${RED}Error: Workflow '${WORKFLOW_NAME}' not found at $WORKFLOW_FILE and couldn't find it in the repository${NC}"
    echo -e "Please make sure the workflow file exists or install the script globally with --install"
    echo -e "Use --list to see available workflows"
    exit 1
  fi
fi

# Generate the workflow prompt
echo -e "${BLUE}Generating workflow prompt for Cascade...${NC}"

# Create a prompt that can be easily copied
PROMPT_FILE="/tmp/cascade_tdd_prompt.txt"
cat > "$PROMPT_FILE" << EOF
$WORKFLOW_FILE
RUN FLOW "${WORKFLOW_NAME}" WITH VARIABLES {"jira_task": "$JIRA_TASK", "repository_name": "$REPO_NAME", "repository_path": "$REPO_PATH"}
EOF

# Display instructions
echo -e "${GREEN}----------------------------------------${NC}"
echo -e "${YELLOW}Cascade Prompt:${NC}"
echo -e "${GREEN}----------------------------------------${NC}"
cat "$PROMPT_FILE"
echo -e "${GREEN}----------------------------------------${NC}"
echo -e "${BLUE}The prompt has been saved to: $PROMPT_FILE${NC}"
echo -e "${BLUE}Copy and paste this prompt into Cascade to run the workflow.${NC}"
echo -e "${GREEN}----------------------------------------${NC}"

# Copy the prompt to clipboard for convenience
if command -v pbcopy &> /dev/null; then
  # macOS
  cat "$PROMPT_FILE" | pbcopy
  echo -e "${GREEN}✅ Prompt copied to clipboard!${NC}"
elif command -v xclip &> /dev/null; then
  # Linux with xclip
  cat "$PROMPT_FILE" | xclip -selection clipboard
  echo -e "${GREEN}✅ Prompt copied to clipboard!${NC}"
elif command -v clip.exe &> /dev/null; then
  # Windows
  cat "$PROMPT_FILE" | clip.exe
  echo -e "${GREEN}✅ Prompt copied to clipboard!${NC}"
else
  echo -e "${YELLOW}⚠️ Could not copy to clipboard. Please copy the prompt manually.${NC}"
fi

echo -e "${GREEN}✅ Cascade workflow prompt generated for '${WORKFLOW_NAME}'!${NC}"
echo -e "${BLUE}You can run this script again from any repository using:${NC}"
echo -e "${YELLOW} cascade-tdd.sh <JIRA-TASK-ID> [WORKFLOW-NAME]${NC}"

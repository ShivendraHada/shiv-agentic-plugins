#!/bin/bash
#
# DEPRECATED: Use install-wiser-plugins.sh instead for global plugin installation.
#
# This script installs commands per-project. The new install-wiser-plugins.sh
# installs plugins globally so they work across ALL projects without per-project setup.
#
# Migration:
#   ./install-wiser-plugins.sh install    # Install globally (one-time)
#   ./install-wiser-plugins.sh migrate    # Remove per-project duplicates
#
# ─────────────────────────────────────────────────────────────────────────────
#
# Install Claude Code Commands (Legacy - Per-Project)
#
# This script fetches and installs Claude Code slash commands from the
# agentic-development repository to your local project.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/WiserSolutions/agentic-development/main/install-claude-commands.sh | bash
#
# Or download and run:
#   ./install-claude-commands.sh
#
# Options:
#   --repo URL      Override the source repository URL
#   --branch NAME   Override the source branch (default: main)
#   --subdir PATH   Override the source subdirectory (default: claude-commands)
#   --target PATH   Override the target directory (default: .claude/commands)
#   --help          Show this help message
#

set -e

# Default configuration
ORG_REPO_URL="${ORG_REPO_URL:-https://github.com/WiserSolutions/agentic-development.git}"
ORG_BRANCH="${ORG_BRANCH:-main}"
ORG_SUBDIR="${ORG_SUBDIR:-claude-commands}"
TARGET_DIR="${TARGET_DIR:-.claude/commands}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}       ${GREEN}Claude Code Commands Installer${NC}                          ${BLUE}║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

show_help() {
    cat << EOF
Install Claude Code Commands

Usage: $0 [OPTIONS]

Options:
  --repo URL      Source repository URL
                  Default: $ORG_REPO_URL
  --branch NAME   Source branch name
                  Default: $ORG_BRANCH
  --subdir PATH   Source subdirectory containing commands
                  Default: $ORG_SUBDIR
  --target PATH   Target directory for commands
                  Default: $TARGET_DIR
  --help          Show this help message

Environment Variables:
  ORG_REPO_URL    Same as --repo
  ORG_BRANCH      Same as --branch
  ORG_SUBDIR      Same as --subdir
  TARGET_DIR      Same as --target

Examples:
  # Install with defaults
  $0

  # Install from a different repository
  $0 --repo https://github.com/MyOrg/my-repo.git

  # Install to a custom directory
  $0 --target .claude/custom-commands

  # Use environment variables
  ORG_BRANCH=develop $0

EOF
    exit 0
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --repo)
            ORG_REPO_URL="$2"
            shift 2
            ;;
        --branch)
            ORG_BRANCH="$2"
            shift 2
            ;;
        --subdir)
            ORG_SUBDIR="$2"
            shift 2
            ;;
        --target)
            TARGET_DIR="$2"
            shift 2
            ;;
        --help|-h)
            show_help
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Main installation
print_header

print_info "Configuration:"
echo "  Repository: $ORG_REPO_URL"
echo "  Branch:     $ORG_BRANCH"
echo "  Subdirectory: $ORG_SUBDIR"
echo "  Target:     $TARGET_DIR"
echo ""

# Check for git
if ! command -v git &> /dev/null; then
    print_error "git is required but not installed"
    exit 1
fi

# Create target directory
print_info "Creating target directory..."
mkdir -p "$TARGET_DIR"
print_success "Target directory ready: $TARGET_DIR"

# Create temporary directory
TMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'claude-commands')
trap "rm -rf $TMP_DIR" EXIT

print_info "Cloning repository (shallow)..."
if ! git clone --depth 1 --branch "$ORG_BRANCH" "$ORG_REPO_URL" "$TMP_DIR/src" 2>/dev/null; then
    print_error "Failed to clone repository"
    print_info "Check that the repository URL and branch are correct"
    exit 1
fi
print_success "Repository cloned successfully"

# Verify source directory exists
SOURCE_DIR="$TMP_DIR/src/$ORG_SUBDIR"
if [ ! -d "$SOURCE_DIR" ]; then
    print_error "Source directory not found: $ORG_SUBDIR"
    print_info "Available directories in repository:"
    ls -la "$TMP_DIR/src" | grep "^d" | awk '{print "  " $NF}'
    exit 1
fi

# Count existing and new files
EXISTING_COUNT=$(find "$TARGET_DIR" -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
NEW_COUNT=$(find "$SOURCE_DIR" -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

print_info "Syncing commands..."

# Sync files
if command -v rsync &> /dev/null; then
    rsync -a "$SOURCE_DIR/" "$TARGET_DIR/"
else
    # Fallback to cp
    if [ "$EXISTING_COUNT" -gt 0 ]; then
        find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
    fi
    cp -R "$SOURCE_DIR"/. "$TARGET_DIR"/
fi
print_success "Files synced successfully"

# List installed commands
echo ""
print_info "Installed commands:"
echo ""
for file in "$TARGET_DIR"/*.md; do
    if [ -f "$file" ]; then
        cmd_name=$(basename "$file" .md)
        echo -e "  ${GREEN}/${cmd_name}${NC}"
    fi
done

# Summary
FINAL_COUNT=$(find "$TARGET_DIR" -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
echo ""
print_success "Installation complete!"
echo ""
echo "  Commands installed: $FINAL_COUNT"
echo "  Location: $TARGET_DIR"
echo ""
print_info "To use a command, type / followed by the command name in Claude Code"
print_info "Example: /create-story"
echo ""

# Check if we're in a git repo and remind about .gitignore
if [ -d .git ]; then
    if ! grep -q "^\.claude/" .gitignore 2>/dev/null; then
        print_warning "Consider adding .claude/ to .gitignore if you don't want to track commands"
    fi
fi

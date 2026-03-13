#!/bin/bash
#
# Wiser Plugins Manager for Claude Code
#
# Installs, updates, and manages Wiser plugins globally for Claude Code.
# Plugins are available across all projects without per-project installation.
#
# Usage:
#   ./install-wiser-plugins.sh install    # Install all plugins globally
#   ./install-wiser-plugins.sh update     # Update plugins from remote
#   ./install-wiser-plugins.sh list       # List installed plugins and commands
#   ./install-wiser-plugins.sh status     # Show status and detect overrides
#   ./install-wiser-plugins.sh remove     # Remove all installed plugins
#   ./install-wiser-plugins.sh migrate    # Migrate project .claude/commands/ to global
#   ./install-wiser-plugins.sh --help     # Show help
#

set -e

# Configuration
REPO_URL="${WISER_REPO_URL:-https://github.com/WiserSolutions/agentic-development.git}"
BRANCH="${WISER_BRANCH:-main}"
MARKETPLACE_DIR="$HOME/.claude/plugins/marketplaces/wiser-plugins"
PLUGINS_SUBDIR="plugins"
KNOWN_MARKETPLACES="$HOME/.claude/plugins/known_marketplaces.json"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Output helpers
print_header() {
    echo ""
    echo -e "${BLUE}${BOLD}Wiser Plugins Manager for Claude Code${NC}"
    echo -e "${BLUE}======================================${NC}"
    echo ""
}

print_success() { echo -e "  ${GREEN}✓${NC} $1"; }
print_warning() { echo -e "  ${YELLOW}!${NC} $1"; }
print_error()   { echo -e "  ${RED}✗${NC} $1"; }
print_info()    { echo -e "  ${BLUE}i${NC} $1"; }
print_item()    { echo -e "    ${CYAN}/$1${NC}  $2"; }

# ─────────────────────────────────────────────
# install: Sparse-clone plugins into marketplace
# ─────────────────────────────────────────────
cmd_install() {
    print_header
    print_info "Installing Wiser plugins globally..."
    echo ""
    print_info "Repository: $REPO_URL"
    print_info "Branch:     $BRANCH"
    print_info "Target:     $MARKETPLACE_DIR"
    echo ""

    # Check prerequisites
    if ! command -v git &> /dev/null; then
        print_error "git is required but not installed"
        exit 1
    fi

    if ! command -v jq &> /dev/null; then
        print_warning "jq not found — marketplace registration will be skipped"
        print_warning "Install jq for full functionality: brew install jq"
        JQ_AVAILABLE=false
    else
        JQ_AVAILABLE=true
    fi

    # Ensure parent directory exists
    mkdir -p "$HOME/.claude/plugins/marketplaces"

    if [ -d "$MARKETPLACE_DIR/.git" ]; then
        print_info "Existing installation found. Updating..."
        cd "$MARKETPLACE_DIR"
        git fetch origin "$BRANCH" --depth 1 2>/dev/null
        git reset --hard "origin/$BRANCH" 2>/dev/null
        print_success "Updated to latest version"
    else
        # Remove stale directory if exists without .git
        [ -d "$MARKETPLACE_DIR" ] && rm -rf "$MARKETPLACE_DIR"

        print_info "Cloning repository (sparse checkout)..."
        git clone --filter=blob:none --sparse --depth 1 --branch "$BRANCH" \
            "$REPO_URL" "$MARKETPLACE_DIR" 2>/dev/null

        cd "$MARKETPLACE_DIR"
        git sparse-checkout set "$PLUGINS_SUBDIR/" 2>/dev/null
        print_success "Repository cloned with sparse checkout"
    fi

    # Register as marketplace in known_marketplaces.json
    if [ "$JQ_AVAILABLE" = true ] && [ -f "$KNOWN_MARKETPLACES" ]; then
        register_marketplace
    elif [ "$JQ_AVAILABLE" = true ]; then
        # Create the file if it doesn't exist
        echo '{}' > "$KNOWN_MARKETPLACES"
        register_marketplace
    fi

    # Validate bd hooks
    validate_bd_hooks

    # Show what was installed
    echo ""
    cmd_list

    echo ""
    print_success "Installation complete!"
    echo ""
    print_info "Commands are now available globally in Claude Code."
    print_info "Type / in Claude Code to see all available commands."
    print_info "Run '/wiser-sync' inside Claude Code to update later."
    echo ""
}

# ─────────────────────────────────────────────
# update: Pull latest changes
# ─────────────────────────────────────────────
cmd_update() {
    print_header

    if [ ! -d "$MARKETPLACE_DIR/.git" ]; then
        print_error "Wiser plugins not installed. Run 'install' first."
        exit 1
    fi

    print_info "Updating Wiser plugins..."
    cd "$MARKETPLACE_DIR"

    # Capture current state
    OLD_HEAD=$(git rev-parse HEAD 2>/dev/null)

    git fetch origin "$BRANCH" --depth 1 2>/dev/null
    git reset --hard "origin/$BRANCH" 2>/dev/null

    NEW_HEAD=$(git rev-parse HEAD 2>/dev/null)

    if [ "$OLD_HEAD" = "$NEW_HEAD" ]; then
        print_success "Already up to date"
    else
        print_success "Updated to latest version"
        echo ""
        print_info "Changes:"
        git diff --name-only "$OLD_HEAD" "$NEW_HEAD" 2>/dev/null | while read -r file; do
            echo "    $file"
        done
    fi
    echo ""
}

# ─────────────────────────────────────────────
# list: Show installed plugins and their contents
# ─────────────────────────────────────────────
cmd_list() {
    if [ ! -d "$MARKETPLACE_DIR/$PLUGINS_SUBDIR" ]; then
        print_error "Wiser plugins not installed. Run 'install' first."
        exit 1
    fi

    echo -e "${BOLD}Installed Wiser Plugins:${NC}"
    echo ""

    for plugin_dir in "$MARKETPLACE_DIR/$PLUGINS_SUBDIR"/wiser-*/; do
        [ -d "$plugin_dir" ] || continue
        plugin_name=$(basename "$plugin_dir")

        # Read description from plugin.json
        local desc=""
        if [ -f "$plugin_dir/.claude-plugin/plugin.json" ] && command -v jq &>/dev/null; then
            desc=$(jq -r '.description // ""' "$plugin_dir/.claude-plugin/plugin.json" 2>/dev/null)
        fi

        echo -e "  ${BOLD}${GREEN}$plugin_name${NC}"
        [ -n "$desc" ] && echo -e "  ${CYAN}$desc${NC}"
        echo ""

        # List commands
        if [ -d "$plugin_dir/commands" ]; then
            for cmd_file in "$plugin_dir/commands"/*.md; do
                [ -f "$cmd_file" ] || continue
                local cmd_name
                cmd_name=$(basename "$cmd_file" .md)
                print_item "$cmd_name" "(command)"
            done
        fi

        # List skills
        if [ -d "$plugin_dir/skills" ]; then
            for skill_dir in "$plugin_dir/skills"/*/; do
                [ -d "$skill_dir" ] || continue
                local skill_name
                skill_name=$(basename "$skill_dir")
                print_item "$skill_name" "(skill)"
            done
        fi

        # List agents
        if [ -d "$plugin_dir/agents" ]; then
            for agent_file in "$plugin_dir/agents"/*.md; do
                [ -f "$agent_file" ] || continue
                local agent_name
                agent_name=$(basename "$agent_file" .md)
                print_item "$agent_name" "(agent)"
            done
        fi

        echo ""
    done
}

# ─────────────────────────────────────────────
# status: Show status and detect overrides
# ─────────────────────────────────────────────
cmd_status() {
    print_header

    if [ ! -d "$MARKETPLACE_DIR/$PLUGINS_SUBDIR" ]; then
        print_error "Wiser plugins not installed. Run 'install' first."
        exit 1
    fi

    # Show version info
    if [ -d "$MARKETPLACE_DIR/.git" ]; then
        cd "$MARKETPLACE_DIR"
        local commit_hash commit_date
        commit_hash=$(git rev-parse --short HEAD 2>/dev/null)
        commit_date=$(git log -1 --format="%ci" 2>/dev/null)
        print_info "Version: $commit_hash ($commit_date)"
    fi
    echo ""

    # Detect overrides in current project
    echo -e "${BOLD}Override Detection (current project):${NC}"
    echo ""

    local override_count=0
    local identical_count=0

    for plugin_dir in "$MARKETPLACE_DIR/$PLUGINS_SUBDIR"/wiser-*/; do
        [ -d "$plugin_dir" ] || continue

        # Check commands
        if [ -d "$plugin_dir/commands" ]; then
            for cmd_file in "$plugin_dir/commands"/*.md; do
                [ -f "$cmd_file" ] || continue
                local cmd_name
                cmd_name=$(basename "$cmd_file")
                local local_cmd=".claude/commands/$cmd_name"

                if [ -f "$local_cmd" ]; then
                    if diff -q "$cmd_file" "$local_cmd" > /dev/null 2>&1; then
                        print_warning "IDENTICAL (can remove local): $cmd_name"
                        identical_count=$((identical_count + 1))
                    else
                        print_info "OVERRIDE (local differs): $cmd_name"
                        override_count=$((override_count + 1))
                    fi
                fi
            done
        fi

        # Check skills
        if [ -d "$plugin_dir/skills" ]; then
            for skill_dir in "$plugin_dir/skills"/*/; do
                [ -d "$skill_dir" ] || continue
                local skill_name
                skill_name=$(basename "$skill_dir")
                local local_skill=".claude/skills/$skill_name/SKILL.md"

                if [ -f "$local_skill" ]; then
                    print_info "OVERRIDE (local skill): $skill_name"
                    override_count=$((override_count + 1))
                fi
            done
        fi

        # Check agents
        if [ -d "$plugin_dir/agents" ]; then
            for agent_file in "$plugin_dir/agents"/*.md; do
                [ -f "$agent_file" ] || continue
                local agent_name
                agent_name=$(basename "$agent_file")
                local local_agent=".claude/agents/$agent_name"

                if [ -f "$local_agent" ]; then
                    print_info "OVERRIDE (local agent): $agent_name"
                    override_count=$((override_count + 1))
                fi
            done
        fi
    done

    if [ "$override_count" -eq 0 ] && [ "$identical_count" -eq 0 ]; then
        print_success "No local overrides detected. All commands use global plugins."
    else
        echo ""
        [ "$override_count" -gt 0 ] && print_info "$override_count active override(s) (local takes priority)"
        [ "$identical_count" -gt 0 ] && print_warning "$identical_count identical local file(s) (safe to remove with 'migrate')"
    fi
    echo ""
}

# ─────────────────────────────────────────────
# remove: Uninstall plugins
# ─────────────────────────────────────────────
cmd_remove() {
    print_header

    if [ ! -d "$MARKETPLACE_DIR" ]; then
        print_info "Wiser plugins are not installed."
        return
    fi

    read -r -p "  Remove all Wiser plugins? [y/N] " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        rm -rf "$MARKETPLACE_DIR"
        print_success "Wiser plugins removed"

        # Deregister from known_marketplaces.json
        if command -v jq &>/dev/null && [ -f "$KNOWN_MARKETPLACES" ]; then
            local tmp
            tmp=$(mktemp)
            jq 'del(."wiser-plugins")' "$KNOWN_MARKETPLACES" > "$tmp" && mv "$tmp" "$KNOWN_MARKETPLACES"
            print_success "Deregistered from marketplace list"
        fi
    else
        print_info "Cancelled"
    fi
    echo ""
}

# ─────────────────────────────────────────────
# migrate: Remove duplicate local commands
# ─────────────────────────────────────────────
cmd_migrate() {
    print_header

    if [ ! -d "$MARKETPLACE_DIR/$PLUGINS_SUBDIR" ]; then
        print_error "Wiser plugins not installed. Run 'install' first."
        exit 1
    fi

    if [ ! -d ".claude/commands" ]; then
        print_info "No .claude/commands/ directory in current project. Nothing to migrate."
        return
    fi

    echo -e "${BOLD}Migration: Remove local commands that match global plugins${NC}"
    echo ""

    local removed=0
    local kept=0

    for plugin_dir in "$MARKETPLACE_DIR/$PLUGINS_SUBDIR"/wiser-*/commands/; do
        [ -d "$plugin_dir" ] || continue

        for cmd_file in "$plugin_dir"*.md; do
            [ -f "$cmd_file" ] || continue
            local cmd_name
            cmd_name=$(basename "$cmd_file")
            local local_cmd=".claude/commands/$cmd_name"

            if [ -f "$local_cmd" ]; then
                if diff -q "$cmd_file" "$local_cmd" > /dev/null 2>&1; then
                    rm "$local_cmd"
                    print_success "Removed identical local: $cmd_name"
                    removed=$((removed + 1))
                else
                    print_warning "Kept modified local: $cmd_name (local override)"
                    kept=$((kept + 1))
                fi
            fi
        done
    done

    echo ""
    print_info "Removed: $removed identical file(s)"
    print_info "Kept:    $kept modified override(s)"

    # Clean up empty commands directory
    if [ -d ".claude/commands" ] && [ -z "$(ls -A .claude/commands/ 2>/dev/null)" ]; then
        rmdir ".claude/commands"
        print_info "Removed empty .claude/commands/ directory"
    fi
    echo ""
}

# ─────────────────────────────────────────────
# Helper: Register in known_marketplaces.json
# ─────────────────────────────────────────────
register_marketplace() {
    local tmp
    tmp=$(mktemp)
    local now
    now=$(date -u +"%Y-%m-%dT%H:%M:%S.000Z")

    jq --arg dir "$MARKETPLACE_DIR" --arg now "$now" \
        '."wiser-plugins" = {
            "source": {
                "source": "github",
                "repo": "WiserSolutions/agentic-development"
            },
            "installLocation": $dir,
            "lastUpdated": $now
        }' "$KNOWN_MARKETPLACES" > "$tmp" && mv "$tmp" "$KNOWN_MARKETPLACES"

    print_success "Registered as marketplace in known_marketplaces.json"
}

# ─────────────────────────────────────────────
# Helper: Validate bd hooks in settings.json
# ─────────────────────────────────────────────
validate_bd_hooks() {
    local settings="$HOME/.claude/settings.json"

    if ! command -v bd &>/dev/null; then
        print_warning "bd (beads) not found. Install for full task tracking: brew install bd"
        return
    fi

    if [ ! -f "$settings" ]; then
        print_warning "No ~/.claude/settings.json found. bd hooks not configured."
        print_info "Run 'bd hooks install' to set up bd integration."
        return
    fi

    if command -v jq &>/dev/null; then
        local has_session_hook
        has_session_hook=$(jq -r '.hooks.SessionStart // empty' "$settings" 2>/dev/null)
        if [ -z "$has_session_hook" ]; then
            print_warning "bd SessionStart hook not found in settings.json"
            print_info "Run 'bd hooks install' to set up bd integration."
        else
            print_success "bd hooks are configured"
        fi
    fi
}

# ─────────────────────────────────────────────
# Help
# ─────────────────────────────────────────────
show_help() {
    print_header
    cat << 'EOF'
  Usage: install-wiser-plugins.sh <command>

  Commands:
    install    Install Wiser plugins globally for Claude Code
    update     Update plugins to the latest version
    list       List all installed plugins, commands, skills, and agents
    status     Show version info and detect local overrides
    remove     Uninstall all Wiser plugins
    migrate    Remove local .claude/commands/ files that are identical to global

  Options:
    --help     Show this help message

  Environment Variables:
    WISER_REPO_URL   Override repository URL
    WISER_BRANCH     Override branch (default: main)

  Examples:
    # First-time setup
    ./install-wiser-plugins.sh install

    # Check for updates
    ./install-wiser-plugins.sh update

    # See what's installed
    ./install-wiser-plugins.sh list

    # Clean up a project that had per-project commands
    cd my-project && /path/to/install-wiser-plugins.sh migrate

  After installation, all /commands are available globally in Claude Code.
  To override a global command for a specific project, create a file with
  the same name in your project's .claude/commands/ directory.

EOF
}

# ─────────────────────────────────────────────
# Main
# ─────────────────────────────────────────────
case "${1:-}" in
    install)  cmd_install  ;;
    update)   cmd_update   ;;
    list)     cmd_list     ;;
    status)   cmd_status   ;;
    remove)   cmd_remove   ;;
    migrate)  cmd_migrate  ;;
    --help|-h|help) show_help ;;
    "")
        print_error "No command specified. Use --help for usage."
        exit 1
        ;;
    *)
        print_error "Unknown command: $1"
        echo "  Use --help for usage."
        exit 1
        ;;
esac

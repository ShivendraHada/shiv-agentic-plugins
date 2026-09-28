#!/bin/bash
#
# Shiv Agentic Plugins Manager for Claude Code
#
# Installs, updates, and manages Shiv plugins globally for Claude Code.
# Plugins are available across all projects without per-project installation.
#
# Usage:
#   ./install-shiv-plugins.sh install    # Install all plugins globally
#   ./install-shiv-plugins.sh update     # Update plugins from remote
#   ./install-shiv-plugins.sh list       # List installed plugins and commands
#   ./install-shiv-plugins.sh status     # Show status and detect overrides
#   ./install-shiv-plugins.sh remove     # Remove all installed plugins
#   ./install-shiv-plugins.sh migrate    # Migrate project .claude/commands/ to global
#   ./install-shiv-plugins.sh --help     # Show help
#

set -e

# Configuration
REPO_URL="${SHIV_REPO_URL:-https://github.com/shivendrahada/shiv-agentic-plugins.git}"
BRANCH="${SHIV_BRANCH:-main}"
MARKETPLACE_DIR="$HOME/.claude/plugins/marketplaces/shiv-agentic-plugins"
PLUGINS_SUBDIR="plugins"
KNOWN_MARKETPLACES="$HOME/.claude/plugins/known_marketplaces.json"

if command -v jq &> /dev/null; then
    JQ_AVAILABLE=true
else
    JQ_AVAILABLE=false
fi

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
    echo -e "${BLUE}${BOLD}Shiv Agentic Plugins Manager for Claude Code${NC}"
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
    print_info "Installing Shiv plugins globally..."
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

    if [ "$JQ_AVAILABLE" = false ]; then
        print_warning "jq not found — marketplace registration will be skipped"
        print_warning "Install jq for full functionality: brew install jq"
    fi

    # Ensure parent directory exists
    mkdir -p "$HOME/.claude/plugins/marketplaces"

    if [ -d "$MARKETPLACE_DIR/.git" ]; then
        print_info "Existing installation found. Updating..."
        cd "$MARKETPLACE_DIR"
        # Ensure .claude-plugin/ is included in sparse checkout
        git sparse-checkout set "$PLUGINS_SUBDIR/" ".claude-plugin/" 2>/dev/null
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
        git sparse-checkout set "$PLUGINS_SUBDIR/" ".claude-plugin/" 2>/dev/null
        print_success "Repository cloned with sparse checkout"
    fi

    # Create symlink for repo-name-based path resolution
    # Claude Code may resolve marketplace path from the GitHub repo name
    local repo_name_dir="$HOME/.claude/plugins/marketplaces/shivendrahada-shiv-agentic-plugins"
    if [ ! -e "$repo_name_dir" ]; then
        ln -s "$MARKETPLACE_DIR" "$repo_name_dir"
        print_success "Created symlink for repo-name resolution"
    fi

    # Register as marketplace in known_marketplaces.json
    if [ "$JQ_AVAILABLE" = true ] && [ -f "$KNOWN_MARKETPLACES" ]; then
        register_marketplace
    elif [ "$JQ_AVAILABLE" = true ]; then
        # Create the file if it doesn't exist
        echo '{}' > "$KNOWN_MARKETPLACES"
        register_marketplace
    fi

    # Install plugins into Claude Code's plugin cache and registry
    install_plugins_to_cache

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
    print_info "Run '/shiv-sync' inside Claude Code to update later."
    echo ""
}

# ─────────────────────────────────────────────
# update: Pull latest changes
# ─────────────────────────────────────────────
cmd_update() {
    print_header

    if [ ! -d "$MARKETPLACE_DIR/.git" ]; then
        print_error "Shiv plugins not installed. Run 'install' first."
        exit 1
    fi

    print_info "Updating Shiv plugins..."
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

    # Refresh plugin cache and registry
    install_plugins_to_cache

    echo ""
}

# ─────────────────────────────────────────────
# list: Show installed plugins and their contents
# ─────────────────────────────────────────────
cmd_list() {
    if [ ! -d "$MARKETPLACE_DIR/$PLUGINS_SUBDIR" ]; then
        print_error "Shiv plugins not installed. Run 'install' first."
        exit 1
    fi

    echo -e "${BOLD}Installed Shiv Agentic Plugins:${NC}"
    echo ""

    for plugin_dir in "$MARKETPLACE_DIR/$PLUGINS_SUBDIR"/shiv-*/; do
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
        print_error "Shiv plugins not installed. Run 'install' first."
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

    for plugin_dir in "$MARKETPLACE_DIR/$PLUGINS_SUBDIR"/shiv-*/; do
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
        print_info "Shiv plugins are not installed."
        return
    fi

    read -r -p "  Remove all Shiv plugins? [y/N] " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        # Remove repo-name symlink if it exists
        local repo_name_dir="$HOME/.claude/plugins/marketplaces/shivendrahada-shiv-agentic-plugins"
        [ -L "$repo_name_dir" ] && rm "$repo_name_dir" && print_success "Removed repo-name symlink"

        rm -rf "$MARKETPLACE_DIR"
        print_success "Shiv plugins removed"

        # Remove plugin cache
        rm -rf "$HOME/.claude/plugins/cache/shiv-agentic-plugins"
        print_success "Removed plugin cache"

        # Deregister plugins from installed_plugins.json
        local installed_json="$HOME/.claude/plugins/installed_plugins.json"
        if command -v jq &>/dev/null && [ -f "$installed_json" ]; then
            local tmp
            tmp=$(mktemp)
            jq '.plugins |= with_entries(select(.key | endswith("@shiv-agentic-plugins") | not))' "$installed_json" > "$tmp" && mv "$tmp" "$installed_json"
            print_success "Deregistered plugins from installed list"
        fi

        # Deregister from known_marketplaces.json
        if command -v jq &>/dev/null && [ -f "$KNOWN_MARKETPLACES" ]; then
            local tmp
            tmp=$(mktemp)
            jq 'del(."shiv-agentic-plugins")' "$KNOWN_MARKETPLACES" > "$tmp" && mv "$tmp" "$KNOWN_MARKETPLACES"
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
        print_error "Shiv plugins not installed. Run 'install' first."
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

    for plugin_dir in "$MARKETPLACE_DIR/$PLUGINS_SUBDIR"/shiv-*/commands/; do
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
# Helper: Install plugins into Claude Code cache and registry
# ─────────────────────────────────────────────
install_plugins_to_cache() {
    local cache_dir="$HOME/.claude/plugins/cache/shiv-agentic-plugins"
    local installed_json="$HOME/.claude/plugins/installed_plugins.json"
    local now
    now=$(date -u +"%Y-%m-%dT%H:%M:%S.000Z")

    # Ensure installed_plugins.json exists
    if [ ! -f "$installed_json" ]; then
        echo '{"version":2,"plugins":{}}' > "$installed_json"
    fi

    echo ""
    print_info "Registering plugins with Claude Code..."

    for plugin_dir in "$MARKETPLACE_DIR/$PLUGINS_SUBDIR"/shiv-*/; do
        [ -d "$plugin_dir" ] || continue
        local plugin_name
        plugin_name=$(basename "$plugin_dir")

        # Read version from marketplace.json, default to 1.0.0
        local version="1.0.0"
        local marketplace_json="$MARKETPLACE_DIR/.claude-plugin/marketplace.json"
        if [ -f "$marketplace_json" ] && [ "$JQ_AVAILABLE" = true ]; then
            local v
            v=$(jq -r --arg name "$plugin_name" '.plugins[] | select(.name == $name) | .version // "1.0.0"' "$marketplace_json" 2>/dev/null)
            [ -n "$v" ] && version="$v"
        fi

        # Copy plugin to cache
        local plugin_cache="$cache_dir/$plugin_name/$version"
        mkdir -p "$plugin_cache"
        rsync -a --delete "$plugin_dir" "$plugin_cache/"
        print_success "Cached $plugin_name@$version"

        # Register in installed_plugins.json
        if [ "$JQ_AVAILABLE" = true ]; then
            local key="${plugin_name}@shiv-agentic-plugins"
            local tmp
            tmp=$(mktemp)
            jq --arg key "$key" \
               --arg path "$plugin_cache" \
               --arg ver "$version" \
               --arg now "$now" \
               '.plugins[$key] = [{
                    "scope": "user",
                    "installPath": $path,
                    "version": $ver,
                    "installedAt": $now,
                    "lastUpdated": $now,
                    "isLocal": true
                }]' "$installed_json" > "$tmp" && mv "$tmp" "$installed_json"
        fi
    done

    print_success "All plugins registered with Claude Code"
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
        '."shiv-agentic-plugins" = {
            "source": {
                "source": "github",
                "repo": "shivendrahada/shiv-agentic-plugins"
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
  Usage: install-shiv-plugins.sh <command>

  Commands:
    install    Install Shiv plugins globally for Claude Code
    update     Update plugins to the latest version
    list       List all installed plugins, commands, skills, and agents
    status     Show version info and detect local overrides
    remove     Uninstall all Shiv plugins
    migrate    Remove local .claude/commands/ files that are identical to global

  Options:
    --help     Show this help message

  Environment Variables:
    SHIV_REPO_URL   Override repository URL
    SHIV_BRANCH     Override branch (default: main)

  Examples:
    # First-time setup
    ./install-shiv-plugins.sh install

    # Check for updates
    ./install-shiv-plugins.sh update

    # See what's installed
    ./install-shiv-plugins.sh list

    # Clean up a project that had per-project commands
    cd my-project && /path/to/install-shiv-plugins.sh migrate

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

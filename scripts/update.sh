#!/usr/bin/env bash
# update.sh — sync dotfiles from the live system into this repo
# Run this whenever you want to snapshot your current config state.
# After running, use git diff/add/commit to save what changed.

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_DIR="$HOME"
CONFIG_SRC="$HOME_DIR/.config"
CONFIG_DST="$REPO/.config"

GREEN='\033[0;32m'
CYAN='\033[0;36m'
RESET='\033[0m'

log() { echo -e "${CYAN}=>${RESET} $*"; }
ok()  { echo -e "${GREEN}✓${RESET} $*"; }

echo ""
echo "Updating dotfiles backup in: $REPO"
echo "Source: $HOME_DIR"
echo ""

# rsync helper — copies src into dst, preserving structure, deleting removed files
sync_dir() {
    local src="$1"
    local dst="$2"
    local label="$3"
    if [ -d "$src" ]; then
        log "$label"
        rsync -a --delete "$src/" "$dst/"
        ok "Done"
    else
        echo "  Skipped (not found): $src"
    fi
}

sync_file() {
    local src="$1"
    local dst="$2"
    local label="$3"
    if [ -f "$src" ]; then
        log "$label"
        cp "$src" "$dst"
        ok "Done"
    else
        echo "  Skipped (not found): $src"
    fi
}

# ---------------------------------------------------------------------------
# Hyprland + Dank Linux ecosystem
# ---------------------------------------------------------------------------
sync_dir  "$CONFIG_SRC/hypr"             "$CONFIG_DST/hypr"             ".config/hypr"
sync_dir  "$CONFIG_SRC/DankMaterialShell" "$CONFIG_DST/DankMaterialShell" ".config/DankMaterialShell"
sync_dir  "$CONFIG_SRC/quickshell"       "$CONFIG_DST/quickshell"       ".config/quickshell"
sync_dir  "$CONFIG_SRC/danksearch"       "$CONFIG_DST/danksearch"       ".config/danksearch"
sync_dir  "$CONFIG_SRC/dgop"             "$CONFIG_DST/dgop"             ".config/dgop"

# ---------------------------------------------------------------------------
# Terminals
# ---------------------------------------------------------------------------
sync_dir  "$CONFIG_SRC/alacritty"        "$CONFIG_DST/alacritty"        ".config/alacritty"
sync_dir  "$CONFIG_SRC/ghostty"          "$CONFIG_DST/ghostty"          ".config/ghostty"

# ---------------------------------------------------------------------------
# Shell
# ---------------------------------------------------------------------------
sync_dir  "$CONFIG_SRC/fish"             "$CONFIG_DST/fish"             ".config/fish"
sync_file "$CONFIG_SRC/starship.toml"    "$CONFIG_DST/starship.toml"    ".config/starship.toml"

# ---------------------------------------------------------------------------
# Editors
# ---------------------------------------------------------------------------
sync_dir  "$CONFIG_SRC/zed"              "$CONFIG_DST/zed"              ".config/zed"

# Micro: only sync user config, skip built-in syntax files (668K, not user config)
mkdir -p "$CONFIG_DST/micro/colorschemes"
log ".config/micro (user config only)"
[ -f "$CONFIG_SRC/micro/bindings.json" ] && cp "$CONFIG_SRC/micro/bindings.json" "$CONFIG_DST/micro/"
[ -f "$CONFIG_SRC/micro/settings.json" ] && cp "$CONFIG_SRC/micro/settings.json" "$CONFIG_DST/micro/"
[ -d "$CONFIG_SRC/micro/colorschemes"  ] && rsync -a --delete "$CONFIG_SRC/micro/colorschemes/" "$CONFIG_DST/micro/colorschemes/"
ok "Done"

# ---------------------------------------------------------------------------
# System tools
# ---------------------------------------------------------------------------
sync_dir  "$CONFIG_SRC/btop"             "$CONFIG_DST/btop"             ".config/btop"
sync_dir  "$CONFIG_SRC/cava"             "$CONFIG_DST/cava"             ".config/cava"

# ---------------------------------------------------------------------------
# Theming + GTK
# ---------------------------------------------------------------------------
sync_dir  "$CONFIG_SRC/gtk-3.0"          "$CONFIG_DST/gtk-3.0"          ".config/gtk-3.0"
sync_dir  "$CONFIG_SRC/gtk-4.0"          "$CONFIG_DST/gtk-4.0"          ".config/gtk-4.0"

# ---------------------------------------------------------------------------
# CachyOS + system
# ---------------------------------------------------------------------------
sync_dir  "$CONFIG_SRC/cachyos"          "$CONFIG_DST/cachyos"          ".config/cachyos"
sync_dir  "$CONFIG_SRC/environment.d"    "$CONFIG_DST/environment.d"    ".config/environment.d"
sync_dir  "$CONFIG_SRC/autostart"        "$CONFIG_DST/autostart"        ".config/autostart"
sync_file "$CONFIG_SRC/mimeapps.list"    "$CONFIG_DST/mimeapps.list"    ".config/mimeapps.list"

# ---------------------------------------------------------------------------
# Home dotfiles
# ---------------------------------------------------------------------------
for f in .bashrc .bash_profile .bash_logout .profile .zshrc .gitconfig; do
    sync_file "$HOME_DIR/$f" "$REPO/$f" "~/$f"
done

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
echo ""
echo -e "${GREEN}Backup updated.${RESET}"
echo ""
echo "Review changes:"
echo "  cd $REPO && git diff"
echo "  git add -p && git commit -m 'chore: update dotfiles'"
echo ""

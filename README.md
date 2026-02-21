# kristijan-dotfiles

Personal dotfiles for my CachyOS setup running [Dank Linux (DankMaterialShell)](https://danklinux.com) on Hyprland.

## System

| | |
|---|---|
| **OS** | [CachyOS](https://cachyos.org) (Arch-based) |
| **Kernel** | CachyOS (performance-optimized) |
| **WM** | [Niri](https://github.com/YaLTeR/niri) (primary), [Hyprland](https://hyprland.org) |
| **Shell (desktop)** | [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell) |
| **Shell (terminal)** | Fish + Starship |
| **Terminals** | Ghostty, Alacritty |
| **Editors** | Zed, Micro |

## Structure

The repo mirrors the home directory layout, so paths map 1:1:

```
kristijan-dotfiles/
├── .bashrc / .bash_profile / .bash_logout / .profile
├── .zshrc
├── .gitconfig
└── .config/
    ├── niri/                  # Niri WM config + DMS bindings
    ├── hypr/                  # Hyprland WM config + DMS bindings
    ├── DankMaterialShell/     # Dank Linux shell (settings, themes, plugins)
    ├── quickshell/            # Quickshell config
    ├── danksearch/            # Dank Linux search tool
    ├── dgop/                  # Dank Linux CPU metrics tool
    ├── ghostty/               # Ghostty terminal
    ├── alacritty/             # Alacritty terminal
    ├── fish/                  # Fish shell config
    ├── starship.toml          # Starship prompt
    ├── zed/                   # Zed editor settings
    ├── micro/                 # Micro editor (bindings, settings, colorschemes)
    ├── btop/                  # System monitor
    ├── cava/                  # Audio visualizer (shaders + themes)
    ├── gtk-3.0/ gtk-4.0/      # GTK theming (Dank-generated colors)
    ├── cachyos/               # CachyOS package list + hello config
    ├── environment.d/         # Environment variables (DMS)
    ├── autostart/             # XDG autostart entries
    └── mimeapps.list          # File type associations
```

## Updating the backup


 Run `./scripts/update.sh`  to sync the latest configs into this repo.
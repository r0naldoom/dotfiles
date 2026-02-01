<h1 align="center">Noble Noctalia</h1>

<p align="center">
  <b>Hyprland</b> rice with <b>Noctalia Shell</b> &mdash; 4 themes, one unified desktop.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=flat&logo=archlinux&logoColor=white" alt="Arch Linux"/>
  <img src="https://img.shields.io/badge/Hyprland-58E1FF?style=flat&logo=hyprland&logoColor=black" alt="Hyprland"/>
  <img src="https://img.shields.io/badge/Wayland-FFBC00?style=flat&logo=wayland&logoColor=black" alt="Wayland"/>
  <img src="https://img.shields.io/badge/dotdrop-managed-d4be98?style=flat" alt="dotdrop"/>
</p>

---

<p align="center">
  <img src="assets/noble-noctalia.png" width="100%" alt="Desktop overview"/>
</p>

<details>
<summary><b>Calendar & Weather</b></summary>
<br>
<img src="assets/noble-noctalia-calendar.png" width="100%" alt="Calendar widget"/>
</details>

<details>
<summary><b>Launcher</b></summary>
<br>
<img src="assets/noble-noctalia-launcher.png" width="100%" alt="App launcher"/>
</details>

<details>
<summary><b>Color Schemes</b></summary>
<br>
<img src="assets/noble-noctalia-panel.png" width="100%" alt="Color scheme panel"/>
</details>

---

### Components

| | Component | Name |
|---|---|---|
| WM | Window Manager | [Hyprland](https://hyprland.org) |
| SH | Shell | [Noctalia Shell](https://github.com/nicobuss/quickshell-config-noctalia) (QuickShell) |
| TM | Terminal | [Ghostty](https://ghostty.org) |
| ED | Editor | [Neovim](https://neovim.io) (LazyVim) |
| SH | Shell | [Fish](https://fishshell.com) |
| MX | Multiplexer | [tmux](https://github.com/tmux/tmux) |
| FM | File Manager | [Yazi](https://yazi-rs.github.io) |
| LC | Launcher | [Rofi](https://github.com/davatorium/rofi) |
| FT | Font | JetBrains Mono Nerd Font |

### Themes

All apps sync to a single color scheme via `noctalia-theme-sync`.

| Theme | Primary | Preview |
|---|---|---|
| **Gruvbox Material** | `#d8a657` | Default |
| **Everforest** | `#A7C080` | Top-right |
| **Tokyo Night** | `#bb9af7` | Bottom-left |
| **EfCherie** | `#ef80bf` | Bottom-right |

### Setup

Configs are managed with [dotdrop](https://github.com/deadc0de6/dotdrop).

```bash
git clone https://github.com/r0naldoom/dotfiles.git
cd dotfiles

# preview what will be installed
dotdrop compare -p r0naldoom

# install
dotdrop install -p r0naldoom
```

### Keybindings

| Key | Action |
|---|---|
| `Super + T` | Terminal |
| `Super + A` | Launcher |
| `Super + B` | Browser |
| `Super + E` | File manager |
| `Super + Q` | Kill window |
| `Super + H/J/K/L` | Focus (vim-style) |
| `Super + 1-9` | Workspaces |
| `Ctrl + Space` | tmux prefix |

---

<p align="center">
  <sub>r0naldoom &copy; 2026</sub>
</p>

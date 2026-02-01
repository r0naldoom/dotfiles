# Auto-tmux
if not set -q TMUX; and not set -q NOTMUX
    set -l session_name "term-"(date +%s)
    exec tmux new-session -s $session_name
end

# Vi mode
fish_vi_key_bindings

# XDG
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx LESSHISTFILE /tmp/less-hist

# PATH
fish_add_path -p ~/.local/bin
fish_add_path -p ~/scripts
if test -d ~/.local/share/fnm
    fish_add_path -p ~/.local/share/fnm
end

# Environment
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx LIBVIRT_DEFAULT_URI "qemu:///system"
set -gx DOCKER_HOST "unix://$XDG_RUNTIME_DIR/podman/podman.sock"

# Python / UV
set -gx PYTHONDONTWRITEBYTECODE 1
set -gx PYTHONIOENCODING utf-8
set -gx UV_PYTHON_PREFERENCE system

# FZF
set -gx FZF_CTRL_T_OPTS "--preview 'bat --style=numbers --color=always {} || cat {}'"
fzf --fish | source

# Starship
set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/starship.toml
set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
starship init fish | source

# Zoxide
zoxide init fish | source

# Aliases - Neovim
alias v 'env NVIM_APPNAME=nvim-lazy nvim'
alias vv 'env NVIM_APPNAME=nvim-vanilla nvim'
alias vd 'env NVIM_APPNAME=nvim-dotnet nvim'
alias vm 'env NVIM_APPNAME=nvim-minimal nvim'

# Aliases - eza
alias l 'eza -lh --icons=auto'
alias ls 'eza -1 --icons=auto'
alias ll 'eza -lha --icons=auto --sort=name --group-directories-first'
alias ld 'eza -lhD --icons=auto'
alias lt 'eza --icons=auto --tree'

# Aliases - Common
alias mkdir 'mkdir -p'
alias cat bat

# Abbreviations - expand visually before running
abbr -a g git
abbr -a gs 'git status -sb'
abbr -a gl 'git log --oneline --graph -20'

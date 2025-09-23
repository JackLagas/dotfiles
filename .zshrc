
# Set home directory for zinit

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download and install zinit if it isn't already installed

if [ ! -d "${ZINIT_HOME}" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit

source "${ZINIT_HOME}/zinit.zsh"

# Load plugins

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add snippets

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found



# Load completions

autoload -U compinit && compinit

zinit cdreplay -q


export GOPATH=$HOME/go
export PATH=$HOME/.local/bin:$HOME/go/bin:$PATH
export PATH="/home/jack/.deno/bin:$PATH"

export TWEEGO_PATH=$HOME/.tweego/


# Load Oh-My-Posh

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/conf.toml)"

# Set default values

export EDITOR=nvim

# Yazi

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# fzf Theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# zsh-syntax-highlighting Theme
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Keybinds 

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases

alias ls='ls --color'
alias protontricks='flatpak run com.github.Matoking.protontricks'

# Shell integrations

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# pnpm
export PNPM_HOME="/home/jack/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# Private configs
if [ -f $HOME/.zsh/private.zsh ]; then
    source $HOME/.zsh/private.zsh
fi

export LM_LICENSE_FILE="/home/jack/Repositories/pokeplatinum/tools/cw/license.dat"

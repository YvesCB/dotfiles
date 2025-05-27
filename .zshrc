# ===BASIC ZSH SETUP===
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

ZSH_THEME="robbyrussell"

source <(fzf --zsh)

plugins=(
  git
  zsh-autosuggestions
  zsh-fzf-history-search
  zsh-syntax-highlighting
)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

# ===PATH AND ENVIRONMENT===
export PATH=$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$HOME/.local/bin/:$PATH

# LOADING NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR=nvim
export VISUAL=nvim

# ibus stuff
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# ===ALIASES AND CUSTOM FUNCTIONS===
alias v=nvim
alias lz=lazygit

alias pacs="pacman -Ss"
alias yays="yay -Ss"

alias fp="fzf --preview='bat --color=always --style=numbers {}'"
alias tldr="tldr -t ocean"

alias ls="eza --color=auto --icons=auto"
alias ll="eza --color=auto --icons=auto --long"
alias lt="eza --color=auto --icons=auto --tree --level=3"

# kitty ssh fix
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh" 

# Wrapper for yazi that will change cwd when exiting yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Setting up zoxide
eval "$(zoxide init --cmd cd zsh)"

nerdfetch

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# pnpm
export PNPM_HOME="/home/yves/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/snap/bin:$HOME/.cargo/bin:$HOME/.local/bin/:$HOME/.config/qtile/:/usr/bin/gradle/gradle-8.6/bin/:$PATH

# Loading nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export EDITOR=nvim
export VISUAL=nvim

alias v=nvim
alias lz=lazygit

alias pacs="pacman -Ss"
alias yays="yay -Ss"

# ibus stuff
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

alias fp="fzf --preview='bat --color=always --style=numbers {}'"
alias tldr="tldr -t ocean"

ZSH_THEME="robbyrussell"

source <(fzf --zsh)

plugins=(
  git
  zsh-autosuggestions
  zsh-fzf-history-search
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

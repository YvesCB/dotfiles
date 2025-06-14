# My dotfiles
## Setup
1. Clone into home directory
2. Install zsh.
3. Install oh-my-zsh. `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
From [ohmyz.sh](https://ohmyz.sh/#install). Additionally install zsh-autosuggestions plugin.
4. Install tmux.
5. Install stow and enter the dotfiles directory. Execute `stow .` or `stow . --adopt`.

## Neovim
This contains my complete Neovim config. It is partially based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
It is meant to be used with nvim v0.11 or above.

### Requirements
Not much is needed but there is one plugin (hexokinase) that relies on a go compiler
being installed.


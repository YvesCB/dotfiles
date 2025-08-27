# My dotfiles
## Setup
1. Clone into home directory
2. Run the install.sh to install core packages (tmux, zsh, ...) and zsh plugins (might add more things to script later)
3. Execute `stow <package>` to symlink whatever is in the package into the parent directory.

## Neovim
This contains my complete Neovim config. It is partially based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
It is meant to be used with nvim v0.12 or above and tries to stay minimal but with qol things that I like.

### Requirements
Not much is needed but there is one plugin (hexokinase) that relies on a go compiler
being installed.


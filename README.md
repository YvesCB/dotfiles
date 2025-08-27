# My dotfiles
## Setup
1. Clone into home directory
2. Install oh-my-zsh. `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
From [ohmyz.sh](https://ohmyz.sh/#install). Additionally install zsh-autosuggestions plugin.
3. Run the install.sh to install core packages (tmux, zsh, ...) and zsh plugins (might add more things to script later)
4. Execute `stow <package>` to symlink whatever is in the package into the parent directory.

## Neovim
This contains my complete Neovim config. It is partially based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
It is meant to be used with nvim v0.12 or above and tries to stay minimal but with qol things that I like.

### Requirements
Not much is needed but there is one plugin (hexokinase) that relies on a go compiler
being installed.


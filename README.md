# My dotfiles
## Setup
1. Clone as .config
2. Install zsh and set as user shell `chsh -s $(which zsh)` (if this doesn't work 
because zsh links to `/usr/sbin/` then you can just provide the full path in 
`/usr/bin/zsh` to `chsh`)
3. Install oh-my-zsh. `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
From [ohmyz.sh](https://ohmyz.sh/#install). Additionally install zsh-autosuggestions plugin.
4. Add `ZDOTDIR=~/.config` to `~/.zshenv` so that zsh will source it properly
5. Install tmux.

## Neovim
This contains my complete Neovim config. It is partially based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
It also contains some features that only work on the nightly version of neovim 
(10.0.0) at the time of writing this. Though the config should work pretty much 
in its entirety on v0.9 as well.

### Requirements
Not much is needed but there is one plugin (hexokinase) that relies on a go compiler
being installed.

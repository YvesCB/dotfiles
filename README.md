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
It is meant to be used with nvim v0.10 or above.

### Requirements
Not much is needed but there is one plugin (hexokinase) that relies on a go compiler
being installed.

## Qtile
To setup the WLAN widget, make sure that `libiw-dev` is installed on Ubuntu/Debian.
Then make sure to install `iwlib` with `pip`.
The Memory widget requires `psutil` from `pip`.

### Addons
I'm currently using a very simple [power menu by Github user Pyntux](https://github.com/Pyntux/wm_power_menu) which is then just bound to a key. The script is in the qtile folder of this config. Make sure it's executable. Make sure that `$HOME/.config/qtile/` is in the path.

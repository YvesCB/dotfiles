#!/bin/sh
set -euo pipefail

LOGFILE="${LOGFILE:-install.log}"

log() { printf '[%s] %s\n' "$(date +'%F %T')" "$*" | tee -a "$LOGFILE"; }
die() { log "ERROR: $*"; exit 1; }

# --- packages we need ---
PKGS=(
	tmux
	zsh
	neovim
	fzf
	yazi
	kitty
	lazygit
	mpv
	zathura
	git
	ffmpeg
	jq
	zoxide
	starship
	eza
	nerdfetch
  stow
)

# ---- sanity checks ----
[[ -f /var/lib/pacman/db.lck ]] && die "pacman appears to be running (db.lck present). Try again later."

if ! ping -c1 -W2 archlinux.org >/dev/null 2>&1; then
  die "No network connectivity. Connect to the internet and retry."
fi

# ---- require root or elevate ----
if [[ $EUID -ne 0 ]]; then
  if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
  else
    die "This script needs root. Install sudo or run as root."
  fi
else
  SUDO=""
fi

# ---- full sync + upgrade (noninteractive) ----
log "Synchronizing package databases and upgrading system…"
$SUDO pacman -Syu --noconfirm | tee -a "$LOGFILE"

# ---- install packages (idempotent) ----
log "Installing packages: ${PKGS[*]}"
$SUDO pacman -S --needed --noconfirm "${PKGS[@]}" | tee -a "$LOGFILE"

log "Installing oh-my-zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

log "Installing zsh plugins."

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

log "All done."


#!/bin/sh
set -euo pipefail

LOGFILE="${LOGFILE:-install.log}"

log() { printf '[%s] %s\n' "$(date +'%F %T')" "$*" | tee -a "$LOGFILE"; }
die() { log "ERROR: $*"; exit 1; }

# --- packages we need ---
PKGS=(
  base-devel
  bat         # Modern replacement for cat
  caligula    # CLI utilty for burning ISOs to drives
  eza         # Modern replacement for ls
  ffmpeg
  fzf
  go
  jq          # CLI utilty for working with json
  kitty
  lazygit     # TUI for git
  mpv
  neovim
  openresolv  # Dependancy for wg-quick
  ripgrep
  starship    # CLI prompt
  stow
  tmux
  typst
  uv          # Fast python package manager
  wireguard-tools
  yazi        # TUI file browser with image support
  zathura
  zoxide      # Modern replacement for cd
  zsh
)

AUR_PKGS=(
  nerdfetch
  lazyssh-bin
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

# ---- ensure yay is installed ----
if ! command -v yay >/dev/null 2>&1; then
  log "yay not found — bootstrapping yay from AUR…"
  $SUDO pacman -S --needed --noconfirm git base-devel | tee -a "$LOGFILE"
  tmpdir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay" | tee -a "$LOGFILE"
  pushd "$tmpdir/yay" >/dev/null
  makepkg -si --noconfirm | tee -a "$LOGFILE"
  popd >/dev/null
  rm -rf "$tmpdir"
  log "yay installed successfully."
else
  log "yay already installed."
fi

# ---- install packages (idempotent) ----
log "Installing packages: ${PKGS[*]}"
$SUDO pacman -S --needed --noconfirm "${PKGS[@]}" | tee -a "$LOGFILE"

# ---- install AUR packages ----
if [[ ${#AUR_PKGS[@]} -gt 0 ]]; then
  log "Installing AUR packages: ${AUR_PKGS[*]}"
  yay -S --needed --noconfirm "${AUR_PKGS[@]}" | tee -a "$LOGFILE"
fi

# ---- install oh-my-zsh and plugins (as the real user, unattended) ----
log "Installing oh-my-zsh and plugins"

# Determine the target user/home (handles running the script via sudo)
TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"

# Environment for unattended install
OMZ_ENV="RUNZSH=no CHSH=no KEEP_ZSHRC=yes"
OMZ_DIR="$TARGET_HOME/.oh-my-zsh"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$OMZ_DIR/custom}"

# Install oh-my-zsh if missing
if [[ ! -d "$OMZ_DIR" ]]; then
  log "oh-my-zsh not found; installing to $OMZ_DIR"
  sudo -u "$TARGET_USER" env HOME="$TARGET_HOME" ZDOTDIR="$TARGET_HOME" $OMZ_ENV \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  log "oh-my-zsh already present at $OMZ_DIR"
fi

# Ensure custom dir exists
sudo -u "$TARGET_USER" mkdir -p "$ZSH_CUSTOM_DIR/plugins"

# Install plugins (idempotent clones)
install_plugin () {
  local repo="$1" dest="$2"
  if sudo -u "$TARGET_USER" test -d "$dest/.git"; then
    log "Updating $(basename "$dest")"
    sudo -u "$TARGET_USER" git -C "$dest" pull --ff-only || true
  elif [[ ! -d "$dest" ]]; then
    log "Cloning $(basename "$dest")"
    sudo -u "$TARGET_USER" git clone --depth=1 "$repo" "$dest"
  else
    log "Skipping $(basename "$dest") (exists but not a git repo)"
  fi
}

install_plugin https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"

install_plugin https://github.com/joshskidmore/zsh-fzf-history-search \
  "$ZSH_CUSTOM_DIR/plugins/zsh-fzf-history-search"

install_plugin https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"

log "oh-my-zsh setup complete (remember to enable plugins in ~/.zshrc)"

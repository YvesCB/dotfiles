#!/usr/bin/env bash
set -euo pipefail

LOGFILE="${LOGFILE:-install.log}"

log() { printf '[%s] %s\n' "$(date +'%F %T')" "$*" | tee -a "$LOGFILE"; }
die() { log "ERROR: $*"; exit 1; }

# --- packages we need from Fedora repos ---
PKGS=(
  # basics & tooling
  git
  curl
  tmux
  zsh
  neovim
  fzf
  ripgrep
  jq
  stow
  # starship
  # eza
  zoxide
  golang         # 'go' on Arch => 'golang' on Fedora

  # terminal & apps
  kitty
  # lazygit
  mpv
  # zathura
  # zathura-pdf-mupdf

  # from RPM Fusion (enabled below)
  # ffmpeg
)

# A few things live better via COPR or may be missing in base repos
COPR_ENABLE=()   # yazi lives here on Fedora
COPR_PKGS=()

# Optional / “best-effort” packages — try to install, skip on failure
 OPTIONAL_PKGS=(
#   nerdfetch       # may exist in your repos; if not, we’ll skip
 )

# ---- sanity checks ----
# rudimentary RPM/DNF lock check
if fuser /var/lib/rpm/.rpm.lock >/dev/null 2>&1; then
  die "RPM database appears locked. Another package operation may be running."
fi

# network
if ! ping -c1 -W2 fedoraproject.org >/dev/null 2>&1; then
  die "No network connectivity. Connect to the internet and retry."
fi

# ---- require root or elevate ----
if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
  else
    die "This script needs root. Install sudo or run as root."
  fi
else
  SUDO=""
fi

# ---- full sync + upgrade (noninteractive) ----
log "Refreshing metadata and upgrading system…"
$SUDO dnf -y upgrade --refresh | tee -a "$LOGFILE"

# ---- enable RPM Fusion (needed for ffmpeg, etc.) ----
enable_rpmfusion() {
  if rpm -q rpmfusion-free-release >/dev/null 2>&1 && rpm -q rpmfusion-nonfree-release >/dev/null 2>&1; then
    log "RPM Fusion already enabled."
    return
  fi
  local rel; rel="$(rpm -E %fedora)"
  log "Enabling RPM Fusion (Free & Nonfree) for Fedora $rel…"
  $SUDO dnf -y install \
    "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${rel}.noarch.rpm" \
    "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${rel}.noarch.rpm" \
    | tee -a "$LOGFILE"

  # After adding repos, refresh once
  $SUDO dnf -y upgrade --refresh | tee -a "$LOGFILE"
}
enable_rpmfusion

# ---- ensure dnf-plugins-core (for COPR) ----
log "Ensuring dnf-plugins-core is installed…"
$SUDO dnf -y install dnf-plugins-core | tee -a "$LOGFILE"

# ---- enable COPRs ----
for copr in "${COPR_ENABLE[@]}"; do
  if ! $SUDO dnf copr list --enabled 2>/dev/null | grep -q -F "$copr"; then
    log "Enabling COPR: $copr"
    # shellcheck disable=SC2086
    $SUDO dnf -y copr enable $copr | tee -a "$LOGFILE" || log "WARN: Failed to enable COPR $copr (continuing)"
  else
    log "COPR already enabled: $copr"
  fi
done

# ---- install Packages ----
log "Installing packages: ${PKGS[*]}"
# shellcheck disable=SC2068
$SUDO dnf -y install ${PKGS[@]} | tee -a "$LOGFILE"

if ((${#COPR_PKGS[@]})); then
  log "Installing COPR packages: ${COPR_PKGS[*]}"
  # shellcheck disable=SC2068
  $SUDO dnf -y install ${COPR_PKGS[@]} | tee -a "$LOGFILE"
fi

# ---- optional: best-effort installs (skip if missing) ----
if ((${#OPTIONAL_PKGS[@]})); then
  for p in "${OPTIONAL_PKGS[@]}"; do
    log "Attempting to install optional package: $p"
    if ! $SUDO dnf -y install "$p" >>"$LOGFILE" 2>&1; then
      log "WARN: Optional package '$p' not available; skipping."
    fi
  done
fi

# ---- install Development Tools group (rough 'base-devel' equivalent) ----
log "Ensuring Development Tools are installed…"
$SUDO dnf -y groupinstall "Development Tools" | tee -a "$LOGFILE"

# ---- install oh-my-zsh and plugins (as the real user, unattended) ----
log "Installing oh-my-zsh and plugins"

# Determine the target user/home (handles sudo)
TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"
if [[ -z "${TARGET_HOME:-}" || ! -d "$TARGET_HOME" ]]; then
  die "Could not determine home directory for user '$TARGET_USER'."
fi

OMZ_ENV=(RUNZSH=no CHSH=no KEEP_ZSHRC=yes)
OMZ_DIR="$TARGET_HOME/.oh-my-zsh"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$OMZ_DIR/custom}"

# Install oh-my-zsh if missing
if [[ ! -d "$OMZ_DIR" ]]; then
  log "oh-my-zsh not found; installing to $OMZ_DIR"
  sudo -u "$TARGET_USER" env HOME="$TARGET_HOME" ZDOTDIR="$TARGET_HOME" "${OMZ_ENV[@]}" \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  log "oh-my-zsh already present at $OMZ_DIR"
fi

# Ensure custom dir exists
sudo -u "$TARGET_USER" mkdir -p "$ZSH_CUSTOM_DIR/plugins"

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

install_plugin "https://github.com/zsh-users/zsh-autosuggestions" \
  "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"

install_plugin "https://github.com/joshskidmore/zsh-fzf-history-search" \
  "$ZSH_CUSTOM_DIR/plugins/zsh-fzf-history-search"

install_plugin "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
  "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"

log "oh-my-zsh setup complete (remember to enable plugins in ~/.zshrc)"

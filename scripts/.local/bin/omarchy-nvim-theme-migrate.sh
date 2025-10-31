#!/usr/bin/env bash
set -Eeuo pipefail

usage() {
  echo "Usage: $0 <input_dir> <output_dir>"
  echo "Copies *.lua from input_dir to output_dir."
  echo "Before copying, lists *.lua in output_dir and asks permission to DELETE them."
}

# --- Parse args ---
if (( $# != 2 )); then
  usage >&2
  exit 1
fi

IN="$1"
OUT="$2"

# --- Validate dirs ---
if [[ ! -d "$IN" ]]; then
  echo "Error: input_dir '$IN' does not exist or is not a directory." >&2
  exit 1
fi

if [[ ! -d "$OUT" ]]; then
  echo "Error: output_dir '$OUT' does not exist." >&2
  exit 1
fi

# Prevent dangerous no-op or self-targeting
if [[ "$(realpath -m -- "$IN")" == "$(realpath -m -- "$OUT")" ]]; then
  echo "Error: input_dir and output_dir must be different." >&2
  exit 1
fi

# --- List and confirm deletion of existing *.lua in OUT ---
echo "Current .lua files in '$OUT' (up to depth 2):"
if ! find "$OUT" -maxdepth 2 -type f -name '*.lua' -printf '  %P\n' | grep -q .; then
  echo "  (none)"
else
  # Reprint actual list for clarity
  find "$OUT" -maxdepth 2 -type f -name '*.lua' -printf '  %P\n'
fi

echo
read -r -p "Proceed to copy and overwrite any matching *.lua in '$OUT'? [y/N] " confirm
[[ "$confirm" =~ ^[Yy]$ ]] || { echo "Aborting."; exit 0; }
# --- Ensure there is something to copy ---
if ! find "$IN" -maxdepth 2 -type f -name '*.lua' -print -quit | grep -q .; then
  echo "No *.lua files found in '$IN'. Nothing to do."
  exit 0
fi

# --- Copy (overwrite to ensure latest) ---
copied=0
while IFS= read -r -d '' file; do
  cp -f -- "$file" "$OUT"/
  ((copied++))
done < <(find "$IN" -maxdepth 2 -type f -name '*.lua' -print0)

echo "Copied $copied *.lua file(s) from '$IN' to '$OUT'."

#!/bin/bash

# Directory containing the wallpapers and their thumbnails
IMAGE_DIR="$HOME/Pictures/wallpapers"
THUMBNAIL_DIR="$HOME/Pictures/wallpapers/thumbnails"  # Thumbnails should match the wallpapers' filenames
if [[ -z "$THUMBNAIL_DIR" || ! -d "$THUMBNAIL_DIR" ]]; then
    notify-send "Error: Please provide a valid thumbnail directory."
fi

# Configuration variables
HYPRPAPER_CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"
HYPRLOCK_CONFIG_FILE="$HOME/.config/hypr/hyprlock.conf"

# Find all images in IMAGE_DIR
wallpapers=($(find "$THUMBNAIL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \)))
wallpaper_names=("${wallpapers[@]##*/}")  # Get only the file names for display

# Create input for wofi with icons
wofi_input=""
for i in "${!wallpapers[@]}"; do
    # Build each entry with basename and icon metadata for wofi
    wofi_input+="img:${wallpapers[i]}:text:${wallpaper_names[i]}\n"
done

# Display wofi menu and capture the selected wallpaper
selected_wallpaper=$(echo -e "$wofi_input" | wofi -i --dmenu --allow-images -p "Select Wallpaper")

selected_wallpaper=$(echo $selected_wallpaper | sed -n 's/.*:text:\(.*\)/\1/p')

# If no selection is made, exit
if [ -z "$selected_wallpaper" ]; then
    echo "No wallpaper selected."
    exit 1
fi

# Find the full path of the selected wallpaper by matching its basename
selected_path=$(find "$IMAGE_DIR" -maxdepth 1 -type f -name "$selected_wallpaper")

# Update the wallpaper path in the config file
sed -i "s|^\(preload = \).*|\1$selected_path|" "$HYPRPAPER_CONFIG_FILE"
sed -i "s|^\(wallpaper = \).*|\1,$selected_path|" "$HYPRPAPER_CONFIG_FILE"
sed -i "s|^\(\$lockscreen = \).*|\1$selected_path|" "$HYPRLOCK_CONFIG_FILE"

killall hyprpaper
hyprctl dispatch exec hyprpaper

notify-send "Wallpaper set to $selected_wallpaper"

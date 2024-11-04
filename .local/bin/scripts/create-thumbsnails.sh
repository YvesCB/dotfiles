#!/bin/zsh

# Function to display usage
usage() {
    echo "Usage: $0 --source-dir <directory> | -s <directory>"
    exit 1
}

# Check for required tools
if ! command -v convert &> /dev/null; then
    echo "Error: The 'convert' command from ImageMagick is not installed. Please install it to use this script."
    exit 1
fi

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --source-dir|-s) SOURCE_DIR="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; usage ;;
    esac
    shift
done

# Validate source directory
if [[ -z "$SOURCE_DIR" || ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Please provide a valid source directory."
    usage
fi

# Set target directory for thumbnails
THUMBNAIL_DIR="$SOURCE_DIR/thumbnails"

# Create the thumbnail directory if it doesn't exist
mkdir -p "$THUMBNAIL_DIR"

# Loop through each image in the source directory
for img in "$SOURCE_DIR"/*.png; do
    # Skip if no files match the pattern
    [ -e "$img" ] || continue

    # Get the filename without the path
    filename=$(basename "$img")

    # Output path for the thumbnail
    output="$THUMBNAIL_DIR/$filename"

    # Create a 5x smaller version and compress it, keeping PNG format
    magick "$img" -resize 20% -quality 85 "$output" || {
        echo "Error: Failed to create thumbnail for $filename"
        continue
    }
    echo "Thumbnail created for $filename"
done

echo "All thumbnails generated in $THUMBNAIL_DIR."

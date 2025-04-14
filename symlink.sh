#!/bin/bash

# Set your paths
TEMPLATE_DIR="$HOME/Documents/void/void-packages/srcpkgs"
DEST_DIR="$HOME/Documents/void/void-templates/srcpkgs"

# List of packages you want to symlink
packages=("floorp-bin" "brave-browser" "liquidctl" "vesktop" "youtube-music")

# Make sure both paths exist
if [ ! -d "$TEMPLATE_DIR" ] || [ ! -d "$DEST_DIR" ]; then
    echo "Either template or destination directory does not exist."
    exit 1
fi

# Loop through selected packages
for pkgname in "${packages[@]}"; do
    src="$TEMPLATE_DIR/$pkgname"
    dest="$DEST_DIR/$pkgname"

    if [ ! -d "$src" ]; then
        echo "Skipping $pkgname: not found in template directory"
        continue
    fi

    if [ -L "$dest" ]; then
        current_target=$(readlink -f "$dest")
        desired_target=$(readlink -f "$src")
        if [ "$current_target" != "$desired_target" ]; then
            echo "Updating symlink for $pkgname"
            ln -sf "$src" "$dest"
        else
            echo "Symlink for $pkgname already correct"
        fi
    elif [ -e "$dest" ]; then
        echo "Skipping $pkgname: path exists and is not a symlink"
    else
        echo "Linking $pkgname"
        ln -s "$src" "$dest"
    fi
done

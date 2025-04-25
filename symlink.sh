#!/usr/bin/env bash

TEMPLATE_DIR="$HOME/Documents/void/void-templates/srcpkgs"
DEST_DIR="$HOME/Documents/void/void-packages/srcpkgs"

mkdir -p "$DEST_DIR"

for template_path in "$TEMPLATE_DIR"/*; do
    pkgname=$(basename "$template_path")
    dest_pkgdir="$DEST_DIR/$pkgname"

    mkdir -p "$dest_pkgdir"

    src_template="$template_path/template"
    dest_template="$dest_pkgdir/template"

    if [ ! -f "$src_template" ]; then
        echo "Skipping $pkgname (no template file found)"
        continue
    fi

    if [ -e "$dest_template" ]; then
        echo "Skipping $pkgname (template already exists)"
    else
        ln -s "$src_template" "$dest_template"
        echo "Linked $pkgname → $dest_template"
    fi
done

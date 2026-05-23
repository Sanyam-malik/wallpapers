#!/bin/bash

shopt -s nullglob

declare -A used

# Record already-used numbers
for f in *.{jpg,jpeg,png,gif,webp,bmp,tiff}; do
    [[ -f "$f" ]] || continue
    [[ "$f" =~ ^([0-9]+)\.[^.]+$ ]] && used[${BASH_REMATCH[1]}]=1
done

next=1

for f in *.{jpg,jpeg,png,gif,webp,bmp,tiff}; do
    [[ -f "$f" ]] || continue

    # Skip already-numbered files
    [[ "$f" =~ ^[0-9]+\.[^.]+$ ]] && continue

    ext="${f##*.}"

    while [[ -n "${used[$next]}" ]]; do
        ((next++))
    done

    mv -- "$f" "$next.$ext"
    used[$next]=1
    ((next++))
done

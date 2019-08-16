#!/usr/bin/env bash

wallpapers="/home/dk/Pictures/wallpapers/"

img="$wallpapers`ls $wallpapers | sort -R | tail -$N | head -n 1`"

feh --bg-fill $img


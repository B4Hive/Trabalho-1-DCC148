#!/bin/sh
printf '\033c\033]0;%s\a' Trabalho1
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Trabalho1.x86_64" "$@"

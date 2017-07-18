#!/usr/bin/env bash

# fetch the colors from colors.sh
source "/home/$USER/.scripts/colors.sh"

~/.scripts/barinfo.sh | lemonbar \
    -f '-benis-lemon-*' \
    -f '-wuncon-siji-*' \
    -g "x30" \
    -B "$bgn" \
    | sh
#!/usr/bin/env bash
if [ "$#" -eq 0 ] || [[ " $@ " =~ " --help " ]] && [[ " $@ " != *"artisan"* ]] && [[ " $@ " != *"exec"* ]] && [[ " $@ " != *"composer"* ]] && [[ " $@ " != *"npm"* ]]; then
cat <<EOF

    █   ▄▀█ █▀█ ▄▀█ █ █ █ █ █▄ █ █▀▄
    █▄▄ █▀█ █▀▄ █▀█ ▀▄▀▄▀ █ █ ▀█ █▄▀

EOF
fi
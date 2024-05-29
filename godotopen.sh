#!/bin/bash
[ -n "$1" ] && file=$1
echo  "printing $file"
nvim --server ~/.cache/nvim/godot.pipe --remote-send ':e '$file'<CR>'

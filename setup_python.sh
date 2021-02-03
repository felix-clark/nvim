#!/usr/bin/env bash

# Install neovim python support. This should maybe be in setup.sh; other plugings may use it.
# This will need to be installed in virtual environments as well, I think.
# We need a version of neovim with python3 support.
pip3 install pynvim --upgrade

nvim -c 'CocInstall\ coc-pyright' -c '<\CR>' -c 'qa'

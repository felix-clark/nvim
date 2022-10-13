#!/usr/bin/env bash

echo "This script is essentially deprecated; use `:LspInstall pylsp` then `:PylspInstaller [...]` to install the LSP and additional features."

# Install neovim python support. This should maybe be in setup.sh; other plugings may use it.
# This will need to be installed in virtual environments as well, I think.
# We need a version of neovim with python3 support.
python3 -m pip install pynvim --upgrade

python3 -m pip install 'python-lsp-server[all]' pylsp-mypy python-lsp-black pyls-isort
# python3 -m pip install pyls-flake8

nvim -c 'TSInstall\ python' -c '<\CR>' -c 'qa'

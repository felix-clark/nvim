#!/usr/bin/env bash

echo "This script is untested"

# install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
nvim -c 'PlugInstall' -c '<\CR>' -c 'qa'

# Install rust utilities (requires responding to prompt)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install ripgrep fd-find bat git-delta

echo "TODO: set up fzf env vars, etc."

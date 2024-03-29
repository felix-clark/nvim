#!/usr/bin/env bash

# Cargo dependencies require some basic pkgs
sudo apt-get -y install build-essential pkg-config libssl-dev

# telescope-frecency requires sqlite
sudo apt-get -y install sqlite3 libsqlite3-dev

# Install plugins and compile. This doesn't appear to always work; may need to be done manually.
nvim -c 'PackerSync' -c '<\CR>' -c 'qa'

# Install rust utilities (requires responding to prompt)
if ! command -v cargo &> /dev/null
then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi
cargo install ripgrep fd-find bat git-delta
# lua formatting. More recently maintained than luafmt, which is written in
# TypeScript.
cargo install stylua

echo "Make sure to install a NERDfont and set it as your terminal's font."

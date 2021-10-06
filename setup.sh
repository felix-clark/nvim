#!/usr/bin/env bash

# telescope-frecency requires sqlite
sudo apt-get -y install sqlite3 libsqlite3-dev

# Install plugins and compile
nvim -c 'PackerSync' -c '<\CR>' -c 'qa'

# Install rust utilities (requires responding to prompt)
if ! command -v cargo &> /dev/null
then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi
cargo install ripgrep fd-find bat git-delta

echo "Make sure to install a NERDfont and set it as your terminal's font."

#!/usr/bin/env bash

# Cargo dependencies require some basic pkgs
sudo apt-get -y install build-essential pkg-config libssl-dev

# telescope-frecency requires sqlite
sudo apt-get -y install sqlite3 libsqlite3-dev

# Install rust utilities (requires responding to prompt)
if ! command -v cargo &> /dev/null
then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi
rustup update
cargo install ripgrep fd-find bat git-delta --locked

# Commented out because it has not been tested.
if ! command -v lazygit &> /dev/null
then
  # Install lazygit using recommended procedure for ubuntu.
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm -r lazygit lazygit.tar.gz
fi

echo "Make sure to install a NERDfont and set it as your terminal's font."

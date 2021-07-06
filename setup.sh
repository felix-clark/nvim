#!/usr/bin/env bash

# install vim-plug
PLUG_VIM="$HOME/.local/share/nvim/site/autoload/plug.vim"
if [ ! -f $PLUG_VIM ]
then
    curl -fLo $PLUG_VIM --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install plugins
nvim -c 'PlugInstall' -c '<\CR>' -c 'qa'

# Install rust utilities (requires responding to prompt)
if ! command -v cargo &> /dev/null
then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi
# NOTE: bat is probably unneccessary now that we've moved from fzf to telescope
cargo install ripgrep fd-find bat git-delta

nvim -c 'TSInstall bash' -c '<\CR>' -c 'qa'
nvim -c 'TSInstall fish' -c '<\CR>' -c 'qa'

echo "TODO: nerd fonts?"

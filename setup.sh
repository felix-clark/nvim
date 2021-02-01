#!/usr/bin/env bash

echo "This script is untested"

# install vim-plug
PLUG_VIM="$HOME/.local/share/nvim/site/autoload/plug.vim"
if [ ! -f $PLUG_VIM ]
then
    curl -fLo $PLUG_VIM --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install the latest node executable if it's not available
if ! command -v node &> /dev/null
then
    if command -v nvm &> /dev/null
    then
        echo "WARNING: nvm detected, but this script cannot find node."
        echo "Calling default `nvm use`."
        nvm use
    else
        curl -sL install-node.now.sh/lts | sudo bash
    fi
fi

# Install plugins
nvim -c 'PlugInstall' -c '<\CR>' -c 'qa'

# Install fuzzy finder
# NOTE: The plugin should install it if needed
#if ! command -v fzf &> /dev/null
#then
    #sudo apt-get update
    #sudo apt-get install -y fzf
#fi
# Install rust utilities (requires responding to prompt)
if ! command -v cargo &> /dev/null
then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi
cargo install ripgrep fd-find bat git-delta

# Set up fzf to use fd
if ! grep -Fq "FZF_DEFAULT_COMMAND" $HOME/.bashrc
then
    echo "export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'" >> $HOME/.bashrc
    echo 'export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"' >> $HOME/.bashrc
fi
# Set up fzf in fish as well, if a config exists
if [ -f $HOME/.config/fish/config.fish ]
then
    if ! grep -Fq "FZF_DEFAULT_COMMAND" $HOME/.config/fish/config.fish
    then
        echo "set -xg FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'" >> $HOME/.config/fish/config.fish
        echo 'set -xg FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"' >> $HOME/.config/fish/config.fish
    fi
fi

echo "TODO: nerd fonts?"

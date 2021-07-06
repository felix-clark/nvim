# Neovim configuration

## Setup

Clone this repo as follows.
```
git clone git@github.com:felix-clark/nvim.git ~/.config/nvim
```

Execute `./setup.sh` to install and set up the pre-requisites. This is undertested, however, so follow directions below.

First install vim-plug as follows:
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then run `:PlugInstall` from within neovim to download plugins.

Update plugins with `:PlugUpdate`.

Try running on the command line with `nvim -c 'PlugInstall' -c '<\CR>' -c 'qa'`.

### Install fonts

Install a nerd font by copying into `~/.fonts` or `~/.local/share/fonts`, then
run `fc-cache -fv` to rebuild the cache. (This may not be working.)

### Supporting utilities

Install rust/cargo.
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
Make sure that `$HOME/.cargo/env` is sourced immediately and also in your shell init.

Install utilities through cargo.
```
cargo install ripgrep fd-find bat git-delta
```

## Keybindings

Insert mode can be exited with `jk` in rapid succession.

The leader key is mapped to spacebar. Press it and wait half a second for a pop-up menu describing custom commands.

### Easymotion

Double-tap the leader key (`<space>`) then a normal motion key like `j` or `W`.

### Vimspector for debugging
 
NOTE: Consider nvim-dap now that 0.5 is being used

Run `:VimspectorInstall <lang>` where `<lang>` is a language of choice (e.g. `debugpy`). Update with `:VimspectorUpdate`.

A `.vimspector.json` file must be present in the project root to define
adaptors, or in `vimspector/configurations/linux/_all/<name>.json` within this
repo.

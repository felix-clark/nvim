# Neovim configuration

## Setup

Clone this repo as follows.
```
git clone git@github.com:felix-clark/nvim.git ~/.config/nvim
```

Execute `./setup.sh` to install and set up the pre-requisites. This is undertested, however, so follow directions below.

Run `:PackerSync` from within neovim to download plugins.

Try running on the command line with `nvim -c 'PackerSync' -c '<\CR>' -c 'qa'`.

### Install fonts

* Download a [nerd font](https://www.nerdfonts.com/) such as Fira Code.
* Unpack into `~/.local/share/fonts`.
* Run `fc-cache -fv` to rebuild the font cache.
* Adjust your terminal's preferences to use the nerd font.

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

### Motion

For easymotion-like action, double-tap the leader key (`<space>`) then quickly
press a normal motion key like `j` or `W`.

Currently, Lightspeed is being experimented with as well. Use `s/S` for
forward/backward jumps, respectively.

### Debugging

Consult the documentation for nvim-dap to see how to install and configure
debuggers. Some keybindings are defined but no debuggers are currently set up.

NOTE: Consider [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)

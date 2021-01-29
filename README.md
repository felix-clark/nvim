# Neovim configuration

## Setup

Clone this repo as follows.
```
git clone git@github.com:felix-clark/nvim.git ~/.config/nvim
```

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

### Configuring fzf

Set the following environment variables in your shell's init. e.g. bash:
```
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
```

## Keybindings

The leader key is mapped to spacebar. Insert mode can be exited with `jk` in
rapid succession.

### Easymotion

Double-tap the leader key (`<space>`) then a normal motion key like `j` or `W`.

### Code commenting

* `<space>cc` - comment (line or visual selection)
* `<space>cu` - uncomment
* `<space>c<space>` - toggle comment

See NERDCommenter documentation for more.

### NERDTree

* `<space>tt` - toggle NERDTree view

`<space>w` is an alternative to `<C-w>`.
Window navigation is done via `<space>w[hjkl]`. A window can be closed with
`<space>wc`.

### CoC for LSP

NOTE: For neovim 0.5, might prefer native LSP support.

Install node if not already present.
```
curl -sL install-node.now.sh/lts | bash
```

Configuration settings are in `coc-settings.json`. It can be opened with `:CocConfig`.

#### Language-specific

Language servers must be installed with `:CocInstall`. They often have prerequisites.

* python - TODO 

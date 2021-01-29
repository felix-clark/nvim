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

### Install fonts

Install a nerd font by copying into `~/.fonts` or `~/.local/share/fonts`, then
run `fc-cache -fv` to rebuild the cache. (This may not be working.)

## Keybindings

The leader key is mapped to spacebar. Insert mode can be exited with `jk` in
rapid succession.

### Easymotion

Double-tap the leader key (`<space>`) then a normal motion key like `j` or `W`.

### Code commenting

* `<space>cc` - comment (line or visual selection)
* `<space>cu` - uncomment

### NERDTree

* `<space>tt` - toggle NERDTree view

`<space>w` is an alternative to `<C-w>`.
Window navigation is done via `<space>w[hjkl]`. A window can be closed with
`<space>wc`.

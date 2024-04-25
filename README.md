# Neovim configuration

## Setup

Clone this repo as follows.
```
git clone git@github.com:felix-clark/nvim.git ~/.config/nvim
```

In principle, execute `./setup.sh` to install and set up the pre-requisites.
This is undertested, however, so follow directions below.

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

Use leap's `s` to jump to any 2-character location on screen.

## Advanced language features

`:Mason` is used to select and install LSPs, formatters, debuggers, etc.
Language-specific debugging is probably under-implemented at the moment.

## Troubleshooting

If strange errors occur upon updating, try cleaning out `rm -rf ~/.local/share/nvim/*`.

## Future considerations

* [molten-nvim](https://github.com/benlubas/molten-nvim) for jupyter notebooks
* [typescript-tools](https://github.com/pmizio/typescript-tools.nvim) for web dev
* [neotest-rust](https://github.com/rouge8/neotest-rust) for even more convenient rust unit tests
* [nvim-dev-container](https://codeberg.org/esensar/nvim-dev-container) to develop inside remote container using local client

#!/usr/bin/env bash

if ! command -v rust-analyzer &> /dev/null
then
    echo "WARNING: Install rust-analyzer."
    echo "This script will not presume to know where to install it."
    # NOTE: Once it's recommended to use cargo, we can install with that method.
fi

rustup component add rust-src rustfmt clippy

nvim -c 'TSInstall rust' -c '<\CR>' -c 'qa'


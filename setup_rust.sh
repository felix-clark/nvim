#!/usr/bin/env bash

# Supposedly coc-rust-analyzer can download it's own version of rust-analyzer. This might be prefered so that it can always find it.
if ! command -v rust-analyzer &> /dev/null
then
    echo "WARNING: Install rust-analyzer."
    echo "This script will not presume to know where to install it."
    # NOTE: Once it's recommended to use cargo, we can install with that method.
fi

nvim -c 'CocInstall coc-rust-analyzer' -c '<\CR>' -c 'qa'


#!/bin/sh

if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "tpm directory already exists. Skipping installation..."
else
    mkdir -p $HOME/.tmux/plugins
    tput smcup
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    tput rmcup
    echo "tmux plugin manager, tpm, has been installed."
fi


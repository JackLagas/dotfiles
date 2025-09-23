#!/bin/sh


SCRIPT_DIR=$(dirname $0)
CURRENT_DIR=$(pwd)

cd "$SCRIPT_DIR/.."
stow -v -R -t "$HOME" . --adopt 
cd "$CURRENT_DIR"

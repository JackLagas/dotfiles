#!/bin/sh

if ! command -v yay &> /dev/null; then
    echo "yay not found!"
    read -p "Install yay? [Y/n]: " should_install
    if [ "$should_install" = "y" ] || [ "$should_install" = "Y" ] || [ "$should_install" = "" ]; then
        echo "Installing build dependencies"
        sudo pacman -S --needed --noconfirm git
        echo "Downloading yay..."
        git clone https://aur.archlinux.org/yay.git &>/dev/null
        echo "Installing yay..."
        cd yay
        makepkg -si --noconfirm --needed &>/dev/null
        cd ..
        rm -rf yay &>/dev/null
        echo "Finished installing yay"
    else
        echo "Exiting..."
        exit
    fi
fi

yay -S --noconfirm --needed oh-my-posh neovim tmux zsh fzf zoxide ripgrep fd ttf-meslo-nerd
mkdir -p $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm    

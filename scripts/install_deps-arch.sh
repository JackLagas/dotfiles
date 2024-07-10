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

read -p "Install default font? [Y/n]: " install_font
if [ "$install_font" = "y" ] || [ "$install_font" = "Y" ] || [ "$install_font" = "" ]; then
    echo "Installing font..."
    echo ""
    yay -S --noconfirm --needed ttf-meslo-nerd
    echo ""
    echo "Meslo Nerd installed!"
    echo "Make sure to set your terminal's font to \"Meslo LGS NF\""
else
    echo "Skipping font installtion..."
    echo "Make sure you're using a nerd font!"
fi
echo "Installing dependencies..."
echo ""
yay -S --noconfirm --needed oh-my-posh neovim tmux zsh fzf zoxide ripgrep fd stow
echo ""
echo "Dependencies installed"
mkdir -p $HOME/.tmux/plugins
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "tpm directory already exists. Skipping installation..."
else
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm    
fi

echo ""
echo "Setting up stow"
CURRENT_DIR=$(pwd)
SCRIPT_DIR="$(dirname "$0")"
cd $SCRIPT_DIR/..
stow . --adopt
cd $CURRENT_DIR

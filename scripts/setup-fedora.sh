#!/bin/sh

echo "This script will install RPM Fusion free and nonfree and"
read -p "install multimedia libraries from it. Continue? [Y/n]: " continue_install

if [ "$continue_install" = "n" ] || [ "$continue_install" = "N" ]; then
    exit
fi

echo "Installing RPM Fusion..."
tput smcup
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
tput rmcup
echo "Setting up multimedia..."
tput smcup
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y && sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y && sudo dnf update @sound-and-video -y
tput rmcup

read -p "Install default font? [Y/n]: " install_font
if [ "$install_font" = "y" ] || [ "$install_font" = "Y" ] || [ "$install_font" = "" ]; then
    echo "Installing fonts"
    read -p "Install all nerd fonts or just the default? [A/d]: " all_fonts
    tput smcup
    if [ -d "nerd-fonts" ]; then
        echo "nerd-fonts repo exists skipping clone..."
    else
        git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git 
    fi
    cd nerd-fonts
    if [ "$all_fonts" = "a" ] || [ "$all_fonts" = "A" ] || [ "$all_fonts" = "" ]; then
        ./install.sh
    else
        ./install.sh Meslo
    fi
    cd ..
    read -p "Delete nerd fonts repository? [Y/n]: " delete_repo
    if [ "$delete_repo" = "y" ] || [ "$delete_repo" = "Y" ] || [ "$delete_repo" = "" ]; then
        rm -rf nerd-fonts
    fi
else
    echo "Make sure you use a nerd font for symbols to work!"
fi

echo "Installing dependencies..."
tput smcup
curl -s https://ohmyposh.dev/install.sh | bash -s
sudo dnf install -y neovim tmux zsh fzf zoxide ripgrep fd-find
tput rmcup
echo "Dependencies installed"

mkdir -p $HOME/.tmux/plugins
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "tpm directory already exists. Skipping installation..."
else
    tput smcup
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    tput rmcup
fi


read -p "Setup stow? [Y/n]: " install_stow
if [ "$install_stow" = "y" ] || [ "$install_stow" = "Y" ] || [ "$install_stow" = "" ]; then
    tput smcup
    sudo dnf install -y stow
    tput rmcup
    echo "Setting up stow"
    CURRENT_DIR=$(pwd)
    SCRIPT_DIR="$(dirname "$0")"
    cd $SCRIPT_DIR/..
    stow . --adopt
    cd $CURRENT_DIR
fi

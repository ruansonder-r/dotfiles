#!/bin/bash

# Dependencies Installation Script for Ruan's Dotfiles - Arch Linux
# This script installs all necessary packages and tools for Arch-based systems

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install package if not exists using pacman
install_package() {
    local package="$1"
    local package_name="${2:-$1}"
    
    if pacman -Qi "$package" >/dev/null 2>&1; then
        print_success "$package_name is already installed"
    else
        print_status "Installing $package_name..."
        sudo pacman -S --noconfirm "$package"
        print_success "$package_name installed successfully"
    fi
}

# Function to install AUR package using yay
install_aur_package() {
    local package="$1"
    local package_name="${2:-$1}"
    
    if yay -Qi "$package" >/dev/null 2>&1; then
        print_success "$package_name is already installed"
    else
        print_status "Installing $package_name from AUR..."
        yay -S --noconfirm "$package"
        print_success "$package_name installed successfully"
    fi
}

print_status "Installing dependencies for Ruan's dotfiles on Arch Linux..."

# Update package database
print_status "Updating package database..."
sudo pacman -Sy

# Install yay if not present
if ! command_exists "yay"; then
    print_status "Installing yay AUR helper..."
    if ! pacman -Qi "git" >/dev/null 2>&1; then
        sudo pacman -S --noconfirm git
    fi
    cd /tmp
    # Remove existing yay directory if it exists
    rm -rf yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    # Clean up temporary directory
    rm -rf /tmp/yay
    print_success "yay installed successfully"
fi

# Essential packages
install_package "zsh" "Zsh"
install_package "curl" "cURL"
install_package "wget" "Wget"
install_package "git" "Git"
install_package "vim" "Vim"
install_package "base-devel" "Base Development Tools"

# Development tools
install_package "nodejs" "Node.js"
install_package "npm" "npm"
install_package "python" "Python 3"
install_package "python-pip" "pip"
install_package "ruby" "Ruby"

# Terminal and editor tools
install_package "lazygit" "LazyGit"
install_package "htop" "htop"
install_package "tree" "tree"
install_package "ripgrep" "ripgrep"
install_package "fd" "fd"
install_package "bat" "bat"
install_package "fzf" "fzf"
install_package "the_silver_searcher" "The Silver Searcher (ag)"

# System utilities
install_package "brightnessctl" "brightnessctl"
install_package "xorg-xinput" "xinput"
install_package "expect" "expect"

# VPN tools
install_package "openvpn" "OpenVPN"
install_package "openfortivpn" "OpenFortiVPN"

# Install thefuck from AUR
install_aur_package "thefuck" "thefuck"

# Install GlobalProtect VPN client from AUR
install_aur_package "globalprotect-openconnect" "GlobalProtect VPN Client"

# Ruby version management (chruby alternative for Arch)
install_aur_package "chruby" "chruby (Ruby version manager)"
install_aur_package "ruby-install" "ruby-install"

# Install Neovim
install_package "neovim" "Neovim"

# Install Oh My Zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
    print_success "Oh My Zsh is already installed"
else
    print_status "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed successfully"
fi

# Install Zsh plugins
print_status "Installing Zsh plugins..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install Rust (for additional tools)
if command_exists "cargo"; then
    print_success "Rust is already installed"
else
    print_status "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    print_success "Rust installed successfully"
fi

# Install Rust-based tools via cargo (after ensuring Rust is available)
if command_exists "cargo"; then
    print_status "Installing modern CLI tools via cargo..."
    
    if ! command_exists "zoxide"; then
        print_status "Installing zoxide..."
        cargo install zoxide
        print_success "zoxide installed successfully"
    else
        print_success "zoxide is already installed"
    fi
    
    if ! command_exists "eza"; then
        print_status "Installing eza..."
        cargo install eza
        print_success "eza installed successfully"
    else
        print_success "eza is already installed"
    fi
else
    print_warning "Cargo not available, skipping Rust-based tool installation"
fi

# Install LunarVim
if command_exists "lvim"; then
    print_success "LunarVim is already installed"
else
    print_status "Installing LunarVim..."
    bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) --yes
    print_success "LunarVim installed successfully"
fi

# Additional Arch-specific improvements
print_status "Installing additional Arch packages..."

# Install paru as an alternative to yay (optional)
install_aur_package "paru" "Paru AUR Helper"

# Install some additional useful tools for development
install_package "stow" "GNU Stow (for dotfile management)"
install_package "tmux" "tmux"
install_package "ranger" "Ranger file manager"
install_package "openssh" "OpenSSH"

# Install fonts for better terminal experience
install_package "ttf-fira-code" "Fira Code Font"
install_package "ttf-jetbrains-mono" "JetBrains Mono Font"
install_aur_package "nerd-fonts-fira-code" "Nerd Fonts Fira Code"

print_success "All dependencies installed successfully!"

echo
print_status "Next steps:"
echo "1. Run the main installation script: ./install/install-arch.sh"
echo "2. Restart your terminal"
echo "3. Configure LunarVim by editing ~/.config/lvim/config.lua"
echo "4. Set up shell aliases by sourcing: source ~/.zshrc"
echo
print_warning "Note: Some tools may require additional configuration after installation."
print_status "Arch-specific notes:"
echo "- Use 'pacman -S' for official packages"
echo "- Use 'yay -S' or 'paru -S' for AUR packages"
echo "- System updates: 'sudo pacman -Syu'"
echo "- AUR updates: 'yay -Sua' or 'paru -Sua'"

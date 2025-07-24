#!/bin/bash

# Dependencies Installation Script for Ruan's Dotfiles
# This script installs all necessary packages and tools

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

# Function to install package if not exists
install_package() {
    local package="$1"
    local package_name="${2:-$1}"
    
    if command_exists "$package"; then
        print_success "$package_name is already installed"
    else
        print_status "Installing $package_name..."
        sudo apt update
        sudo apt install -y "$package"
        print_success "$package_name installed successfully"
    fi
}

print_status "Installing dependencies for Ruan's dotfiles..."

# Update package list
print_status "Updating package list..."
sudo apt update

# Essential packages
install_package "zsh" "Zsh"
install_package "curl" "cURL"
install_package "wget" "Wget"
install_package "git" "Git"
install_package "vim" "Vim"
install_package "build-essential" "Build Essential"

# Development tools
install_package "nodejs" "Node.js"
install_package "npm" "npm"
install_package "python3" "Python 3"
install_package "python3-pip" "pip3"
install_package "ruby" "Ruby"
install_package "ruby-dev" "Ruby Dev"

# Terminal and editor tools
install_package "lazygit" "LazyGit"
install_package "htop" "htop"
install_package "tree" "tree"
install_package "ripgrep" "ripgrep"
install_package "fd-find" "fd"

# Install Neovim
if command_exists "nvim"; then
    print_success "Neovim is already installed"
else
    print_status "Installing Neovim..."
    sudo apt install -y software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    sudo apt update
    sudo apt install -y neovim
    print_success "Neovim installed successfully"
fi

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

# Install Homebrew (for additional packages)
if command_exists "brew"; then
    print_success "Homebrew is already installed"
else
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew-core/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    print_success "Homebrew installed successfully"
fi

print_success "All dependencies installed successfully!"

echo
print_status "Next steps:"
echo "1. Run the main installation script: ./install/install.sh"
echo "2. Restart your terminal"
echo "3. Install Neovim plugins by running: nvim +PackerSync"
echo
print_warning "Note: Some tools may require additional configuration after installation." 

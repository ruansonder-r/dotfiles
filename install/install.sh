#!/bin/bash

# Ruan's Dotfiles Installation Script
# This script installs all configuration files to their proper locations

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Function to backup existing file
backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$file" "$backup"
        print_status "Backed up $file to $backup"
    fi
}

# Function to backup existing directory
backup_directory() {
    local dir="$1"
    if [ -d "$dir" ]; then
        local backup="${dir}.backup.$(date +%Y%m%d_%H%M%S)"
        cp -r "$dir" "$backup"
        print_status "Backed up $dir to $backup"
    fi
}

# Function to install file
install_file() {
    local source="$1"
    local target="$2"
    
    if [ -f "$source" ]; then
        backup_file "$target"
        cp "$source" "$target"
        print_success "Installed $target"
    else
        print_error "Source file $source not found"
        return 1
    fi
}

# Function to install directory
install_directory() {
    local source="$1"
    local target="$2"
    
    if [ -d "$source" ]; then
        backup_directory "$target"
        cp -r "$source" "$target"
        print_success "Installed $target"
    else
        print_error "Source directory $source not found"
        return 1
    fi
}

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

print_status "Starting dotfiles installation..."
print_status "Dotfiles directory: $DOTFILES_DIR"

# Check if we're in the right directory
if [ ! -f "$DOTFILES_DIR/README.md" ]; then
    print_error "README.md not found. Please run this script from the dotfiles directory."
    exit 1
fi

# Create necessary directories
print_status "Creating necessary directories..."
mkdir -p ~/.config
mkdir -p ~/.config/lvim

# Install shell configurations
print_status "Installing shell configurations..."
install_file "$DOTFILES_DIR/shell/.bashrc" ~/.bashrc
install_file "$DOTFILES_DIR/shell/.zshrc" ~/.zshrc
install_file "$DOTFILES_DIR/shell/.profile" ~/.profile
install_file "$DOTFILES_DIR/shell/.zprofile" ~/.zprofile
install_file "$DOTFILES_DIR/shell/.zshenv" ~/.zshenv

# Install editor configurations
print_status "Installing editor configurations..."
install_directory "$DOTFILES_DIR/editor/nvim" ~/.config/nvim
install_file "$DOTFILES_DIR/editor/lunarvim/config.lua" ~/.config/lvim/config.lua

# Install git configurations
print_status "Installing git configurations..."
install_file "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
install_file "$DOTFILES_DIR/git/.gitignore_global" ~/.gitignore_global
install_directory "$DOTFILES_DIR/git/lazygit" ~/.config/lazygit

print_success "Installation completed successfully!"

# Post-installation instructions
echo
print_status "Post-installation steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Install dependencies by running: ./install/dependencies.sh"
echo "3. LunarVim configuration will be automatically loaded on first run"
echo "4. Modern CLI tools (zoxide, fzf, ripgrep) should now be available"
echo "5. Set up Git with: git config --global user.name 'Your Name'"
echo
print_warning "Note: Some configurations may require additional packages or manual setup."
print_warning "Check the README.md for more details." 

#!/bin/bash

# Ruan's Dotfiles Installation Script - Arch Linux
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
        # Create target directory if it doesn't exist
        mkdir -p "$(dirname "$target")"
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
        # Create parent directory if it doesn't exist
        mkdir -p "$(dirname "$target")"
        cp -r "$source" "$target"
        print_success "Installed $target"
    else
        print_error "Source directory $source not found"
        return 1
    fi
}

# Function to create Arch-specific shell configurations
create_arch_shell_configs() {
    print_status "Creating Arch-specific shell configurations..."
    
    # Create .bashrc for Arch
    if [ -f "$DOTFILES_DIR/shell/.bashrc" ]; then
        # Copy the original and make Arch-specific adjustments
        cp "$DOTFILES_DIR/shell/.bashrc" "/tmp/.bashrc.arch"
        
        # Replace Ubuntu-specific references with Arch equivalents
        sed -i 's/batcat/bat/g' "/tmp/.bashrc.arch"
        sed -i 's|/usr/bin/lesspipe|/usr/bin/lesspipe.sh|g' "/tmp/.bashrc.arch"
        sed -i '/debian_chroot/d' "/tmp/.bashrc.arch"
        
        # Add Arch-specific aliases
        cat >> "/tmp/.bashrc.arch" << 'EOF'

# Arch-specific aliases and functions
alias pac='sudo pacman -S'        # Install package
alias pacr='sudo pacman -R'       # Remove package
alias pacu='sudo pacman -Syu'     # Update system
alias pacs='pacman -Ss'           # Search packages
alias pacq='pacman -Q'            # List installed packages
alias pacqi='pacman -Qi'          # Show package info
alias pacc='sudo pacman -Sc'      # Clean package cache

# AUR helpers
alias yays='yay -S'               # Install from AUR
alias yayu='yay -Sua'             # Update AUR packages
alias parus='paru -S'             # Install from AUR (paru)
alias paruu='paru -Sua'           # Update AUR packages (paru)

# System info
alias sysinfo='neofetch'          # System information
alias diskusage='df -h'           # Disk usage
alias meminfo='free -h'           # Memory info

# Modern CLI tool aliases (Arch-specific paths)
alias fzfp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias ls='eza'                    # Use eza instead of ls if available
alias la='eza -la'                # List all files
alias ll='eza -l'                 # Long format
alias tree='eza --tree'           # Tree view

EOF
        
        backup_file ~/.bashrc
        cp "/tmp/.bashrc.arch" ~/.bashrc
        print_success "Installed Arch-specific ~/.bashrc"
        rm "/tmp/.bashrc.arch"
    fi
    
    # Create .zshrc for Arch
    if [ -f "$DOTFILES_DIR/shell/.zshrc" ]; then
        cp "$DOTFILES_DIR/shell/.zshrc" "/tmp/.zshrc.arch"
        
        # Replace Ubuntu-specific references
        sed -i 's/batcat/bat/g' "/tmp/.zshrc.arch"
        
        # Remove Ubuntu/chruby specific lines that might not work on Arch
        sed -i '/source \/usr\/local\/share\/chruby/d' "/tmp/.zshrc.arch"
        
        # Add Arch-specific configurations
        cat >> "/tmp/.zshrc.arch" << 'EOF'

# Arch Linux specific configurations

# Pacman aliases
alias pac='sudo pacman -S'
alias pacr='sudo pacman -R'
alias pacu='sudo pacman -Syu'
alias pacs='pacman -Ss'
alias pacq='pacman -Q | grep'
alias pacc='sudo pacman -Sc'

# AUR helpers
alias yays='yay -S'
alias yayu='yay -Sua'

# Enhanced ls with eza
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons'
    alias la='eza -la --icons'
    alias ll='eza -l --icons'
    alias tree='eza --tree --icons'
fi

# System maintenance
alias mirrors='sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "No orphaned packages to remove"'

# Better bat preview for fzf
alias fzfp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'

EOF
        
        backup_file ~/.zshrc
        cp "/tmp/.zshrc.arch" ~/.zshrc
        print_success "Installed Arch-specific ~/.zshrc"
        rm "/tmp/.zshrc.arch"
    fi
}

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

print_status "Starting dotfiles installation for Arch Linux..."
print_status "Dotfiles directory: $DOTFILES_DIR"

# Check if we're in the right directory
if [ ! -f "$DOTFILES_DIR/README.md" ]; then
    print_error "README.md not found. Please run this script from the dotfiles directory."
    exit 1
fi

# Check if we're on Arch Linux
if [ ! -f "/etc/arch-release" ] && [ ! -f "/etc/manjaro-release" ]; then
    print_warning "This script is designed for Arch-based systems. Proceeding anyway..."
fi

# Create necessary directories
print_status "Creating necessary directories..."
mkdir -p ~/.config
mkdir -p ~/.config/lvim
mkdir -p ~/.local/bin

# Install shell configurations with Arch-specific modifications
create_arch_shell_configs

# Install other shell files
print_status "Installing additional shell configurations..."
[ -f "$DOTFILES_DIR/shell/.profile" ] && install_file "$DOTFILES_DIR/shell/.profile" ~/.profile
[ -f "$DOTFILES_DIR/shell/.zprofile" ] && install_file "$DOTFILES_DIR/shell/.zprofile" ~/.zprofile
[ -f "$DOTFILES_DIR/shell/.zshenv" ] && install_file "$DOTFILES_DIR/shell/.zshenv" ~/.zshenv

# Install editor configurations
print_status "Installing editor configurations..."
install_directory "$DOTFILES_DIR/editor/nvim" ~/.config/nvim
install_file "$DOTFILES_DIR/editor/lunarvim/config.lua" ~/.config/lvim/config.lua

# Install git configurations
print_status "Installing git configurations..."
install_file "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
install_file "$DOTFILES_DIR/git/.gitignore_global" ~/.gitignore_global
install_directory "$DOTFILES_DIR/git/lazygit" ~/.config/lazygit

# Set Zsh as default shell if not already set
if [ "$SHELL" != "$(which zsh)" ]; then
    print_status "Setting Zsh as default shell..."
    chsh -s $(which zsh)
    print_success "Zsh set as default shell"
fi

print_success "Installation completed successfully!"

# Post-installation instructions
echo
print_status "Post-installation steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. If not done already, install dependencies: ./install/dependencies-arch.sh"
echo "3. LunarVim configuration will be automatically loaded on first run"
echo "4. Modern CLI tools (zoxide, fzf, ripgrep, eza) should now be available"
echo "5. Set up Git with: git config --global user.name 'Your Name'"
echo "6. Update mirrors with: mirrors (alias for reflector)"
echo
print_status "Arch-specific features added:"
echo "- Pacman aliases (pac, pacu, pacs, etc.)"
echo "- AUR helper aliases (yays, yayu for yay)"
echo "- System maintenance aliases (cleanup, mirrors)"
echo "- Enhanced file listing with eza icons"
echo
print_warning "Note: Some configurations may require additional packages or manual setup."
print_warning "Check the README.md for more details."
print_warning "You may need to restart your terminal or re-login for all changes to take effect."

#!/bin/bash

# Backup Script for Ruan's Dotfiles
# This script creates a backup of all current configurations before reinstalling

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

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
BACKUP_DIR="$DOTFILES_DIR/backup_$(date +%Y%m%d_%H%M%S)"

print_status "Creating backup of current configurations..."
print_status "Backup directory: $BACKUP_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to backup file if it exists
backup_file() {
    local file="$1"
    local backup_path="$2"
    
    if [ -f "$file" ]; then
        mkdir -p "$(dirname "$backup_path")"
        cp "$file" "$backup_path"
        print_success "Backed up $file"
    else
        print_warning "File $file not found, skipping"
    fi
}

# Function to backup directory if it exists
backup_directory() {
    local dir="$1"
    local backup_path="$2"
    
    if [ -d "$dir" ]; then
        mkdir -p "$(dirname "$backup_path")"
        cp -r "$dir" "$backup_path"
        print_success "Backed up $dir"
    else
        print_warning "Directory $dir not found, skipping"
    fi
}

# Backup shell configurations
print_status "Backing up shell configurations..."
backup_file ~/.bashrc "$BACKUP_DIR/shell/.bashrc"
backup_file ~/.zshrc "$BACKUP_DIR/shell/.zshrc"
backup_file ~/.profile "$BACKUP_DIR/shell/.profile"
backup_file ~/.zprofile "$BACKUP_DIR/shell/.zprofile"
backup_file ~/.zshenv "$BACKUP_DIR/shell/.zshenv"
backup_file ~/.bash_profile "$BACKUP_DIR/shell/.bash_profile"

# Backup editor configurations
print_status "Backing up editor configurations..."
backup_directory ~/.config/nvim "$BACKUP_DIR/editor/nvim"
backup_directory ~/.vim "$BACKUP_DIR/editor/vim"

# Backup git configurations
print_status "Backing up git configurations..."
backup_file ~/.gitconfig "$BACKUP_DIR/git/.gitconfig"
backup_directory ~/.config/lazygit "$BACKUP_DIR/git/lazygit"

# Backup additional important files
print_status "Backing up additional configurations..."
backup_file ~/.ssh/config "$BACKUP_DIR/ssh/config"
backup_directory ~/.ssh "$BACKUP_DIR/ssh/keys"
backup_file ~/.wakatime.cfg "$BACKUP_DIR/misc/.wakatime.cfg"
backup_file ~/.gemrc "$BACKUP_DIR/misc/.gemrc"

# Create a list of installed packages
print_status "Creating list of installed packages..."
dpkg --get-selections > "$BACKUP_DIR/system/installed_packages.txt" 2>/dev/null || print_warning "Could not create package list"

# Create a list of snap packages
print_status "Creating list of snap packages..."
snap list > "$BACKUP_DIR/system/snap_packages.txt" 2>/dev/null || print_warning "Could not create snap package list"

# Create a list of flatpak packages
print_status "Creating list of flatpak packages..."
flatpak list > "$BACKUP_DIR/system/flatpak_packages.txt" 2>/dev/null || print_warning "Could not create flatpak package list"

# Create a backup info file
cat > "$BACKUP_DIR/backup_info.txt" << EOF
Backup created on: $(date)
System: $(uname -a)
User: $(whoami)
Home directory: $HOME

This backup contains:
- Shell configurations (.bashrc, .zshrc, etc.)
- Editor configurations (Neovim, Vim)
- Git configurations (.gitconfig, LazyGit)
- SSH configurations
- System package lists

To restore from this backup:
1. Copy the files back to their original locations
2. Install the packages listed in the system/ directory
3. Run the main installation script: ./install/install.sh
EOF

print_success "Backup completed successfully!"
print_status "Backup location: $BACKUP_DIR"
print_status "Backup info: $BACKUP_DIR/backup_info.txt"

echo
print_warning "Important: Make sure to commit this backup to your git repository before reinstalling!"
print_warning "Run: git add . && git commit -m 'Backup before reinstall'" 

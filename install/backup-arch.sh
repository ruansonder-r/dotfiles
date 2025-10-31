#!/bin/bash

# Backup Script for Ruan's Dotfiles - Arch Linux
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
BACKUP_DIR="$DOTFILES_DIR/backup_arch_$(date +%Y%m%d_%H%M%S)"

print_status "Creating backup of current configurations (Arch Linux)..."
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
backup_directory ~/.config/lvim "$BACKUP_DIR/editor/lvim"
backup_directory ~/.vim "$BACKUP_DIR/editor/vim"

# Backup git configurations
print_status "Backing up git configurations..."
backup_file ~/.gitconfig "$BACKUP_DIR/git/.gitconfig"
backup_file ~/.gitignore_global "$BACKUP_DIR/git/.gitignore_global"
backup_directory ~/.config/lazygit "$BACKUP_DIR/git/lazygit"

# Backup additional important files
print_status "Backing up additional configurations..."
backup_file ~/.ssh/config "$BACKUP_DIR/ssh/config"
backup_directory ~/.ssh "$BACKUP_DIR/ssh/keys"
backup_file ~/.wakatime.cfg "$BACKUP_DIR/misc/.wakatime.cfg"
backup_file ~/.gemrc "$BACKUP_DIR/misc/.gemrc"

# Arch-specific backups
print_status "Backing up Arch-specific configurations..."
backup_file /etc/pacman.conf "$BACKUP_DIR/arch/pacman.conf"
backup_file ~/.makepkg.conf "$BACKUP_DIR/arch/.makepkg.conf" 2>/dev/null || true
backup_directory ~/.config/yay "$BACKUP_DIR/arch/yay" 2>/dev/null || true
backup_directory ~/.config/paru "$BACKUP_DIR/arch/paru" 2>/dev/null || true

# Create a list of installed packages
print_status "Creating list of installed packages..."
mkdir -p "$BACKUP_DIR/system"
pacman -Qe > "$BACKUP_DIR/system/pacman_explicit.txt" 2>/dev/null || print_warning "Could not create pacman explicit package list"
pacman -Qm > "$BACKUP_DIR/system/pacman_foreign.txt" 2>/dev/null || print_warning "Could not create foreign package list (AUR)"
pacman -Qn > "$BACKUP_DIR/system/pacman_native.txt" 2>/dev/null || print_warning "Could not create native package list"

# Create AUR package list if yay is available
if command -v yay >/dev/null 2>&1; then
    print_status "Creating AUR package list..."
    yay -Qm > "$BACKUP_DIR/system/aur_packages.txt" 2>/dev/null || print_warning "Could not create AUR package list"
fi

# Create paru package list if paru is available
if command -v paru >/dev/null 2>&1; then
    print_status "Creating paru package list..."
    paru -Qm > "$BACKUP_DIR/system/paru_packages.txt" 2>/dev/null || print_warning "Could not create paru package list"
fi

# Create a list of systemd services
print_status "Creating systemd services list..."
systemctl list-unit-files --state=enabled > "$BACKUP_DIR/system/systemd_enabled.txt" 2>/dev/null || print_warning "Could not create systemd services list"

# Backup Nix profile if it exists
if [ -d ~/.nix-profile ]; then
    print_status "Backing up Nix profile..."
    nix-env -q > "$BACKUP_DIR/system/nix_packages.txt" 2>/dev/null || print_warning "Could not create Nix package list"
    backup_file ~/.nix-dotfiles-env.sh "$BACKUP_DIR/nix/.nix-dotfiles-env.sh"
fi

# Create a backup info file
cat > "$BACKUP_DIR/backup_info.txt" << EOF
Backup created on: $(date)
System: $(uname -a)
User: $(whoami)
Home directory: $HOME
Distribution: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)

This backup contains:
- Shell configurations (.bashrc, .zshrc, etc.)
- Editor configurations (Neovim, LunarVim, Vim)
- Git configurations (.gitconfig, LazyGit)
- SSH configurations
- Arch Linux package lists (pacman, AUR)
- Systemd service states
- Nix packages (if applicable)

Package Restoration Commands:
# Install explicit packages:
sudo pacman -S --needed \$(cat system/pacman_explicit.txt | awk '{print \$1}')

# Install AUR packages (with yay):
yay -S --needed \$(cat system/aur_packages.txt | awk '{print \$1}')

# Install AUR packages (with paru):
paru -S --needed \$(cat system/paru_packages.txt | awk '{print \$1}')

# Restore Nix packages:
nix-env -i \$(cat system/nix_packages.txt | awk '{print \$1}')

To restore configurations:
1. Copy the files back to their original locations
2. Install the packages using the commands above
3. Run the appropriate installation script:
   - ./install/install-arch.sh (for Arch)
   - ./install/dependencies-arch.sh (for dependencies)
   - ./install/dependencies-nix.sh (for Nix-based setup)
EOF

print_success "Backup completed successfully!"
print_status "Backup location: $BACKUP_DIR"
print_status "Backup info: $BACKUP_DIR/backup_info.txt"

echo
print_warning "Important: Make sure to commit this backup to your git repository before reinstalling!"
print_warning "Run: git add . && git commit -m 'Backup before Arch reinstall'"
print_status "You can restore packages later using the commands in backup_info.txt"

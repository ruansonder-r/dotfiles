#!/bin/bash

# Dependencies Installation Script using Nix - Cross-Platform
# This script installs all necessary packages using Nix package manager
# Works on any Linux distribution that supports Nix

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

# Function to install nix package
nix_install() {
    local package="$1"
    local package_name="${2:-$1}"
    
    if command_exists "$package"; then
        print_success "$package_name is already available"
    else
        print_status "Installing $package_name via Nix..."
        nix-env -iA nixpkgs."$package" || nix-env -i "$package"
        print_success "$package_name installed successfully"
    fi
}

print_status "Installing dependencies using Nix package manager..."

# Install Nix if not present
if ! command_exists "nix-env"; then
    print_status "Installing Nix package manager..."
    curl -L https://nixos.org/nix/install | sh
    source ~/.nix-profile/etc/profile.d/nix.sh
    print_success "Nix installed successfully"
else
    print_success "Nix is already installed"
    # Source nix profile to ensure it's available
    [ -f ~/.nix-profile/etc/profile.d/nix.sh ] && source ~/.nix-profile/etc/profile.d/nix.sh
fi

# Update nix channels
print_status "Updating Nix channels..."
nix-channel --update

# Essential packages
nix_install "zsh" "Zsh"
nix_install "curl" "cURL"
nix_install "wget" "Wget"
nix_install "git" "Git"
nix_install "vim" "Vim"

# Development tools
nix_install "nodejs" "Node.js"
# Note: npm comes with nodejs in nixpkgs
nix_install "python3" "Python 3"
nix_install "python3Packages.pip" "pip"
nix_install "ruby" "Ruby"

# Terminal and editor tools
nix_install "lazygit" "LazyGit"
nix_install "htop" "htop"
nix_install "tree" "tree"
nix_install "ripgrep" "ripgrep"
nix_install "fd" "fd"
nix_install "bat" "bat"
nix_install "fzf" "fzf"
nix_install "thefuck" "thefuck"
nix_install "silver-searcher" "The Silver Searcher (ag)"

# System utilities
nix_install "brightnessctl" "brightnessctl"
nix_install "xorg.xinput" "xinput"
nix_install "expect" "expect"

# VPN tools
nix_install "openvpn" "OpenVPN"
nix_install "openfortivpn" "OpenFortiVPN"

# Install Neovim
nix_install "neovim" "Neovim"

# Install modern CLI tools
nix_install "zoxide" "zoxide"
nix_install "eza" "eza"

# Additional useful tools
nix_install "stow" "GNU Stow"
nix_install "tmux" "tmux"
nix_install "ranger" "Ranger"
nix_install "openssh" "OpenSSH"

# Install fonts
nix_install "fira-code" "Fira Code Font"
nix_install "jetbrains-mono" "JetBrains Mono Font"

# Install Oh My Zsh (this needs to be done manually as it's not a package)
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

# Install Rust via nix (alternative to rustup)
nix_install "rustc" "Rust Compiler"
nix_install "cargo" "Cargo"

# Install LunarVim (needs to be done via their installer)
if command_exists "lvim"; then
    print_success "LunarVim is already installed"
else
    print_status "Installing LunarVim..."
    bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) --yes
    print_success "LunarVim installed successfully"
fi

# Create a shell script to manage nix environment
cat > ~/.nix-dotfiles-env.sh << 'EOF'
#!/bin/bash
# Nix environment setup for dotfiles

# Source nix profile
if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
    source ~/.nix-profile/etc/profile.d/nix.sh
fi

# Add nix-installed binaries to PATH
export PATH="$HOME/.nix-profile/bin:$PATH"

# Nix-specific aliases
alias nix-update='nix-channel --update && nix-env -u'
alias nix-search='nix-env -qaP'
alias nix-install='nix-env -iA nixpkgs.'
alias nix-list='nix-env -q'
alias nix-remove='nix-env -e'
alias nix-clean='nix-collect-garbage -d'

# Initialize modern tools if available
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

if command -v thefuck >/dev/null 2>&1; then
    eval $(thefuck --alias)
fi
EOF

chmod +x ~/.nix-dotfiles-env.sh

print_success "All dependencies installed successfully via Nix!"

echo
print_status "Next steps:"
echo "1. Add 'source ~/.nix-dotfiles-env.sh' to your shell configuration"
echo "2. Run the main installation script: ./install/install.sh"
echo "3. Restart your terminal"
echo "4. Configure LunarVim by editing ~/.config/lvim/config.lua"
echo
print_status "Nix-specific notes:"
echo "- All packages are installed in ~/.nix-profile/"
echo "- Use 'nix-update' to update all packages"
echo "- Use 'nix-search <package>' to search for packages"
echo "- Use 'nix-install <package>' to install new packages"
echo "- Use 'nix-clean' to clean up old package versions"
echo "- Packages are isolated and won't conflict with system packages"
echo
print_warning "Note: Add the Nix environment script to your shell configuration:"
print_warning "echo 'source ~/.nix-dotfiles-env.sh' >> ~/.bashrc"
print_warning "echo 'source ~/.nix-dotfiles-env.sh' >> ~/.zshrc"

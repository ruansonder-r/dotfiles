# Arch Linux Setup Guide

This guide explains how to use Ruan's dotfiles on Arch-based distributions (Arch Linux, Manjaro, EndeavourOS, etc.).

## Quick Start

For a quick installation on Arch Linux:

```bash
# Clone the repository
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Make scripts executable
chmod +x install/dependencies-arch.sh
chmod +x install/install-arch.sh
chmod +x install/backup-arch.sh

# Install dependencies
./install/dependencies-arch.sh

# Install dotfiles
./install/install-arch.sh
```

## Installation Options

### Option 1: Native Arch Installation (Recommended)

Uses `pacman` and `yay` for package management:

```bash
# Install dependencies using pacman and AUR
./install/dependencies-arch.sh

# Install dotfiles with Arch-specific modifications
./install/install-arch.sh
```

### Option 2: Nix-based Installation (Cross-Platform)

Uses Nix package manager for reproducible, isolated environment:

```bash
# Install dependencies using Nix
./install/dependencies-nix.sh

# Install dotfiles (use the standard installer)
./install/install.sh
```

### Option 3: Backup Before Installation

Create a backup of your current configuration:

```bash
# Backup current system
./install/backup-arch.sh

# Then proceed with either Option 1 or 2
```

## What's Included

### Core Components
- **Shell Configuration**: Zsh with Oh My Zsh, custom aliases, and Arch-specific commands
- **Editor Setup**: Neovim with custom configuration, LunarVim
- **Git Configuration**: Custom git config with useful aliases and global gitignore
- **Modern CLI Tools**: bat, fzf, ripgrep, eza, zoxide, and more

### Arch-Specific Features

#### Package Management Aliases
```bash
pac <package>     # Install package (sudo pacman -S)
pacr <package>    # Remove package (sudo pacman -R)
pacu             # Update system (sudo pacman -Syu)
pacs <term>      # Search packages (pacman -Ss)
pacq <term>      # Query installed packages (pacman -Q | grep)
pacc             # Clean package cache (sudo pacman -Sc)
```

#### AUR Helper Aliases
```bash
yays <package>   # Install from AUR with yay
yayu            # Update AUR packages (yay -Sua)
parus <package> # Install from AUR with paru
paruu           # Update AUR packages (paru -Sua)
```

#### System Maintenance
```bash
mirrors         # Update pacman mirrors using reflector
cleanup         # Remove orphaned packages
sysinfo         # Show system information (neofetch)
diskusage       # Show disk usage (df -h)
meminfo         # Show memory info (free -h)
```

#### Enhanced File Operations
```bash
ls              # Enhanced ls with eza and icons
la              # List all files with icons
ll              # Long format with icons
tree            # Tree view with icons
fzfp            # fzf with bat preview
```

## Dependencies Installed

### Core Packages (via pacman)
- `zsh`, `curl`, `wget`, `git`, `vim`, `base-devel`
- `nodejs`, `npm`, `python`, `python-pip`, `ruby`
- `lazygit`, `htop`, `tree`, `ripgrep`, `fd`, `bat`, `fzf`
- `neovim`, `stow`, `tmux`, `ranger`, `openssh`

### AUR Packages (via yay/paru)
- `thefuck` - Command correction tool
- `paru` - Alternative AUR helper
- `nerd-fonts-fira-code` - Programming font with icons

### Rust-based Tools (via cargo)
- `zoxide` - Smart directory jumping
- `eza` - Modern replacement for ls

### Fonts
- `ttf-fira-code` - Fira Code programming font
- `ttf-jetbrains-mono` - JetBrains Mono programming font
- `nerd-fonts-fira-code` - Nerd Fonts version with icons

## Package Management

### Native Arch Packages
```bash
# Install official packages
sudo pacman -S <package>

# Update system
sudo pacman -Syu

# Search packages
pacman -Ss <search-term>

# Remove package and dependencies
sudo pacman -Rns <package>
```

### AUR Packages
```bash
# With yay
yay -S <package>
yay -Sua  # Update AUR packages

# With paru
paru -S <package>
paru -Sua  # Update AUR packages
```

### Nix Packages (if using Nix option)
```bash
# Install package
nix-env -iA nixpkgs.<package>

# Update all packages
nix-channel --update && nix-env -u

# Search packages
nix-env -qaP <search-term>

# Remove package
nix-env -e <package>

# Clean old versions
nix-collect-garbage -d
```

## Configuration Files Modified

The installer makes Arch-specific modifications to:

### Shell Configurations
- `~/.bashrc` - Arch-specific aliases and bat command fixes
- `~/.zshrc` - Enhanced with Arch package management aliases
- Removes Ubuntu-specific references (debian_chroot, chruby paths)

### System Integration
- Sets Zsh as default shell
- Configures modern CLI tool integration
- Sets up proper PATH for various package managers

## Troubleshooting

### Common Issues

1. **Permission denied for chsh**
   ```bash
   # Make sure zsh is in /etc/shells
   echo $(which zsh) | sudo tee -a /etc/shells
   chsh -s $(which zsh)
   ```

2. **Yay not found**
   ```bash
   # Install yay manually
   cd /tmp
   git clone https://aur.archlinux.org/yay.git
   cd yay
   makepkg -si
   ```

3. **LunarVim installation fails**
   ```bash
   # Install dependencies first
   sudo pacman -S nodejs npm python-pip
   # Then retry LunarVim installation
   ```

4. **Fonts not showing icons**
   ```bash
   # Install nerd fonts
   yay -S nerd-fonts-complete
   # Or specific font
   yay -S nerd-fonts-fira-code
   ```

### Backup and Recovery

Create a backup before installation:
```bash
./install/backup-arch.sh
```

The backup includes:
- All shell and editor configurations
- Pacman package lists (explicit, foreign, native)
- AUR package lists
- Systemd service states
- Nix packages (if applicable)

To restore packages from backup:
```bash
# Restore pacman packages
sudo pacman -S --needed $(cat backup_*/system/pacman_explicit.txt | awk '{print $1}')

# Restore AUR packages
yay -S --needed $(cat backup_*/system/aur_packages.txt | awk '{print $1}')
```

## Customization

### Adding New Aliases
Edit `~/.zshrc` or `~/.bashrc` and add your aliases:
```bash
# Custom aliases
alias myalias='command'
```

### Adding New Packages
```bash
# For official packages
sudo pacman -S <package>

# For AUR packages  
yay -S <package>

# For Nix packages (if using Nix)
nix-env -iA nixpkgs.<package>
```

### Modifying Package Management
Edit the installation scripts to add or remove packages:
- `install/dependencies-arch.sh` - Main package list
- `install/dependencies-nix.sh` - Nix package list

## Migration from Ubuntu

If migrating from the Ubuntu setup:

1. **Backup your current Ubuntu system**
   ```bash
   ./install/backup.sh  # Original Ubuntu backup script
   ```

2. **Install Arch setup**
   ```bash
   ./install/backup-arch.sh     # Backup current Arch state
   ./install/dependencies-arch.sh
   ./install/install-arch.sh
   ```

3. **Key differences to note**:
   - `apt` → `pacman` + `yay`/`paru`
   - `batcat` → `bat`
   - Ubuntu PPAs → AUR packages
   - Different system paths and configurations

## Additional Resources

- [Arch Wiki](https://wiki.archlinux.org/) - Comprehensive Arch documentation
- [AUR Guidelines](https://wiki.archlinux.org/title/Arch_User_Repository) - AUR usage and best practices
- [Pacman Tips](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks) - Advanced pacman usage
- [Nix Manual](https://nixos.org/manual/nix/stable/) - Nix package manager documentation

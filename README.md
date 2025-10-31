# Ruan's Dotfiles

A modern collection of personal configuration files for productive development environments on Ubuntu, Arch Linux, and other Unix-like systems.

## What's Included

- **Shell Configurations**: Zsh with Oh My Zsh, modern CLI tools (zoxide, fzf, ripgrep, bat, eza)
- **Editor Configurations**: LunarVim configuration with plugins and themes
- **Git Configurations**: Modern Git setup with aliases, colors, and global gitignore
- **Installation Scripts**: Automated dependency installation and configuration deployment

## Quick Install

### Ubuntu/Debian Systems

```bash
cd dotfiles
./install/dependencies.sh  # Install all required packages and tools
./install/install.sh        # Deploy configurations
```

### Arch Linux Systems

```bash
cd dotfiles
./install/dependencies-arch.sh  # Install packages via pacman/yay
./install/install-arch.sh        # Deploy Arch-optimized configurations
```

### Universal (Nix-based)

For any Linux distribution with Nix support:

```bash
cd dotfiles
./install/dependencies-nix.sh  # Install via Nix package manager
./install/install.sh           # Deploy configurations
```

📖 **See [ARCH_SETUP.md](ARCH_SETUP.md) for detailed Arch Linux instructions**
📋 **See [ALIASES.md](ALIASES.md) for a complete reference of all available aliases**

## Manual Installation

### 1. Install Dependencies
```bash
# Install modern CLI tools and LunarVim
./install/dependencies.sh
```

### 2. Shell Configurations
```bash
# Copy shell configs
cp shell/.bashrc ~/.bashrc
cp shell/.zshrc ~/.zshrc
cp shell/.profile ~/.profile
cp shell/.zprofile ~/.zprofile
cp shell/.zshenv ~/.zshenv
```

### 3. Editor Configurations
```bash
# Copy LunarVim config
mkdir -p ~/.config/lvim
cp editor/lunarvim/config.lua ~/.config/lvim/config.lua

# Legacy Neovim config (optional)
cp -r editor/nvim ~/.config/
```

### 4. Git Configurations
```bash
# Copy Git configs
cp git/.gitconfig ~/.gitconfig
cp git/.gitignore_global ~/.gitignore_global
cp -r git/lazygit ~/.config/
```

## Structure

```
dotfiles/
├── shell/              # Shell configurations
│   ├── .bashrc         # Bash configuration
│   ├── .zshrc          # Zsh with modern CLI tools
│   ├── .profile        # Login shell profile
│   ├── .zprofile       # Zsh profile
│   └── .zshenv         # Zsh environment
├── editor/             # Editor configurations
│   ├── lunarvim/       # LunarVim configuration
│   │   └── config.lua  # Main LunarVim config
│   └── nvim/           # Legacy Neovim config
├── git/                # Git configurations
│   ├── .gitconfig      # Git global config with modern settings
│   ├── .gitignore_global # Global gitignore patterns
│   └── lazygit/        # LazyGit configuration
├── install/            # Installation scripts
│   ├── dependencies.sh     # Ubuntu/Debian packages
│   ├── dependencies-arch.sh # Arch Linux packages
│   ├── dependencies-nix.sh  # Nix packages (universal)
│   ├── install.sh          # Deploy configurations (Ubuntu)
│   ├── install-arch.sh     # Deploy with Arch optimizations
│   ├── backup.sh           # Backup current configs (Ubuntu)
│   └── backup-arch.sh      # Backup current configs (Arch)
└── README.md
```

## Modern Tools Included

### Shell Enhancements
- **zoxide**: Smart directory navigation (`cd` replacement)
- **fzf**: Fuzzy finder for files and history
- **ripgrep** (`rg`): Fast grep replacement
- **bat**: Cat with syntax highlighting
- **eza**: Modern ls replacement with icons
- **thefuck**: Command correction tool

### Editor
- **LunarVim**: Feature-rich Neovim distribution
- **Catppuccin**: Modern color scheme
- Integrated plugins for Git, file navigation, and more

### Development Tools
- Ruby with chruby version management
- Node.js and npm
- Python 3 with pip
- Rust toolchain
- Git with modern configuration
- LazyGit for Git UI

## Usage Tips

### Modern CLI Aliases Available
- `fzfp`: fzf with bat preview for file browsing
- `cd`: Enhanced with zoxide for smart directory jumping
- `rg`: Use instead of grep for faster searching
- `bat`: Use instead of cat for syntax-highlighted output
- `eza`: Use instead of ls for better file listings

### LunarVim Features
- Leader key: `Space`
- `<leader>w`: Save file
- `<leader>q`: Quit
- `<leader>u`: Undo tree
- `<leader>a`: Add file to Harpoon
- `<C-e>`: Toggle Harpoon quick menu

### Git Aliases
- `git lg`: Pretty log with graph
- `git st`: Status
- `git co`: Checkout
- `git br`: Branch
- `git unstage`: Unstage files

## Platform-Specific Features

### Arch Linux Enhancements
- **Package Management Aliases**: `pac`, `pacu`, `yays`, `parus` for easy package operations
- **System Maintenance**: `cleanup` for orphaned packages, `mirrors` for updating mirrors
- **Enhanced File Listing**: `eza` with icons and better formatting
- **AUR Support**: Automatic `yay` and `paru` installation and usage
- **Arch-optimized Paths**: Corrected paths for Arch package locations

### Nix Integration
- **Cross-platform Compatibility**: Works on any Linux distribution
- **Isolated Environment**: Packages don't conflict with system packages
- **Reproducible Setup**: Exact package versions and dependencies
- **Easy Management**: Simple commands for package operations

## Notes

- The installation script automatically backs up existing configurations
- LunarVim will download and install plugins on first run
- Modern CLI tools are installed via the dependencies script
- Ruby development shortcuts are included for Rails projects
- VPN configurations are included but may need path adjustments
- Arch users get additional package management aliases and system maintenance tools

## License

Personal use only. 

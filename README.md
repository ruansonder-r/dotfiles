# Ruan's Dotfiles

A collection of my personal configuration files for a clean Ubuntu setup.

## What's Included

- **Shell Configurations**: Bash and Zsh configurations with aliases
- **Editor Configurations**: Neovim setup
- **Git Configurations**: LazyGit and Git configurations
- **Installation Scripts**: Automated setup scripts

## Quick Install

After cloning this repository, run:

```bash
cd dotfiles
./install/install.sh
```

## Manual Installation

### 1. Shell Configurations
```bash
# Copy shell configs
cp shell/.bashrc ~/.bashrc
cp shell/.zshrc ~/.zshrc
cp shell/.profile ~/.profile
cp shell/.zprofile ~/.zprofile
cp shell/.zshenv ~/.zshenv
```

### 2. Editor Configurations
```bash
# Copy Neovim config
cp -r editor/nvim ~/.config/
```

### 3. Git Configurations
```bash
# Copy Git configs
cp git/.gitconfig ~/.gitconfig
cp -r git/lazygit ~/.config/
```

## Structure

```
dotfiles/
├── shell/           # Shell configurations
│   ├── .bashrc
│   ├── .zshrc
│   ├── .profile
│   ├── .zprofile
│   └── .zshenv
├── editor/          # Editor configurations
│   └── nvim/
├── git/             # Git configurations
│   ├── .gitconfig
│   └── lazygit/
├── install/         # Installation scripts
│   └── install.sh
└── README.md
```

## Dependencies

- Zsh with Oh My Zsh
- Neovim
- LazyGit
- Various development tools (Ruby, Node.js, etc.)

## Notes

- Backup your existing configurations before running the install script
- Some configurations may require additional packages to be installed
- VPN configurations are included but may need path adjustments

## License

Personal use only. 

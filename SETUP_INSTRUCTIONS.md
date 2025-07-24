# Setup Instructions for After Ubuntu Reinstall

## Before Reinstalling Ubuntu

1. **Create a backup of your current setup:**
   ```bash
   cd ~/dotfiles
   ./install/backup.sh
   git add .
   git commit -m "Backup before reinstall"
   ```

2. **Push to a remote repository (GitHub, GitLab, etc.):**
   ```bash
   # Create a new repository on GitHub/GitLab
   git remote add origin <your-repo-url>
   git push -u origin master
   ```

## After Reinstalling Ubuntu

### Step 1: Clone Your Dotfiles Repository
```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

### Step 2: Install Dependencies
```bash
./install/dependencies.sh
```

### Step 3: Install Your Configurations
```bash
./install/install.sh
```

### Step 4: Restart Your Terminal
```bash
# Or simply close and reopen your terminal
source ~/.zshrc
```

### Step 5: Install Neovim Plugins
```bash
nvim +PackerSync
```

## What's Included in Your Dotfiles

### Shell Configurations
- **Bash**: `.bashrc` with aliases and customizations
- **Zsh**: `.zshrc` with Oh My Zsh theme and plugins
- **Profile files**: `.profile`, `.zprofile`, `.zshenv`

### Editor Configurations
- **Neovim**: Complete setup with plugins and configurations
- **Lua-based configuration** with Packer package manager

### Git Configurations
- **Git**: `.gitconfig` with your settings
- **LazyGit**: Terminal UI for Git

### Aliases and Customizations
Your configurations include many useful aliases:
- VPN connections for various networks
- Development shortcuts
- File management aliases
- Fun Easter eggs (like the Rick Roll alias)

## Troubleshooting

### If Zsh is not your default shell:
```bash
chsh -s $(which zsh)
```

### If Oh My Zsh plugins are missing:
```bash
# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### If Neovim plugins don't work:
```bash
# Install Packer if needed
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### If LazyGit is not installed:
```bash
sudo apt install lazygit
```

## Additional Setup

### SSH Keys
If you have SSH keys, restore them from your backup:
```bash
cp ~/dotfiles/backup_*/ssh/keys/* ~/.ssh/
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/id_*.pub
```

### VPN Configurations
Your VPN configurations are in your `.zshrc`. Make sure the paths are correct:
```bash
# Check if VPN config files exist
ls ~/bin/VPNs/
```

### Development Tools
Install additional development tools as needed:
```bash
# Ruby
sudo apt install ruby ruby-dev
gem install bundler

# Node.js
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Python
sudo apt install python3 python3-pip
```

## Backup and Restore

### Creating a New Backup
```bash
cd ~/dotfiles
./install/backup.sh
git add .
git commit -m "Backup $(date)"
git push
```

### Restoring from Backup
```bash
cd ~/dotfiles
git pull
./install/install.sh
```

## Notes

- All your configurations are now version controlled
- The installation scripts create backups before overwriting files
- You can easily add new configurations by copying them to the appropriate directory and running the install script
- The backup script captures system package lists for easy restoration

## Support

If you encounter issues:
1. Check the backup files in the `backup_*` directories
2. Review the installation logs
3. Ensure all dependencies are installed
4. Check file permissions and ownership 

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="xiong-chiamiov-plus"

plugins=( 
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Display Pokemon-colorscripts
# Project page: https://.gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r

# Ruby version management (chruby) - Ubuntu/macOS paths
if [ -f /usr/local/share/chruby/chruby.sh ]; then
    source /usr/local/share/chruby/chruby.sh
    source /usr/local/share/chruby/auto.sh
fi

# =============================================================================
# DEVELOPMENT ALIASES
# =============================================================================

# Ruby/Rails Development
alias rake='noglob rake'
alias brake='bundle exec rake'
alias checkp="ag '\s(p|puts)\s' lib helpers routes test"
alias testfile="bundle exec ruby -Ilib:test $1"
alias rr='bundle exec rerun'

# Database Management
alias drb='bundle exec rake db:rollback'
alias mrb='bundle exec rake menu:rollback'
alias dmg='bundle exec rake db:migrate'
alias mmg='bundle exec rake menu:migrate'

# Debugging
alias debugnsoffice='bundle exec rdbg --open -n -c -- bundle exec rerun'
alias debugnspack="bundle exec rdbg --open -n -c -- bundle exec rerun"

# Project-specific aliases
alias nspackdev='cd /home/ruan/dev/nspack/ ; nvim ; gnome-terminal -e lazygit'
alias deploystats='cp deploystats.sh deploystats.sh.bak && bash deploystats.sh && rm deploystats.sh'
alias que='cd ~/./dev/nspack && bundle exec que -q nspack ./app_loader.rb'

# =============================================================================
# GIT ALIASES
# =============================================================================
alias gitfiles="git status -su | awk '{sub(/^(R.*-> )|[ M?]+/,\"\")};1' | awk '!/^D/'"

# =============================================================================
# SYSTEM & HARDWARE ALIASES
# =============================================================================

# Keyboard backlight control (Dell specific)
alias kbon='brightnessctl --device '"'"'dell::kbd_backlight'"'"' set 2'
alias kboff='brightnessctl --device '"'"'dell::kbd_backlight'"'"' set 0'

# Keyboard disconnect/connect (xinput device 19)
alias disckb='xinput float 19'
alias conkb='xinput reattach 19 3'

# File operations
alias lll='ls -la'
alias alist='cat ~/.bash_aliases'

# =============================================================================
# DEVELOPMENT TOOLS
# =============================================================================

# Cursor IDE
alias cursor='nohup /home/ruan/Downloads/Cursor-1.3.9-x86_64.AppImage >/dev/null 2>&1 & disown'

# Terminal Typer
alias terminal_typer='cd terminal_typer && python3 run_terminal_typer.py'

# Modern CLI tools
alias fzfp='fzf --preview "batcat --color=always --style=numbers --line-range=:500 {}"'

# =============================================================================
# VPN CONNECTIONS
# =============================================================================

# University VPNs
alias vpnUD="echo add + after password && ~/bin/VPNs/uni/vpnuid.exp"
alias vpnUM="echo add + after password && ~/bin/VPNs/uni/vpnuim.exp"

# Client VPNs
alias vpnMC="sudo -E gpclient connect vpn.moutoncitrus.co.za"
alias vpnSR='cd ~/bin/VPNs/Sitrusrand/SRB-VPN-NoSoft6/ && sudo openvpn --config SRB-VPN.ovpn'
alias vpnHB='cd ~/bin/VPNs/Habata/NoSoft\ \(2\) && sudo openvpn --config Habata.ovpn'
alias vpnDAL='cd ~/bin/VPNs/Daltrus/ && sudo openvpn --config nosoft3_Vodacom.ovpn'
alias vpnSNR='cd ~/bin/VPNs/Sunriver/ && sudo openvpn --config SunriverOpenVPN.ovpn'
alias vpnGR='cd ~/bin/VPNs/Golden\ Ridge && sudo openfortivpn -c gr_config'
alias vpnKR='cd ~/bin/VPNs/Kromco && sudo openfortivpn -c kr_config'
alias vpnCFG='cd ~/bin/VPNs/CFG && sudo openfortivpn -c cfg_config'
alias vpnGH='cd ~/bin/VPNs/Goedehoop\ Citrus && sudo openfortivpn -c gh_config'
alias vpnOF='~/bin/VPNs/Office/./vpnOF'
alias vpnUCL='cd ~/bin/VPNs/UCL && sudo openfortivpn -c ucl_config'
alias vpnJS='cd ~/bin/VPNs/JandS/ && sudo openvpn --config sslvpn-agrigateone-client-config.ovpn'

# =============================================================================
# FUN ALIASES
# =============================================================================
alias test_rick='xdg-open "https://www.youtube.com/watch?v=dQw4w9WgXcQ&autoplay=1"'

# =============================================================================
# ENVIRONMENT INITIALIZATION
# =============================================================================

# Initialize zoxide (smart cd replacement)
eval "$(zoxide init --cmd cd zsh)"

# Initialize thefuck (command correction)
eval $(thefuck --alias)

# Kiro terminal integration
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

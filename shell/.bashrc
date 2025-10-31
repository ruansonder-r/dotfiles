# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias disckb='xinput float 19'
alias conkb='xinput reattach 19 3'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
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
alias test='xdg-open https://www.youtube.com/watch?v=dQw4w9WgXcQ'

# =============================================================================
# ENVIRONMENT INITIALIZATION
# =============================================================================

# Initialize modern tools if available
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

if command -v thefuck >/dev/null 2>&1; then
    eval $(thefuck --alias)
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# =============================================================================
# ENVIRONMENT SETUP
# =============================================================================

# Cargo environment (Rust)
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# Homebrew environment (if installed)
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi

# =============================================================================
# ADDITIONAL TOOLS
# =============================================================================

# Cursor Setup Wizard
if [ -f "/home/ruan/cursor-setup-wizard/cursor_setup.sh" ]; then
    alias cursor-setup="/home/ruan/cursor-setup-wizard/cursor_setup.sh"
fi

# Kiro terminal integration
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"

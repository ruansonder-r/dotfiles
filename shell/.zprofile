#if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#       Hyprland 
#fi
#
#chruby ruby-3.1.2
if [ -f ~/.zshrc ]; then
. ~/.zshrc
fi
chruby ruby-3.3.5

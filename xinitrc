# Path and env variables
[ -f $HOME/.envrc ] && ! [ $ENV_RC ] && . $HOME/.envrc

# Gnome keyring
dbus-update-activation-environment --systemd DISPLAY
eval $(gnome-keyring-daemon -S)
export GNOME_KEYRING_CONTROL
export SSH_AUTH_SOCK

# WM/DE
exec i3

# Path and env variables
[ -f $HOME/.envrc ] && ! [ $ENV_RC ] && . $HOME/.envrc

# Gnome keyring
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# WM/DE
exec dbus-launch i3

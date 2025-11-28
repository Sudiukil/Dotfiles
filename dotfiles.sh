#!/bin/sh

# Dotfiles management script for Linux installations

DOTFILES_ROOT="$(dirname "$(realpath "$(which "$0")")")"
SCRIPT_NAME="$(basename "$0")"

# Deploys the Dotfiles
install_dotfiles() {
  # Create config directory if it doesn't exist
  mkdir -p "$HOME/.config"

  # ZSH config
  ln -sf "$DOTFILES_ROOT/zsh/zshrc" "$HOME/.zshrc"
  ln -sf "$DOTFILES_ROOT/zsh/zshenv" "$HOME/.zshenv"
  ln -sf "$DOTFILES_ROOT/zsh/aliases.sh" "$HOME/.aliases.sh"
  ln -sf "$DOTFILES_ROOT/zsh/functions.sh" "$HOME/.functions.sh"

  # Git config
  ln -sf "$DOTFILES_ROOT/misc/gitconfig" "$HOME/.gitconfig"

  # Starship config
  ln -sf "$DOTFILES_ROOT/misc/starship.toml" "$HOME/.config/starship.toml"

  # VSCode config
  ln -sf "$DOTFILES_ROOT/vscode/settings.jsonc" "$HOME/.config/Code/User/settings.json"
  ln -sf "$DOTFILES_ROOT/vscode/keybindings-linux.jsonc" "$HOME/.config/Code/User/keybindings.json"

  # Kitty config
  mkdir -p "$HOME/.config/kitty"
  ln -sf "$DOTFILES_ROOT/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
  ln -sf "$DOTFILES_ROOT/kitty/monokai-pro-octagon.conf" "$HOME/.config/kitty/monokai-pro-octagon.conf"
  ln -sf "$DOTFILES_ROOT/kitty/quick-access-terminal.conf" "$HOME/.config/kitty/quick-access-terminal.conf"
}

# Create a symlink to this script in the user's .bin directory
install_script() {
  BIN_DIR="$HOME/.bin"

  mkdir -p "$BIN_DIR"

  ln -sf "$DOTFILES_ROOT/$SCRIPT_NAME" "$BIN_DIR/$SCRIPT_NAME"
}

case "$1" in
  -d)
    install_dotfiles
    install_script
    ;;
  *)
    echo "Usage: dotfiles.sh [-d]"
    echo "  -d: Deploy the dotfiles"
    ;;
esac

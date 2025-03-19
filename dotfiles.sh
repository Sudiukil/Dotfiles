#!/bin/sh

# Dotfiles management script for Linux installations

STATUS_FILE="/tmp/dotfiles_status.txt"
DOTFILES_ROOT="$(dirname "$(realpath "$(which "$0")")")"

# Deploys the Dotfiles
deploy() {
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
}

# Checks the status of the dotfiles and displays it
# Also caches the status in a file, so it can be ran in background and checked later
check_status() {
  cd "$DOTFILES_ROOT" || exit

  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  CHANGES=false

  # Check for local uncommitted changes
  if [ -n "$(git status -s)" ]; then CHANGES=true; fi

  # Fetch the latest changes from the remote repository
  git fetch

  # Check for local unpushed commits
  if [ -n "$(git log origin/"$CURRENT_BRANCH"..HEAD)" ]; then CHANGES=true; fi

  # Check for remote changes that need to be pulled
  if [ -n "$(git log HEAD..origin/"$CURRENT_BRANCH")" ]; then CHANGES=true; fi

  # Create the status file if it doesn't exist
  touch "$STATUS_FILE"

  # Write the status to the file
  if [ "$CHANGES" = true ]; then
    echo "OUTDATED" > "$STATUS_FILE"
  else
    echo "SYNCED" > "$STATUS_FILE"
  fi

  # Print the status
  show_status -v
}

# Show a warning if the dotfiles are outdated
show_status() {
  if [ ! -f "$STATUS_FILE" ]; then return; fi
  
  STATUS=$(cat "$STATUS_FILE")
  
  if [ "$STATUS" = "OUTDATED" ]; then
    printf "\e[33mWARN: Dotfiles are outdated.\n\e[0m"
  else
    if [ "$1" = "-v" ]; then
      printf "\e[32mDotfiles are up to date.\n\e[0m"
    fi
  fi
}

case "$1" in
  -d)
    deploy
    ;;
  -c)
    check_status
    ;;
  -w)
    show_status
    ;;
  *)
    echo "Usage: dotfiles.sh [-d | -c | -w]"
    echo "  -d: Deploy the dotfiles"
    echo "  -c: Check the status of the dotfiles"
    echo "  -w: Show a warning if the dotfiles are outdated"
    ;;
esac
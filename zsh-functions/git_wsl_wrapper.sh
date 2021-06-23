# Wrapper for Git using WSL.
# Chooses between git (Linux binary) and git.exe depending on the current path

win_root="/mnt/c" # Windows files root
git_path=$(eval "sh -c 'which git'") # Actual git binary path

git() {
  [ "${PWD#*$w_root}" != "$PWD" ] && git.exe $* && return
  $git_path $*
}
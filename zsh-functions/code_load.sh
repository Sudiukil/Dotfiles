# Load VS Code with RVM and NPM lazy loading
function code_load() {
  unalias code
  rvm_load
  nvm_load
  eval "code $*"
}

alias code="code_load"

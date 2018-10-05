# Load Vim with RVM and NPM lazy loading
vim_load() {
	unalias vim
	rvm_load
	nvm_load
	eval "vim $*"
}

alias vim="vim_load"

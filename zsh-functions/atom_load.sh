# Load Atom with RVM and NPM lazy loading
function atom_load() {
	unalias atom
	rvm_load
	nvm_load
	eval "atom $*"
}

alias atom="atom_load"

# NVM/Node/NPM lazy loading
if [ -d $HOME/.nvm ]
then
	function nvm_load {
		# Remove aliases
		unalias nvm 2> /dev/null
		for i in $(echo $nvm_bins); do unalias $i 2> /dev/null; done

		# Load NVM
		export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

		# Chain original command
		eval "$@"
	}
	
	# Aliases for all NVM/Node bins
	alias nvm="nvm_load nvm"
	nvm_bins=$(find $HOME/.nvm/versions/node/*/bin/* -printf "%f\n" | uniq)
	for i in $(echo $nvm_bins); do alias $i="nvm_load $i"; done
fi

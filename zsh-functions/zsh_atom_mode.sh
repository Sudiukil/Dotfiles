rails_env() {
	if [ $RAILS_ENV ]
	then
		echo " ($RAILS_ENV)"
	else
		echo " (development)"
	fi
}

atom_mode_prompt() {
	export RPROMPT=""
	export PROMPT="zsh"'$(rails_env)'"> "
}

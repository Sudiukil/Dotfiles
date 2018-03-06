# GitHub Pull Request
function gpr() {
	branch=$(git symbolic-ref --short HEAD 2> /dev/null)

	if [ "$branch" ]; then
		if [ "$1" ]; then onto="$1"
		else
			onto="master"
		fi

		xdg-open "$(git config --get remote.origin.url)/compare/$onto...$branch"
	else
		echo "Cannot find what branch you are in..."
	fi
}

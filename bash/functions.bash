# function
untitle () { 
	echo "restoring window title to default..."
	PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
}

weather() {
	curl -s http://wttr.in/$1 | head -n 7
	echo "('forecast' will return next 3 days of data.)"
}

forecast() {
	curl -s http://wttr.in/$1
}

dice() {
	cd ~/development/diceware
	coffee main.coffee $1
	cd -
}

# function
entitle () { 
	echo "setting window title to [$*] (fxn defined in .bashrc)..."
	echo -e "\033]2;$*\007"

	# default PS1 is \[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$
	# this sets the title bar of the window as well. If we override by calling this function, we need to redefine PS1 so that we
	# don't clobber things
	PS1='\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '

	# PS1='\e]0;\e[32m \e[33m\e[0m '
	# see http://www.thegeekstuff.com/2008/09/bash-shell-ps1-10-examples-to-make-your-linux-prompt-like-angelina-jolie/
	# \u	username
	# \h	host
	# \w	working directory
	# \e[	start of color
	# \e[m	end of color
		# Black 0;30
		# Blue 0;34
		# Green 0;32
		# Cyan 0;36
		# Red 0;31
		# Purple 0;35
		# Brown 0;33
		# [Note: Replace 0 with 1 for dark color]
	# \e[{code}m	bg color
	# \a	ascii bell (07)
	# \[	begin sequence of non-printing characters
	# \]	end sequence
	# \$	#/$, depending on UID
	# \n	newline
}

# see http://stackoverflow.com/questions/25532773/change-background-color-of-active-or-inactive-pane-in-tmux/25533057#25533057
# we could also set the active/passive bg color now!
tmux_color () {
	if [ -n "$1" ]; then
		echo "Setting current tmux pane background color to '$1': \"tmux select-pane -t:.1 -P 'fg=???,bg=$1'\" (target is optional, defaults to current)"
		tmux select-pane -P "bg=$1"
	else
		echo "No color specified";
	fi
}

# mkdir, cd into it
mkcd () {
	mkdir -p "$*"
	cd "$*"
}

# go as far into a subdir tree as you can while there is only one option
drill() {
	startDir="${PWD}"
	if [ -n "$1" ]; then
		cd "$1"
	fi

	shopt -s nullglob

	keepGoing=1

	sanity=1
	drillsMade=0
	while [ ${keepGoing} -eq 1 ]; do
		dirContents=(*)

		if [ ${#dirContents[@]} -eq 1 ]; then
			singleEl=${dirContents[0]}
			if [ -d ${singleEl} ]; then
				cd "${singleEl}"
				let drillsMade=${drillsMade}+1
			else
				# there's only one thing here but it's not a text file. We're done.
				keepGoing=0
			fi
		else
			# either nothing here, or more than one file/dir. either way, we're done
			keepGoing=0
		fi

		let sanity=${sanity}+1
		if [ ${sanity} -ge 50 ]; then
			keepGoing=0
			echo "breaking after 50 drills (${sanity})"
		fi
	done

	# cd - is busted. can we do better?
	if [ ${drillsMade} -gt 0 ];then
		# can't just set $OLDPWD since script has its own env variables. So let's just bounce back
		# and forth

		drillDir="${PWD}"
		cd "${startDir}"
		cd "${drillDir}"
		# cd -
		echo "Drilled to ${drillDir}..."
	else
		echo "Couldn't drill..."
	fi

	shopt -u nullglob
}

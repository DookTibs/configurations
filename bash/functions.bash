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

# tmux move-window
tmw() {
	tmuxPrompter.sh 'move-window -t' 'Enter destination window (<SESSION>:<WINDOW>)' $1
}

# tmux move-pane
tmp() {
	tmuxPrompter.sh 'move-pane -t' 'Enter destination pane (<SESSION>:<WINDOW>.<PANE>)' $1
}

http() {
	python -m SimpleHTTPServer $1
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
tmux_backcolor () {
	if [ -n "$1" ]; then
		# echo "Setting current tmux pane background color to '$1': \"tmux select-pane -t:.1 -P 'fg=???,bg=$1'\" (target is optional, defaults to current)"
		echo "Setting current tmux pane background color to '$1'. Use 'tf' to set foreground color and 'colorTest.sh' to see options. Use 'default' as color to undo."
		tmux select-pane -P "bg=$1"
	else
		echo "No color specified";
	fi
}

tmux_forecolor () {
	if [ -n "$1" ]; then
		echo "Setting current tmux pane foreground color to '$1'. Use 'tb' to set background color and 'colorTest.sh' to see options. Use 'default' as color to undo."
		tmux select-pane -P "fg=$1"
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

# optional arg #1 = color, arg #2 = times to blink
tmux_blink() {
	currentPane=$TMUX_PANE
	if [ -z $1 ]; then
		BLINK_COLOR="red"
	else
		BLINK_COLOR="${1}"
	fi

	if [ -z $2 ]; then
		NUM_ITERATIONS=3
	else
		NUM_ITERATIONS=$2
	fi

	for (( i=1; i<=$NUM_ITERATIONS; i++ )); do
		tmux select-pane -t "${currentPane}" -P "bg=${BLINK_COLOR},fg=white"
		sleep .1 
		tmux select-pane -t "${currentPane}" -P "bg=default,fg=default"
		sleep .1
	done
}

function pretty_csv {
    perl -pe 's/((?<=,)|(?<=^)),/ ,/g;' "$@" | column -t -s, | less  -F -S -X -K
}

lowerextension() {
	extensionCaseChanger.sh lower "$@"
}

upperextension() {
	extensionCaseChanger.sh upper "$@"
}

initConda() {
    __conda_setup="$('/Users/tfeiler/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/tfeiler/opt/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/tfeiler/opt/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/tfeiler/opt/anaconda3/bin:$PATH"
        fi
    fi

	echo "Conda activated via initConda (defined in functions.bash)"
	echo "'conda info --envs' to list environments"
	echo "'conda activate <hawc2020>' to activate specific environment"
    unset __conda_setup
}

rpn() {
	# first bit just adds and pops a dummy value from the stack to set precision. Kludgey.
	# then we put the arguments onto the stack
	# then we print
	#
	# pipe that whole command to "dc" and echo out the result.
	#
	# Usage:
	#    rpn 4 5 +
	#	 > "4 5 + == 9"
	#
	#	rpn 20 3 /
	#	> "20 3 / == 6.6"
	#
	#	rpn "1.1 2.2 *"
	#	> "1.1 2.2 * == 2.4"
	res=$(echo "1.00000 k $* p" | dc)
	echo "$* == $res"
}

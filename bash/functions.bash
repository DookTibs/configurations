# function
untitle () { 
	echo "restoring window title to default..."
	PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
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


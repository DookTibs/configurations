# function

# AWS SSO (https://docs.aws.amazon.com/cli/latest/userguide/sso-configure-profile-token.html#sso-configure-profile-token-auto-sso) is nice but requires you to do things like tack on "--profile X" on your command.
# I want to assume the session; I think this does it, by exporting credentials as environment variables.
#
# at a shall we can just do "aws_sso_login staging" and it will wildcard search and get us set in that shell
# (logging us in if needed; setting env variables either way), and then we can run aws CLI commands, use
# boto3, etc. without having to append "--profile X" onto everything, it will just be the default in that shell.
aws_sso_login () {
	if [ -z $1 ]; then
		echo "AVAILABLE SSO SETUPS:"
		cat ~/.aws/config | grep "\[sso-session" | sed 's/\[sso-session //' | sed 's/\]//'

		echo ""
		echo "(To configure a new one, add a section in ~/.aws/config)"
	else
		IFS=$'\n' read -r -d '' -a matching_sessions < <( cat ~/.aws/config | grep "\[sso-session.*\]" | sed 's/\[sso-session //' | sed 's/\]//' | grep $1 && printf '\0' )
		echo "SESSIONS IS ${matching_sessions}"

		num_matches=${#matching_sessions[@]}
		# echo "num matches is ${num_matches}"
		if [ $num_matches -eq 0 ]; then
			echo "No matches found for argument '$1'; not doing sso setup"
		elif [ $num_matches -eq 1 ]; then
			session_name="${matching_sessions[0]}"

			echo "proceed with session '$session_name'..."

			# two steps here -- [ONE] need to figure out the [profile Y] that goes with [sso-session X]
			# so we know the name of the AWS profile. Need that to proceed.

			# profile_name=`cat  ~/.aws/config | awk -v target_config_field="profile_name" -v target_aws_session="litstream_staging_admin_sso" -f ~/development/shellScripts/awsConfigExtracter.awk`
			profile_name=`cat  ~/.aws/config | awk -v target_config_field="profile_name" -v target_aws_session="$session_name" -f ~/development/shellScripts/awsConfigExtracter.awk`
			if [ $? -eq 0 ]; then
				# echo "found profile name '${profile_name}'"

				# [TWO] need to know if we're logged in already; if export-credentials worked, we are.
				# If we are, just set some environment variables. If we're not, log in - and THEN set some
				# environment variables.

				# aws configure export-credentials --profile ${profile_name} --format env 2>&1 /dev/null
				echo "checking current login status for '${session_name}' / '${profile_name}'"
				logged_in=0

				aws configure export-credentials --profile ${profile_name} --format env 1> /dev/null

				if [ $? -eq 0 ]; then
					echo "already logged in"
					logged_in=1
				else
					echo "not logged in; check your browser..."
					aws sso login --sso-session ${session_name}

					if [ $? -eq 0 ]; then
						logged_in=1
					fi
				fi

				if [ $logged_in -eq 1 ]; then
					echo "setting environment variables..."
					eval $(aws configure export-credentials --profile ${profile_name} --format env)
					echo "done! run 'aws sso logout' to logout..."
				
					aws sts get-caller-identity --output table
				else
					echo "sso setup failed."
				fi

			fi
			
		else
			echo "Ambiguous session name; multiple matches found for argument '$1'; not changing"
		fi
	fi
}

assume_aws_profile () {
	if [ -z $1 ]; then

		if [ -z $AWS_PROFILE ]; then
			echo 'No profile specified/no change being made. No profile set as $AWS_PROFILE; using default.'
		else
			echo "No profile specified/no change being made. Profile '$AWS_PROFILE' currently active."
		fi

		echo "AVAILABLE PROFILES:"
		cat ~/.aws/credentials | grep "\[.*\]" | sed 's/\[//' | sed 's/\]//' | sed 's/^/\t/'

	else
		# profile_to_use="$1"

		# new way - let's look for matches on the supplied argument!
		# https://stackoverflow.com/questions/11426529/reading-output-of-a-command-into-an-array-in-bash
		IFS=$'\n' read -r -d '' -a profiles < <( cat ~/.aws/credentials | grep "\[.*\]" | sed 's/\[//' | sed 's/\]//' | grep $1 && printf '\0' )

		num_matches=${#profiles[@]}

		if [ $num_matches -eq 0 ]; then
			echo "No matches found for argument '$1'; not switching profiles"
		elif [ $num_matches -eq 1 ]; then
			profile_to_use="${profiles[0]}"

			echo "Assuming role '$profile_to_use'..."
			export AWS_PROFILE=$profile_to_use
		else
			echo "Ambiguous profile; multiple matches found for argument '$1'; not switching profiles"
		fi

	fi

	aws sts get-caller-identity --output table
}

# once I'm logged in via e.g. aws_sso_login, maybe I want to assume a role that that Principal has access to? Supply the name and this function will do it!
assume_aws_role() {
	accountId=`aws sts get-caller-identity --output json | jq -r '.Account'`

	if [ -z $1 ]; then
		echo "Please supply a role to assume under account id $accountId"
	else
		roleToAssume="$1"
		# echo "Checking details on role '$roleToAssume' under account id $accountId..."
		# resp=`aws iam get-role --role-name $roleToAssume`
		# maxDuration=`echo "$resp" | jq -r '.Role.MaxSessionDuration'`

		# python -c "print('Role found; assuming with duration of ' + str($maxDuration / 60 / 60) + ' hours')"
		maxDuration=3600 # during role-chaining, we are limited to one hour, no matter what max we've defined. :-(

		resp=`aws sts assume-role --duration-seconds $maxDuration --role-arn arn:aws:iam::$accountId:role/$roleToAssume --role-session-name session_$roleToAssume`

		# echo "RESPONSE IS '$resp'"

		accessKey=`echo "$resp" | jq -r '.Credentials.AccessKeyId'`
		secretKey=`echo "$resp" | jq -r '.Credentials.SecretAccessKey'`
		sessionToken=`echo "$resp" | jq -r '.Credentials.SessionToken'`

		export AWS_ACCESS_KEY_ID="${accessKey}"
		export AWS_SECRET_ACCESS_KEY="${secretKey}"
		export AWS_SESSION_TOKEN="${sessionToken}"

		echo "You have assumed the following role:"
		aws sts get-caller-identity
	fi
}

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

# tmux pwd - returns the working directory of a targetted tmux pane
# useful for things like:
# cp *.txt `tpwd DRAGON:1.0`
tpwd() {
	tmux display-message -p -F "#{pane_current_path}" -t$1
}

http() {
	# python 2
	# python -m SimpleHTTPServer $1

	# python 3
	python -m http.server $1
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

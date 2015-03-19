declare -x REASON_WSG="/Users/tfeiler/remotes/wsgTfeilerReasonCore/reason_package_20140404"
declare -x REASON_VENT="/Users/tfeiler/remotes/ventnorTfeilerReason/reason_package"
declare -x MOODLE_WSG="/Users/tfeiler/remotes/wsgTfeilerMoodle"

alias rps='source /Users/tfeiler/development/shellScripts/special/rps.sh'

# see http://osxfuse.github.io/
alias smount_moodle="mountSsh.sh $_CARL_MY_USERNAME@$_DEV_MOODLE_SERVERNAME:$_SERVPATH_MOODLE wsgTfeilerMoodle 22"
alias smount_wsg="mountSsh.sh $_CARL_MY_USERNAME@$_DEV_MOODLE_SERVERNAME:$_SERVPATH_MOODLECORE wsgTfeilerReasonCore 22"
alias smount_vent="mountSsh.sh $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME:$_SERVPATH_SLOTE ventnorTfeilerReason 22"
alias smount_clamp="mountSsh.sh $_CARL_MY_USERNAME@$_CLAMP_SERVERNAME:$_SERVPATH_CLAMP mitreClampHome 22"
alias smount_comps="mountSsh.sh $_CARL_MY_USERNAME@$_LIVE_COMPS_SERVERNAME:$_SERVPATH_COMPS persiaComps 22"
alias smount_omeka="mountSsh.sh $_CARL_MY_USERNAME@$_DEV_OMEKA_SERVERNAME:$_SERVPATH_OMEKA wsgOmeka 22"

# ssh shortcuts
alias ssh_wsg="ssh -2 $_CARL_MY_USERNAME@$_DEV_MOODLE_SERVERNAME"
# alias ssh_vent="ssh -2 $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME"
alias ssh_persia="ssh -2 $_CARL_MY_USERNAME@$_LIVE_COMPS_SERVERNAME"
# alias ssh_chi="ssh -2 $_CARL_MY_USERNAME@$_LIVE_APPS_SERVERNAME"
alias ssh_chi5="ssh -2 $_CARL_MY_USERNAME@$_LIVE_WWW_SERVERNAME"
alias ssh_mitre="ssh -2 $_CARL_MY_USERNAME@mitre.clamp-it.org"

# for example, if I'm in:
# /Users/tfeiler/remotes/ventnorTfeilerReason/reason_package_local/local/minisite_templates/modules/
# this will return:
# "reason_package_local/local/minisite_templates/modules"
getReasonLocalRelativePath() {
	local rv=`pwd | grep "/Users/tfeiler/remotes/ventnorTfeilerReason/" | sed 's-.*ventnorTfeilerReason/\(.*\)-\1-'`
	echo "$rv"
}

# new ssh_vent approach - if we're in my dev reason area, cd there! If we pass along a command, execute it!
# this lets me do neat stuff like jump from my dev area right to the relevant dir on ventnor/chicago if I need
# to see what's going on there. Or, like when in modules, I can do something like:
# "ssh_vent svn log attendance_tracker.php"
# and run that command on the server in the right relevant dir. Very handy.
# if I'm not in my dev reason install, just run ssh as usual
reason_ssh() {
	magicCode=$1
	user=$2
	server=$3
	remoteBaseDir=$4
	sshArgs=$5

	if [ "${magicCode}" != "kwijybo" ] || [ -z "${remoteBaseDir}" ]; then
		# echo "args user=[${user}], server=[${server}], basedir=[${remoteBaseDir}], sshargs=[${sshArgs}]"
		echo "Please don't call this function directly unless you really know what you're doing..."
		return 1
	fi


	reasonPath=$(getReasonLocalRelativePath)

	cmd="ssh -2 $user@$server"

	if [ "" != "${reasonPath}" ]; then
		cmd="${cmd} \"cd ${remoteBaseDir}/${reasonPath} ;"

		# are there arguments? 
		if [ -z "${sshArgs}" ]; then
			# no args; let's add a "-t" to the ssh command to force a terminal since
			# we want to stay logged in
			cmd=`echo "${cmd}" | sed 's/ssh/ssh -t/'`
			cmd="${cmd} bash\""
		else
			# there are args; we're just trying to run a command
			# echo "SUB ARGS [${sshArgs}]"
			cmd="${cmd} ${sshArgs}\""
		fi
	else
		# just tack on args and call it a day
		cmd="${cmd} ${sshArgs}"
	fi

	echo "Running ssh command: [${cmd}]"

	eval $cmd
}

ssh_chi() {
	reason_ssh "kwijybo" "$_CARL_MY_USERNAME" "$_LIVE_APPS_SERVERNAME" "${_SERVPATH_REASON_PROD}" "${*}"
}

ssh_vent() {
	reason_ssh "kwijybo" "$_CARL_MY_USERNAME" "$_DEV_RSN_SERVERNAME" "${_SERVPATH_REASON_MYDEV}" "${*}"
}


# mysql aliases
alias mysql_vent="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'mysql -u$_DEV_RSN_DB_USER -p$_DEV_RSN_DB_PASS $_DEV_RSN_DB_NAME_MYDEV'"
alias mysql_ventTest="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'mysql -u$_DEV_RSN_DB_USER -p$_DEV_RSN_DB_PASS $_DEV_RSN_DB_NAME_TEST'"
alias mysql_mbsOld="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'mysql -u$_DEV_MBS_DB_USER -p$_DEV_MBS_DB_PASS $_DEV_MBS_DB_NAME'"
alias mysql_moodle="ssh -t $_CARL_MY_USERNAME@$_DEV_MOODLE_SERVERNAME 'mysql -u$_DEV_MOODLE_DB_USER -p$_DEV_MOODLE_DB_PASS $_DEV_MOODLE_DB_NAME'"
alias mysql_thor="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'mysql -u$_DEV_RSN_DB_USER -p$_DEV_RSN_DB_PASS $_DEV_RSN_DB_NAME_THORDEV'"
alias mysql_doc="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'mysql -u$_DOC_DB_USER -p$_DOC_DB_PASS $_DOC_DB_NAME -h$_CARLETON_LIVE_MYSQL_SERVER'"

alias errorlog_vent="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'tail -f $_SERVPATH_ERRLOG'"

alias moodleCheck='~/development/moodle/tools/PHP_CodeSniffer-2.0.0a2/scripts/phpcs --standard=/Users/tfeiler/development/moodle/tools/moodleCodeChecker/moodle/ruleset.xml'

alias goremotes='cd ~/remotes/'
alias goslote='cd ~/remotes/ventnorTfeilerReason/'
alias gotemplates='cd ~/remotes/ventnorTfeilerReason/reason_package_local/local/minisite_templates'
alias gomodules='cd ~/remotes/ventnorTfeilerReason/reason_package_local/local/minisite_templates/modules'
alias goform='cd ~/development/jsloteFormBuilder/formbuilder-rsn'
alias goomeka='cd ~/remotes/wsgOmeka/'

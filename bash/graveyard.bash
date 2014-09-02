# declare -x MAVEN_OPTS='-Djava.net.preferIPv4Stack=true'

if [ ${OSTYPE} = "cygwin" ]; then
	declare -x TOM_OS="cygwin"
elif [ `uname` = "Darwin" ]; then
	declare -x TOM_OS="osx"
fi


if [ ${TOM_OS} = "cygwin" ]; then
	declare -x CHROMIX='/cygdrive/c/development/tools/chromix-master'

	# alias flashlog='tail -f /cygdrive/c/Users/tfeiler/AppData/Roaming/Macromedia/Flash\ Player/Logs/flashlog.txt'
	# alias vilog='vi /cygdrive/c/Users/tfeiler/AppData/Roaming/Macromedia/Flash\ Player/Logs/flashlog.txt'
elif [ ${TOM_OS} = "osx" ]; then
	declare -x CHROMIX="/usr/local/lib/node_modules/chromix/snapshots/"
	alias chromelog='tail -f /Users/tfeiler/Library/Application\ Support/Google/Chrome/chrome_debug.log'
	alias chromelogClean='chromelog | filterChromeConsole.sh'

	# alias flashlog='tail -f /Users/tfeiler/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt'
	# alias vilog='vi /Users/tfeiler/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt'
	alias xvlog='vi /var/log/system.log'
	alias xlog='tail -f /var/log/system.log'
fi

# let's set up tunnelling for accessing MySQL. See http://www.sitepoint.com/how-to-administer-a-remote-mysql-database-using-ssh-tunneling/ for some details.
# I had already set up a lot of stuff like password-less login previously. This lets me use MySQLWorkbench on remote db easily
# alias tunnel_exampleSQL='ssh -L localhost:3307:<HOSTNAME>:3306 -N -f <HOSTNAME>'
# never mind - MySQLWorkbench can tunnel on its own.

# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
# alias df='df -h'
# alias du='du -h'
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
# alias grep='grep --color'                     # show differences in colour
# alias egrep='egrep --color=auto'              # show differences in colour
# alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
# alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
# alias ll='ls -l'                              # long list
# alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'                              #

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle () 
# { 
#   echo -ne "\e]2;$@\a\e]1;$@\a"; 
# }
# 
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
# cd_func ()
# {
#   local x2 the_new_dir adir index
#   local -i cnt
# 
#   if [[ $1 ==  "--" ]]; then
#     dirs -v
#     return 0
#   fi
# 
#   the_new_dir=$1
#   [[ -z $1 ]] && the_new_dir=$HOME
# 
#   if [[ ${the_new_dir:0:1} == '-' ]]; then
#     #
#     # Extract dir N from dirs
#     index=${the_new_dir:1}
#     [[ -z $index ]] && index=1
#     adir=$(dirs +$index)
#     [[ -z $adir ]] && return 1
#     the_new_dir=$adir
#   fi
# 
#   #
#   # '~' has to be substituted by ${HOME}
#   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
# 
#   #
#   # Now change to the new dir and add to the top of the stack
#   pushd "${the_new_dir}" > /dev/null
#   [[ $? -ne 0 ]] && return 1
#   the_new_dir=$(pwd)
# 
#   #
#   # Trim down everything beyond 11th entry
#   popd -n +11 2>/dev/null 1>/dev/null
# 
#   #
#   # Remove any other occurence of this dir, skipping the top of the stack
#   for ((cnt=1; cnt <= 10; cnt++)); do
#     x2=$(dirs +${cnt} 2>/dev/null)
#     [[ $? -ne 0 ]] && return 0
#     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#     if [[ "${x2}" == "${the_new_dir}" ]]; then
#       popd -n +$cnt 2>/dev/null 1>/dev/null
#       cnt=cnt-1
#     fi
#   done
# 
#   return 0
# }
# 
# alias cd=cd_func


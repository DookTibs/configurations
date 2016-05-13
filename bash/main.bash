# \vi will call the real vi not the alias.
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim' # use homebrew vi 7.4.258 instead of 7.3 stock
alias vi='vim'
alias vit='vim -t' # start with a tag
alias ls='ls -ltrG'
alias tmux='tmux -2' # force tmux to recognize 256 color display

if [ "${OSTYPE}" = "cygwin" ]; then
	declare -x TOM_OS="cygwin"
elif [ `uname` = "Darwin" ]; then
	declare -x TOM_OS="osx"
fi

if [ "${TOM_OS}" = "cygwin" ]; then
	declare -x CHROMIX='/cygdrive/c/development/tools/chromix-master'
elif [ "${TOM_OS}" = "osx" ]; then
	declare -x CHROMIX="/usr/local/lib/node_modules/chromix/snapshots/"
	alias chromelogRaw='echo "" ; echo "##### if no results - did you remember to launch Chrome with [open -a \"Google Chrome.app\" --args --enable-logging --v=1]? #####" ; echo ""; tail -f /Users/tfeiler/Library/Application\ Support/Google/Chrome/chrome_debug.log'
	alias chromelog='chromelogRaw | filterChromeConsole.sh'
fi

# use vi for shell editing
set -o vi

# declare -x PS1="\h:\W \u\$ "
declare -x PS1="[\u@office \W]$ "

declare -x BREW="/usr/local/Cellar"

# maybe instead of ctags on its own do /usr/local/bin ?
declare -x PATH=/usr/local/bin:${PATH}:${HOME}/development/shellScripts

# FIXED - /usr/local/share/npm/bin is where executables for globally installed npm packages end up
declare -x PATH=${PATH}:/usr/local/share/npm/bin/:/usr/local/mysql/bin

# git aliases
alias diffgit='git difftool --no-prompt'
alias ghost='/usr/local/bin/gs' # this is the ghostscript default. Saving it here in case I do need it for something
alias gs='clear ; git status'
alias gb='git branch'
alias st='gs'
alias dg='diffgit'
alias diffgitb='git difftool -t bc3 --no-prompt'
alias diffgitv='git difftool -t vimdiff --no-prompt'
alias diffgitdir='git bcdiff'

# tmux aliases
# alias tmass="~/screenConfigs/tmux/assetPipeline.sh"
# alias tmang="~/screenConfigs/tmux/angular.sh"
alias tt="tmux attach -t"
alias ta="tt"
alias tl="tmux ls"
alias tn="tmux new -s"
alias tc="clear ; tmux clear-history"
alias tb="tmux_color"

alias goscripts='cd ~/development/shellScripts/'

# talking to my machine at home...
# tunnel_home forwards local traffic on port $_VNC_LOCAL_PORT to my machine at home over port $_TJF_HOME_VNC_PORT
# Uses port $_TJF_HOME_SSH_PORT for ssl tunnel.
# that way VNC traffic is encrypted with ssl
alias ssh_home="ssh -p $_TJF_HOME_SSH_PORT $_TJF_HOME_USERNAME@$_TJF_HOME_HOST"
alias tunnel_home="ssh -L localhost:$_VNC_LOCAL_PORT:$_TJF_HOME_HOST:$_TJF_HOME_VNC_PORT -N -f -p $_TJF_HOME_SSH_PORT $_TJF_HOME_USERNAME@$_TJF_HOME_HOST"
alias vnc_home="open vnc://localhost:$_VNC_LOCAL_PORT"


# run irssi with various statusbars hidden
alias irssi_slim="irssi --config=~/.irssi/slim_config"

# changed to be a function
# alias dice="cd ~/development/diceware ; coffee main.coffee ; cd -"

declare -x PATH=${PATH}:~/development/pebble-dev/pebble-sdk-4.2-mac/bin

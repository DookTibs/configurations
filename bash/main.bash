# make OSX stop complaining about me using bash instead of zsh
export BASH_SILENCE_DEPRECATION_WARNING=1

# \vi will call the real vi not the alias.
# alias vim='/Applications/MacVim.app/Contents/MacOS/Vim' # use homebrew vi 7.4.258 instead of 7.3 stock
# OSX installs to /usr/bin/vim. As of 2018-12-11 I use a Homebrew version at /usr/local/bin/vim
alias vi='vim'
alias awk='gawk'
alias vit='vim -t' # start with a tag
alias ls='ls -ltrGpFh'
alias tmux='tmux -2' # force tmux to recognize 256 color display
alias qcsv="q -d ',' -H -O"

alias findname='find . -name'

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
# declare -x PS1="[\u@office \W]$ "
declare -x PS1="[tfeiler@ICF \W]$ "

declare -x BREW="/usr/local/Cellar"

# maybe instead of ctags on its own do /usr/local/bin ?
declare -x PATH=/usr/local/bin:${PATH}:${HOME}/development/shellScripts:${HOME}/development/shellScripts/qutils

# FIXED - /usr/local/share/npm/bin is where executables for globally installed npm packages end up
declare -x PATH=${PATH}:/usr/local/share/npm/bin/:/usr/local/mysql/bin

# git aliases
alias diffgit='git difftool --no-prompt'
alias ghost='/usr/local/bin/gs' # this is the ghostscript default. Saving it here in case I do need it for something
alias gs='clear ; git status'
alias gr='clear ; git remote -v'
alias gd="tc ; git diff $1"
alias gb='git branch'
alias st='gs'
alias dg='diffgit'
alias diffgitb='git difftool -t bc3 --no-prompt'
alias diffgitv='git difftool -t vimdiff --no-prompt'
alias diffgitdir='git bcdiff'
# show branches sorted by recent modification
alias gbs='for k in `git branch|perl -pe s/^..//`;do echo -e `git show --pretty=format:"%Cgreen%ci %C(cyan)%cr%Creset" $k|head -n 1`\\t$k;done|sort -r'

# tmux aliases
# alias tmass="~/screenConfigs/tmux/assetPipeline.sh"
# alias tmang="~/screenConfigs/tmux/angular.sh"
alias tt="tmux attach -t"
alias tclone="tmux new-session -t" # detach and use 'tmux kill-session -t <SESSION_NAME>' when you're done. I can use this to link windows for the same session in multiple monitors, so I can have
									# multiple terminals open and each on a different window of the same session. See http://unix.stackexchange.com/questions/24274/attach-to-different-windows-in-session
alias ta="tt"
alias tl="tmux ls"
alias tn="tmux new -s"
alias tc="clear ; tmux clear-history"
alias tb="tmux_backcolor"
alias tf="tmux_forecolor"
alias tra="tmux -L NvimR attach -t NvimR" # attach to the NvimR socket server tmux instance

# changed to be functions so we can optionally pass in a value...
# alias tmw="tmuxPrompter.sh 'move-window -t' 'Enter destination window (<SESSION>:<WINDOW>)'"
# alias tmp="tmuxPrompter.sh 'move-pane -t' 'Enter destination pane (<SESSION>:<WINDOW>.<PANE>)'"

alias goscripts='cd ~/development/shellScripts/'

# talking to my machine at home...
# tunnel_home forwards local traffic on port $_VNC_LOCAL_PORT to my machine at home over port $_TJF_HOME_VNC_PORT
# Uses port $_TJF_HOME_SSH_PORT for ssl tunnel.
# that way VNC traffic is encrypted with ssl
alias ssh_home="ssh -p $_TJF_HOME_SSH_PORT $_TJF_HOME_USERNAME@$_TJF_HOME_HOST"
alias tunnel_home="ssh -L localhost:$_VNC_LOCAL_PORT:$_TJF_HOME_HOST:$_TJF_HOME_VNC_PORT -N -f -p $_TJF_HOME_SSH_PORT $_TJF_HOME_USERNAME@$_TJF_HOME_HOST"

if [ "${TOM_OS}" = "cygwin" ]; then
	alias vnc_home="/cygdrive/c/Program\ Files/RealVNC/VNC\ Viewer/vncviewer.exe localhost:$_VNC_LOCAL_PORT"
elif [ "${TOM_OS}" = "osx" ]; then
	alias vnc_home="open vnc://localhost:$_VNC_LOCAL_PORT"
fi

# run irssi with various statusbars hidden
alias irssi_slim="irssi --config=~/.irssi/slim_config"

# changed to be a function
# alias dice="cd ~/development/diceware ; coffee main.coffee ; cd -"

alias list_ssh_aliases="cat ~/.ssh/* | grep \"Host \" | awk '{ print \$2 }' | sort | uniq"

# declare -x PATH=${PATH}:~/development/pebble-dev/pebble-sdk-4.2-mac/bin
declare -x PATH=${PATH}:~/development/tools/gtags_bin

alias ngrok="/Users/tfeiler/development/tools/ngrok/ngrok"

# 202107 - python3 is now the default
# alias mkvirtualenv2='mkvirtualenv --python=`which python2`'
# alias mkvirtualenv3='mkvirtualenv --python=`which python3`'

# 20211117 -- try it again, now use pyenv
# old virtual envs work fine, but going forward make sure you have pyenv set to the correct
# version and then make a virtual env based on that.
# "pyenv install -l" to list possible versions to install
# "pyenv install 1.2.3" to install a specific version
# "pyenv versions" to list installed versions
# "pyenv shell 1.2.3" to switch to an installed version in just the current shell
# "pyenv local 1.2.3" to persistently set the current directory to use that version
# edit ~/.penv/version to set the system default; 3.9.7 as of this writing
#
# this alias will use whatever the currently active pyenv version is to build the virtual env
alias mkvirtualpyenv='mkvirtualenv --python=`pyenv which python`'

declare -x PATH=${PATH}:/Users/tfeiler/bin

# 202108 - start using Neovim for LSP support
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'

# current Mac has Python2 and 3.8 preinstalled. I homebrew'ed 3.9
declare -x PATH=/usr/local/share/python:${PATH}

declare -x EDITOR=nvim

alias excel="open -a /Applications/Microsoft\ Excel.app/"

alias yaml_to_json="yq eval -j"
alias json_to_yaml="yq eval -P"

# generates a random number between 1 and supplied number, inclusive
alias random="jot -r 1 1 $1"

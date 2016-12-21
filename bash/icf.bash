declare -x PATH=${PATH}:/cygdrive/c/development/tools/ctags58/
declare -x PATH=${PATH}:/cygdrive/c/development/tools/apache-maven-3.3.9/bin/
declare -x PATH=${PATH}:/cygdrive/c/Program\ Files/nodejs/

declare -x ECLIPSE_HOME=/cygdrive/c/Users/38593/eclipse/neon/eclipse/
alias go_eclipse="cd $ECLIPSE_HOME"

declare -x WORKSPACE=/cygdrive/c/Users/38593/workspace/
alias go_workspace="cd $WORKSPACE"

declare -x ONEDRIVE_HOME="/cygdrive/c/Users/38593/OneDrive for Business/"
alias go_onedrive='cd "$ONEDRIVE_HOME"'

alias launch_eclimd="go_eclipse; ./eclimd.bat"

alias open="explorer.exe ."

alias start_mongo_server="/cygdrive/c/Program\ Files/MongoDB/Server/3.4/bin/mongod.exe --dbpath C:/development/mongo_datadir"
alias mongo="/cygdrive/c/Program\ Files/MongoDB/Server/3.4/bin/mongo.exe"

alias start_mysql_server="echo 'mysqladmin -uroot shutdown to kill...' ; mysqld_safe &"

alias go_notes='cd "$ONEDRIVE_HOME/notes"'

alias go_ahk='cd "/cygdrive/c/development/AHK Scripts"'

declare -x PATH=${PATH}:/cygdrive/c/development/tools/ctags58/
declare -x PATH=${PATH}:/cygdrive/c/development/tools/apache-maven-3.3.9/bin/
declare -x PATH=${PATH}:/cygdrive/c/Program\ Files/nodejs/

declare -x GOOGLE_APPLICATION_CREDENTIALS=~/development/acc/serviceAccount.json

# virtualenv for python
declare -x WORKON_HOME=${HOME}/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

declare -x ECLIPSE_HOME=/cygdrive/c/Users/38593/eclipse/neon/eclipse/
alias goeclipse="cd $ECLIPSE_HOME"

declare -x WORKSPACE=/cygdrive/c/Users/38593/workspace/
alias goworkspace="cd $WORKSPACE"

declare -x ONEDRIVE_HOME="/cygdrive/c/Users/38593/OneDrive for Business/"
alias goonedrive='cd "$ONEDRIVE_HOME"'

alias launch_eclimd="goeclipse; ./eclimd.bat"

alias open="explorer.exe ."

alias start_mongo_server="/cygdrive/c/Program\ Files/MongoDB/Server/3.4/bin/mongod.exe --dbpath C:/development/mongo_datadir"
alias mongo="/cygdrive/c/Program\ Files/MongoDB/Server/3.4/bin/mongo.exe"

alias start_mysql_server="echo 'mysqladmin -uroot shutdown to kill...' ; mysqld_safe &"

alias gonotes='cd "$ONEDRIVE_HOME/notes"'

alias ls='ls -ltrG --color=auto'

declare -x DRAGON_HOME="/cygdrive/c/Users/38593/workspace/icf_dragon/"
declare -x DRAGON_JAVA_HOME="${DRAGON_HOME}src/main/java/com/icfi/dragon/web/"
declare -x DRAGON_TEMPLATES_HOME="${DRAGON_HOME}src/main/webapp/templates/"
alias godragon="cd $DRAGON_HOME"
alias godragonjava="cd ${DRAGON_JAVA_HOME}"
alias godragontemplates="cd ${DRAGON_TEMPLATES_HOME}"

declare -x TOMCAT_HOME="/cygdrive/c/development/tomcat/apache-tomcat-9.0.0.M15/"
alias gotomcat="cd $TOMCAT_HOME"

alias goapi="cd ~/development/dragon_api"
alias goapimain="cd ~/development/dragon_api/src/aws_lambda/main/python"

clippaste() {
	cat /dev/clipboard > $1
}

alias psql_dragon_dev="psql -h dbinstance.c5vzduwbgj5d.us-east-1.rds.amazonaws.com -p 5432 -d dragon -U dbadmin"

alias psql_dragon_staging="psql -h dragon-postgresql-stage.c5vzduwbgj5d.us-east-1.rds.amazonaws.com -p 5432 -d stagedb -U dbadmin"

alias psql_dragon_production="psql -h icfdragon-1.c5vzduwbgj5d.us-east-1.rds.amazonaws.com -p 5432 -d dragon -U dragon"



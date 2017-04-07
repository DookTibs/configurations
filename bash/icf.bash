declare -x PATH=${PATH}:~/bin/
declare -x PATH=${PATH}:/cygdrive/c/development/tools/ctags58/
declare -x PATH=${PATH}:/cygdrive/c/development/tools/apache-maven-3.3.9/bin/
declare -x PATH=${PATH}:/cygdrive/c/development/tools/apache-ant-1.10.1/bin/
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
declare -x DRAGON_JS_HOME="${DRAGON_HOME}src/main/webapp/js/"
alias godragon="cd $DRAGON_HOME"
alias godragonjava="cd ${DRAGON_JAVA_HOME}"
alias godragontemplates="cd ${DRAGON_TEMPLATES_HOME}"
alias godragonscript="cd ${DRAGON_JS_HOME}"

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

alias mysql_accessdragon_prod="mysql -h${ACCESS_DRAGON_PROD_HOST} -u${ACCESS_DRAGON_PROD_USERNAME} -p${ACCESS_DRAGON_PROD_PASSWORD} -A ${ACCESS_DRAGON_PROD_SCHEMA}"
alias mysql_accessdragon_backup="mysql -hdragonweekend.c5vzduwbgj5d.us-east-1.rds.amazonaws.com -u${ACCESS_DRAGON_PROD_USERNAME} -p${ACCESS_DRAGON_PROD_PASSWORD} -A ${ACCESS_DRAGON_PROD_SCHEMA}"

runMongoOnCygwin() {
	echo "Connecting to MongoDB with connection string [$1]..."
	echo "Run query with something like db.result.findOne({isFinal: true}, {_id: true})"
	echo "Type just 'exit' to quit"
	echo "Remember that prompt/completion/etc. will not work b/c we are on Cygwin and Mongo doesn't support it!"
	echo "Vim + Vim-Slime works ok though."
	echo "-----------------------------"
	mongo $1
}

alias mongo_dragon_dev="runMongoOnCygwin ${MONGO_DEV_PRIMARY_CONN}"
alias mongo_dragon_dev2="runMongoOnCygwin ${MONGO_DEV_SECONDARY_CONN}"
alias mongo_dragon_prod="runMongoOnCygwin ${MONGO_PROD_PRIMARY_CONN}"
alias mongo_dragon_prod2="runMongoOnCygwin ${MONGO_PROD_SECONDARY_CONN}"

# at ICF/cygwin I kept running into this issue where shell overwrote itself.
# this MAYBE has something to do with python virtualenv - but I think it's just
# cygwin annoyingness
#
# see http://unix.stackexchange.com/questions/105958/terminal-prompt-not-wrapping-correctly
shopt -s checkwinsize

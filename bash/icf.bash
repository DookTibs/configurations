declare -x PATH=${PATH}:~/bin/
# declare -x PATH=${PATH}:/cygdrive/c/Program\ Files\ \(x86\)/Graphviz2.38/bin/
declare -x PATH=/usr/local/Cellar/python\@2/2.7.14_3/bin:${PATH}

declare -x GOOGLE_APPLICATION_CREDENTIALS=~/development/acc/serviceAccount.json

# virtualenv for python
declare -x WORKON_HOME=${HOME}/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

declare -x DOWNLOADS=/Users/tfeiler/Downloads/

# declare -x ECLIPSE_HOME=/cygdrive/c/Users/38593/eclipse/neon/eclipse/
# alias goeclipse="cd $ECLIPSE_HOME"
# alias launch_eclimd="goeclipse; ./eclimd.bat"

declare -x WORKSPACE=/Users/tfeiler/eclipse-workspace/
alias goworkspace="cd $WORKSPACE"

declare -x ONEDRIVE_HOME="/Users/tfeiler/OneDriveData/OneDrive - ICF"
alias goonedrive='cd "$ONEDRIVE_HOME"'

alias bc="/Applications/Beyond\ Compare.app/Contents/MacOS/bcomp"

# alias start_mongo_server="/cygdrive/c/Program\ Files/MongoDB/Server/3.4/bin/mongod.exe --dbpath C:/development/mongo_datadir"
# alias mongo="/cygdrive/c/Program\ Files/MongoDB/Server/3.4/bin/mongo.exe"

# alias start_mysql_server="echo 'mysqladmin -uroot shutdown to kill...' ; mysqld_safe &"

alias gonotes='cd "$ONEDRIVE_HOME/notes"'

alias ls='ls -ltrG'

declare -x DRAGON_HOME="/Users/tfeiler/development/icf_dragon/"
declare -x DRAGON_JAVA_HOME="${DRAGON_HOME}src/main/java/com/icfi/dragon/web/"
declare -x DRAGON_CSS_HOME="${DRAGON_HOME}src/main/webapp/css/"
declare -x DRAGON_TEMPLATES_HOME="${DRAGON_HOME}src/main/webapp/templates/"
declare -x DRAGON_JS_HOME="${DRAGON_HOME}src/main/webapp/js/"
alias godragon="cd $DRAGON_HOME"
alias godragonjava="cd ${DRAGON_JAVA_HOME}"
alias godragontemplates="cd ${DRAGON_TEMPLATES_HOME}"
alias godragonjs="cd ${DRAGON_JS_HOME}"
alias godragoncss="cd ${DRAGON_CSS_HOME}"
alias gojava=godragonjava
alias gotemplates=godragontemplates
alias gojs=godragonjs
alias gocss=godragoncss

alias launch_sqsd="sqsd --queue-url https://sqs.us-east-1.amazonaws.com/692679271423/event_queue_tfeiler_sqsd --web-hook http://localhost:8081/eventhandler -d -s 5 -v"

# declare -x DOCTER_HOME="/Users/tfeiler/development/docter_online/"
declare -x DOCTER_HOME="/Users/tfeiler/development/docterOnline/"
# declare -x DOCTER_VM_HOME="/Users/tfeiler/development/docterVM/"
alias godocter="cd ${DOCTER_HOME}"
# alias godocterVM="cd ${DOCTER_VM_HOME}"

declare -x HAWC_HOME="/Users/tfeiler/development/hawc/epahawc/"

alias dj='source /Users/tfeiler/development/shellScripts/special/djs.sh'
alias djj='source /Users/tfeiler/development/shellScripts/special/djs.sh javascript'
alias djt='source /Users/tfeiler/development/shellScripts/special/djs.sh templates'
alias djp='source /Users/tfeiler/development/shellScripts/special/djs.sh python'

alias gohawc="cd ${HAWC_HOME}"
# alias psql_hawc_local="psql -h localhost -p 5432 -d hawc_localdev -U hawc_user"
alias psql_hawc_local="psql -h localhost -p 5432 -d hawc -U hawc"

declare -x TOMCAT_HOME="/Users/tfeiler/development/tools/tomcat/apache-tomcat-9.0.0.M18/"
alias gotomcat="cd $TOMCAT_HOME"

alias goapi="cd ~/development/dragon_api"

# alias psql_dragon_dev="psql -h dbinstance.c5vzduwbgj5d.us-east-1.rds.amazonaws.com -p 5432 -d dragon -U dbadmin"

alias psql_dragon_staging="psql -h dragon-postgresql-stage.c5vzduwbgj5d.us-east-1.rds.amazonaws.com -p 5432 -d stagedb -U dbadmin"

# alias psql_dragon_production="psql -h icfdragon-1.c5vzduwbgj5d.us-east-1.rds.amazonaws.com -p 5432 -d dragon -U dragon"

alias mysql_accessdragon_prod="mysql -h${ACCESS_DRAGON_PROD_HOST} -u${ACCESS_DRAGON_PROD_USERNAME} -p${ACCESS_DRAGON_PROD_PASSWORD} -A ${ACCESS_DRAGON_PROD_SCHEMA}"
alias mysql_accessdragon_backup="mysql -hdragonweekend.c5vzduwbgj5d.us-east-1.rds.amazonaws.com -u${ACCESS_DRAGON_PROD_USERNAME} -p${ACCESS_DRAGON_PROD_PASSWORD} -A ${ACCESS_DRAGON_PROD_SCHEMA}"

runMongoOnCygwin() {
	# echo "Connecting to MongoDB with connection string [$1]..."
	# echo "Run query with something like db.result.findOne({isFinal: true}, {_id: true})"
	# echo "Type just 'exit' to quit"
	# echo "Remember that prompt/completion/etc. will not work b/c we are on Cygwin and Mongo doesn't support it!"
	# echo "Vim + Vim-Slime works ok though."
	# echo "-----------------------------"
	# mongo $1

	# 20170811 change - use winpty instead and suddenly prompt/completion/etc. works!!!
	winpty /cygdrive/c/Program\ Files/MongoDB/Server/3.4/bin/mongo.exe $1
}

# alias sqlite="winpty /cygdrive/c/development/tools/sqlite/sqlite3.exe"

# alias mongo_dragon_dev="runMongoOnCygwin ${MONGO_DEV_PRIMARY_CONN}"
# alias mongo_dragon_dev2="runMongoOnCygwin ${MONGO_DEV_SECONDARY_CONN}"
# alias mongo_dragon_prod="runMongoOnCygwin ${MONGO_PROD_PRIMARY_CONN}"
# alias mongo_dragon_prod2="runMongoOnCygwin ${MONGO_PROD_SECONDARY_CONN}"
# alias mongo_dragon_sandbox="runMongoOnCygwin ${MONGO_SANDBOX_PRIMARY_CONN}"

alias mongo_dragon_dev="mongo ${MONGO_DEV_PRIMARY_CONN}"
alias mongo_dragon_dev2="mongo ${MONGO_DEV_SECONDARY_CONN}"
alias mongo_dragon_prod="mongo ${MONGO_PROD_PRIMARY_CONN}"
alias mongo_dragon_prod2="mongo ${MONGO_PROD_SECONDARY_CONN}"
alias mongo_dragon_sandbox="mongo ${MONGO_SANDBOX_PRIMARY_CONN}"

alias sqlserver_dcc_dev="sqlcmd -S ${DCC_DB_DEV_HOST} -U ${DCC_DB_DEV_USER} -P ${DCC_DB_DEV_PASSWORD}"

# at ICF/cygwin I kept running into this issue where shell overwrote itself.
# this MAYBE has something to do with python virtualenv - but I think it's just
# cygwin annoyingness
#
# see http://unix.stackexchange.com/questions/105958/terminal-prompt-not-wrapping-correctly
# shopt -s checkwinsize

# connects to the EC2 DRAGON dev instance. Note that this can change its address...
# see http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html
# I had to generate a new keypair as the old "crosscomm" one wasn't available to me
# alias ssh_dev="ssh -i $DRAGON_HOME/unsynced/keypairs/icf_dragon_aws_20170508_keypair.pem ec2-user@ec2-54-204-9-160.compute-1.amazonaws.com"

# declare -x DRAGON_AWS_USER="ec2-user"
# declare -x DRAGON_AWS_KEYPAIR="${DRAGON_HOME}unsynced/keypairs/icf_dragon_aws_20170508_keypair.pem"
# declare -x DRAGON_DEV_WEB_HOST="ec2-75-101-148-183.compute-1.amazonaws.com"
# declare -x DRAGON_DEV_WORKER_HOST="ec2-54-161-82-161.compute-1.amazonaws.com"
# declare -x DRAGON_PROD_WEB_HOST="ec2-34-229-165-35.compute-1.amazonaws.com"
# declare -x DRAGON_PROD_WORKER_HOST="ec2-54-234-49-64.compute-1.amazonaws.com"

# alias ssh_dev_web="ssh -i $DRAGON_AWS_KEYPAIR $DRAGON_AWS_USER@$DRAGON_DEV_WEB_HOST"
# alias lw_dev_web="ssh_dev_web tail -f /var/log/tomcat8/catalina.out"

# alias ssh_dev_worker="ssh $DRAGON_AWS_KEYPAIR $DRAGON_AWS_USER@$DRAGON_DEV_WEB_HOST ssh -i icf_dragon_aws_20170508_keypair.pem $DRAGON_AWS_USER@$DRAGON_DEV_WORKER_HOST"
# alias lw_dev_worker="ssh_dev_worker tail -f /var/log/tomcat8/catalina.out"

# alias ssh_prod_web="ssh -i $DRAGON_AWS_KEYPAIR $DRAGON_AWS_USER@$DRAGON_PROD_WEB_HOST"
# alias lw_prod_web="ssh_prod_web tail -f /var/log/tomcat8/catalina.out"

# alias ssh_prod_worker="ssh -i $DRAGON_AWS_KEYPAIR $DRAGON_AWS_USER@$DRAGON_PROD_WORKER_HOST"
# alias lw_prod_worker="ssh_prod_worker tail -f /var/log/tomcat7/catalina.out"

declare -x DRAGON_AWS_USER="ec2-user"
declare -x DRAGON_AWS_KEYPAIR="${DRAGON_HOME}unsynced/keypairs/icf_dragon_aws_20170508_keypair.pem"
declare -x EC2_PROD_JUMPBOX="54.243.26.249"
declare -x EC2_DEV_WEB="75.101.148.183"
declare -x EC2_PROD_WEB="107.23.95.125"

ssh_aws () { 
	host=`echo "$1" | sed "s/\\./"-"/g"`
	host="ec2-${host}.compute-1.amazonaws.com"
 
	if [ -z "$2" ]; then
		echo "ssh'ing to [$host]..."
		ssh -i $DRAGON_AWS_KEYPAIR $DRAGON_AWS_USER@$host
	else
		echo "running [$2] on [$host]..."
		ssh -i $DRAGON_AWS_KEYPAIR $DRAGON_AWS_USER@$host "$2"
	fi
}

# ssh_jumpbox() {
	# ssh_aws "$EC2_PROD_JUMPBOX" "${*}"
# }

ssh_devweb() {
	ssh_aws "$EC2_DEV_WEB" "${*}"
}
# alias lw_devweb="ssh_devweb tail -f /var/log/tomcat8/catalina.out"

# ssh_prodweb() {
	# ssh_aws "$EC2_PROD_WEB" "${*}"
# }



# tunnelling notes
# in September 2017 we reworked DRAGON's networking in production (and soon, hopefully, dev)
# to be more secure and go through a bastion. But this means we need to jump through some hoops
# to ssh into production servers, talk to production databases using CLI tools, etc. How do we do it?
#
# 1. set up .ssh/config in particular way. That'll let you ssh into either bastion or web/worker tier
# 2. once you can ssh in you can open a tunnel like:
#    6432 = port on my local machine
#    icfdragon-1.c5.... = endpoint for my RDS instance
#    5432 = port that psql is running on on the RDS instance
#    prod_bastion = host I'm tunnelling through
#    
#	 (open interactively)
#    ssh -L 6432:icfdragon-1.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 prod_bastion
#
#	 (run in background)
#    ssh -N -f -L 6432:icfdragon-1.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 prod_bastion
#
# 3. then I can just do:
#    psql -h localhost -p 6432 -d dragon -U dragon
#
#    and I can talk to the production database through the bastion.
#    (and if ~/.pgpass has the stored credentials I don't get prompted for password)
#
#    Similarly I think I can point my local development config at that to run a local DRAGON install
#    that talks to prod database.
#
#    THINGS I MUST GET WORKING:
#		A) get tunnel working without opening a shell / rewrite "stopTunneling" to be generic
#       B) run local DRAGON instance that talks to prod
#    C) get the API so it can talk to production too.
#         ONCE I GET A/B/C WORKING, I THINK I CAN CLOSE THE TICKET...
#    D) work on the keepalive settings
#    E) get back to new test/live env setup
alias tunnel_check="checkTunnels.sh"

# autossh -M with a different monitor port for each instance. Keeps tunnel open on OSX
# alias tunnel_dragon_prod_start="ssh -N -f -L 6432:icfdragon-1.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 prod_jumpbox"
alias tunnel_dragon_prod_start="autossh -M 20005 -N -f -L 6432:icfdragon-1.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 prod_jumpbox"
alias tunnel_dragon_prod_stop="stopTunnelling.sh 6432:icfdragon-1.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432"

alias tunnel_dragon_dev_start="autossh -M 20010 -N -f -L 7432:dbinstance.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 dev_jumpbox"
alias tunnel_dragon_dev_stop="stopTunnelling.sh 7432:dbinstance.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432"

alias tunnel_accessdragon_recovery_start="autossh -M 20030 -N -f -L 3310:accessdragon-20180903-recovery.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:3306 dev_jumpbox"
alias tunnel_accessdragon_recovery_stop="stopTunnelling.sh 3310:accessdragon-20180903-recovery.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:3306"
alias mysql_accessdragon_recovery="mysql -h127.0.0.1 -P3310 -u${ACCESS_DRAGON_PROD_USERNAME} -p${ACCESS_DRAGON_PROD_PASSWORD} -A ${ACCESS_DRAGON_PROD_SCHEMA}"

alias tunnel_dragon_sandbox_start="autossh -M 20000 -N -f -L 8432:dragon-sandbox.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 dev_jumpbox"
alias tunnel_dragon_sandbox_stop="stopTunnelling.sh 8432:dragon-sandbox.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432"

# alias tunnel_docter_dev_psql_start="autossh -M 20015 -N -f -L 5937:docter-dev-psql.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 dev_docter_jumpbox"
# alias tunnel_docter_dev_psql_stop="stopTunnelling.sh 5937:docter-dev-psql"

# alias tunnel_docter_prod_start="autossh -M 20025 -N -f -L 9439:docter-prod-psql.cazjljg8okvt.us-east-2.rds.amazonaws.com:5432 prod_docter_jumpbox"
# alias tunnel_docter_prod_start="autossh -M 20025 -N -f -L 9439:docter-prod-psql.cazjljg8okvt.us-east-2.rds.amazonaws.com:5432 -L 3312:mmdb-ord-20181127.cazjljg8okvt.us-east-2.rds.amazonaws.com:3306 prod_docter_jumpbox"
alias tunnel_docter_prod_start="autossh -M 20025 -N -f -L 9439:docter-prod-psql.cazjljg8okvt.us-east-2.rds.amazonaws.com:5432 -L 3312:${MMDBORD_MYSQL_HOST}:3306 prod_docter_jumpbox"
alias tunnel_docter_prod_stop="stopTunnelling.sh 9439:docter-prod-psql.cazjljg8okvt.us-east-2.rds.amazonaws.com:5432"

# mmdb-ord database is set up, from Azure box access it like:
# mysql.exe --host=mmdb-ord-20181127.cazjljg8okvt.us-east-2.rds.amazonaws.com --user=icfmmdb --password=h4ppyd4z3 ord
# to do work, see https://stackoverflow.com/questions/13717277/how-can-i-import-a-large-14-gb-mysql-dump-file-into-a-new-mysql-database

# from this machine, run tunnel_docter_prod_start and then:
alias mysql_mmdb_ord="mysql -h127.0.0.1 -P3312 -u${MMDBORD_MYSQL_USERNAME} -p${MMDBORD_MYSQL_PASSWORD} ${MMDBORD_MYSQL_DBNAME}"


alias tunnel_embsi_dev_start="autossh -M 20020 -N -f -L 6462:embsi-dev-psql.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 dev_embsi_jumpbox"
alias tunnel_embsi_dev_stop="stopTunnelling.sh 6462:embsi-dev-psql"

# curl localhost:9250/_cluster/health?pretty
alias psql_dragon_production="psql -h localhost -p 6432 -d dragon -U dragon"
alias psql_dragon_development="psql -h localhost -p 7432 -d dragon -U dbadmin"
alias psql_dragon_sandbox="psql -h localhost -p 8432 -d dragon_env_backup -U dragon_sandbox_admin"

# alias psql_docter_development="psql -h localhost -p 5937 -d docter -U docter"
alias psql_docter_prod="psql -h localhost -p 9439 -d docter_db_prod -U docter_admin"

alias psql_embsi_development="psql -h localhost -p 6462 -d embsi_dev -U embsi_admin"

# where am I:
# 1. added AWSLambdaVPCAccessExecutionRole policy to "dragon-api-lambda" role in IAM
# 2. put ONE of my lambdas into a VPC.
# at this point, testing the lambda directly works. But testing via the API does not (hitting endpoint from python; haven't tried direct test in AWS console)
# maybe update api_custom_authorizer lambda function...
# maybe just write a simple Flask webapp and run it there...



# alias ssh_dev_web="ssh_aws dev_web"
# alias ssh_newdev_web="ssh_aws newdev_web"


# see http://www.saxonica.com/documentation/#!about/gettingstarted/gettingstartedjava
alias saxon="java -cp /Users/tfeiler/development/tools/saxon97/saxon9he.jar"
alias saxonq="java -cp /Users/tfeiler/development/tools/saxon97/saxon9he.jar net.sf.saxon.Query -t"
alias saxont="java -cp /Users/tfeiler/development/tools/saxon97/saxon9he.jar net.sf.saxon.Transform -t"

# DOCKER SPECIFIC
if [ "1" = "2" ]; then
	# you need to make sure docker in its vm is running (see Desktop shortcut "C:\Program Files\Git\bin\bash.exe" --login -i "C:\Program Files\Docker Toolbox\start.sh")
	# for any of this to work properly. Disabling for now.

	dockerIp=`/cygdrive/c/Program\ Files/Docker\ Toolbox/docker-machine.exe env | \
		awk '/DOCKER_HOST/ { print }' | \
		sed 's-.*="tcp://\(.*\):.*"-\1-'`

	export DOCKER_TLS_VERIFY="1"
	export DOCKER_HOST="tcp://$dockerIp:2376"
	export DOCKER_CERT_PATH="C:\Users\38593\.docker\machine\machines\default"
	export DOCKER_MACHINE_NAME="default"
	export COMPOSE_CONVERT_WINDOWS_PATHS="true"
	declare -x PATH=${PATH}:/cygdrive/c/Program\ Files/Docker\ Toolbox/
	alias docker="winpty docker"
	alias d="docker"
fi

alias hg='~/development/tools/mercurial/mercurial-4.5.3/hg'

alias godcc="cd ~/development/dcc/vmMountpoint"

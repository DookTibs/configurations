declare -x PATH=${PATH}:~/bin/
declare -x PATH=${PATH}:/cygdrive/c/development/tools/ctags58/
declare -x PATH=${PATH}:/cygdrive/c/development/tools/apache-maven-3.3.9/bin/
declare -x PATH=${PATH}:/cygdrive/c/development/tools/apache-ant-1.10.1/bin/
declare -x PATH=${PATH}:/cygdrive/c/Program\ Files/nodejs/
declare -x PATH=${PATH}:/cygdrive/c/Program\ Files\ \(x86\)/Graphviz2.38/bin/

declare -x GOOGLE_APPLICATION_CREDENTIALS=~/development/acc/serviceAccount.json

# virtualenv for python
declare -x WORKON_HOME=${HOME}/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

declare -x DOWNLOADS=/cygdrive/c/Users/38593/Downloads/

declare -x ECLIPSE_HOME=/cygdrive/c/Users/38593/eclipse/neon/eclipse/
alias goeclipse="cd $ECLIPSE_HOME"

declare -x WORKSPACE=/cygdrive/c/Users/38593/workspace/
alias goworkspace="cd $WORKSPACE"

declare -x ONEDRIVE_HOME="/cygdrive/c/Users/38593/OneDrive for Business/"
alias goonedrive='cd "$ONEDRIVE_HOME"'

alias launch_eclimd="goeclipse; ./eclimd.bat"

alias open="explorer.exe ."

alias bc="/cygdrive/c/Program\ Files/Beyond\ Compare\ 4/BCompare.exe"

alias start_mongo_server="/cygdrive/c/Program\ Files/MongoDB/Server/3.4/bin/mongod.exe --dbpath C:/development/mongo_datadir"
alias mongo="/cygdrive/c/Program\ Files/MongoDB/Server/3.4/bin/mongo.exe"

alias start_mysql_server="echo 'mysqladmin -uroot shutdown to kill...' ; mysqld_safe &"

alias gonotes='cd "$ONEDRIVE_HOME/notes"'

alias ls='ls -ltrG --color=auto'

declare -x DRAGON_HOME="/cygdrive/c/Users/38593/workspace/icf_dragon/"
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

declare -x DOCTER_HOME="/home/38593/development/docter_online/"
declare -x DOCTER_VM_HOME="/home/38593/development/docterVM/"
alias godocter="cd ${DOCTER_HOME}"
alias godocterVM="cd ${DOCTER_VM_HOME}"

declare -x TOMCAT_HOME="/cygdrive/c/development/tomcat/apache-tomcat-9.0.0.M15/"
alias gotomcat="cd $TOMCAT_HOME"

alias goapi="cd ~/development/dragon_api"
alias goapimain="cd ~/development/dragon_api/src/aws_lambda/main/python"

clippaste() {
	cat /dev/clipboard > $1
}

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
# alias tunnel_prod_psql_start="ssh -N -f -L 6432:icfdragon-1.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 prod_bastion"
alias tunnel_dragon_prod_psql_start="ssh -N -f -L 6432:icfdragon-1.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 prod_jumpbox"
alias tunnel_dragon_prod_psql_stop="stopTunnelling.sh 6432:icfdragon-1.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432"
# alias tunnel_prod_elastic_start="ssh -N -f -L 9270:10.1.0.50:9200 -L 9370:10.1.0.50:9300 prod_jumpbox"
# alias tunnel_prod_elastic_stop="stopTunnelling.sh 9270:10.1.0.50:9200"
alias tunnel_dragon_prod_start="tunnel_dragon_prod_psql_start"
alias tunnel_dragon_prod_stop="tunnel_dragon_prod_psql_stop"

alias tunnel_dragon_dev_psql_start="ssh -N -f -L 7432:dbinstance.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 dev_jumpbox"
alias tunnel_dragon_dev_psql_stop="stopTunnelling.sh 7432:dbinstance.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432"
alias tunnel_dragon_dev_elastic_start="ssh -N -f -L 9250:10.2.0.90:9200 -L 9350:10.2.0.90:9300 dev_jumpbox"
alias tunnel_dragon_dev_elastic_stop="stopTunnelling.sh 9250:10.2.0.90:9200"
alias tunnel_dragon_dev_start="tunnel_dragon_dev_psql_start ; tunnel_dragon_dev_elastic_start"
alias tunnel_dragon_dev_stop="tunnel_dragon_dev_psql_stop ; tunnel_dragon_dev_elastic_stop"


alias tunnel_docter_dev_psql_start="ssh -N -f -L 5937:docter-dev-psql.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 dev_docter_jumpbox"
alias tunnel_docter_dev_psql_stop="stopTunnelling.sh 5937:docter-dev-psql"

# curl localhost:9250/_cluster/health?pretty
alias psql_dragon_production="psql -h localhost -p 6432 -d dragon -U dragon"
alias psql_dragon_development="psql -h localhost -p 7432 -d dragon -U dbadmin"

alias psql_docter_development="psql -h localhost -p 5937 -d docter -U docter"

# where am I:
# 1. added AWSLambdaVPCAccessExecutionRole policy to "dragon-api-lambda" role in IAM
# 2. put ONE of my lambdas into a VPC.
# at this point, testing the lambda directly works. But testing via the API does not (hitting endpoint from python; haven't tried direct test in AWS console)
# maybe update api_custom_authorizer lambda function...
# maybe just write a simple Flask webapp and run it there...



# alias ssh_dev_web="ssh_aws dev_web"
# alias ssh_newdev_web="ssh_aws newdev_web"


# see http://www.saxonica.com/documentation/#!about/gettingstarted/gettingstartedjava
alias saxon="java -cp C:/cygwin64/home/38593/development/tools/saxon97/saxon9he.jar"
alias saxonq="java -cp C:/cygwin64/home/38593/development/tools/saxon97/saxon9he.jar net.sf.saxon.Query -t"
alias saxont="java -cp C:/cygwin64/home/38593/development/tools/saxon97/saxon9he.jar net.sf.saxon.Transform -t"

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

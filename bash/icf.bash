# declare -x VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.9
declare -x VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
declare -x PATH=${PATH}:~/bin/
# declare -x PATH=${PATH}:/cygdrive/c/Program\ Files\ \(x86\)/Graphviz2.38/bin/
# declare -x PATH=/usr/local/Cellar/python\@2/2.7.14_3/bin:${PATH}

declare -x GOOGLE_APPLICATION_CREDENTIALS=~/development/acc/serviceAccount.json

# virtualenv for python
declare -x WORKON_HOME=${HOME}/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh
source ~/Library/Python/3.9/bin/virtualenvwrapper.sh
declare -x PATH=${PATH}:~/Library/Python/3.9/bin

declare -x DOWNLOADS=$HOME/Downloads/

# declare -x ECLIPSE_HOME=/cygdrive/c/Users/38593/eclipse/neon/eclipse/
# alias goeclipse="cd $ECLIPSE_HOME"
# alias launch_eclimd="goeclipse; ./eclimd.bat"

declare -x WORKSPACE=$HOME/eclipse-workspace/
alias goworkspace="cd $WORKSPACE"

# declare -x ONEDRIVE_HOME="/Users/tfeiler/OneDriveData/OneDrive - ICF"
declare -x ONEDRIVE_HOME="$HOME/OneDrive - ICF"
alias goonedrive='cd "$ONEDRIVE_HOME"'

alias bc="/Applications/Beyond\ Compare.app/Contents/MacOS/bcomp"

# alias start_mongo_server="/cygdrive/c/Program\ Files/MongoDB/Server/3.4/bin/mongod.exe --dbpath C:/development/mongo_datadir"
# alias mongo="/cygdrive/c/Program\ Files/MongoDB/Server/3.4/bin/mongo.exe"

# alias start_mysql_server="echo 'mysqladmin -uroot shutdown to kill...' ; mysqld_safe &"

alias gonotes='cd "$ONEDRIVE_HOME/notes"'

alias ls='ls -ltrG'

declare -x DRAGON_HOME="$HOME/development/icf_dragon/"
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

launch_sqsd () { 
	if [ -n "$1" ]; then
		targetEnv="$1"
		dynamic_key_env_lookup="LITSTREAM_APP_SDK_USER_ACCESS_KEY_ID_${targetEnv}"
		dynamic_secret_env_lookup="LITSTREAM_APP_SDK_USER_SECRET_ACCESS_KEY_${targetEnv}"
		dynamic_queue_env_lookup="LITSTREAM_LOCALWORK_TESTQUEUE_${targetEnv}"

		aws_access_key_id="${!dynamic_key_env_lookup}"
		aws_secret_access_key="${!dynamic_secret_env_lookup}"
		queue_url="${!dynamic_queue_env_lookup}"

		if [ -z "${queue_url}" ]; then
			echo "'${targetEnv}' is not a supported environment; see sensitive_data.bash and grep for LITSTREAM_APP_SDK and LITSTREAM_LOCALWORK_TESTQUEUE for this environment."
			return
		fi

		# echo "in fxn, for '${targetEnv}', gonna use [${aws_access_key_id}] and [${aws_secret_access_key}] to connect to '${queue_url}' (defined in sensitive_data.sh which should never get checked in..."
		echo "env==${targetEnv}, running SQSD on queue '${queue_url}..."

		sqsd --queue-url $queue_url --web-hook http://localhost:8081/eventhandler -d -s 5 -v --access-key-id $aws_access_key_id --secret-access-key $aws_secret_access_key
		# echo "RUN THIS COMMAND:"
		# echo "sqsd --queue-url $queue_url --web-hook http://localhost:8081/eventhandler -d -s 5 -v --access-key-id $aws_access_key_id --secret-access-key $aws_secret_access_key"
	else
		echo "No environment specified. Try again with e.g. 'launch_sqsd dev'"
	fi
}

# alias launch_sqsd="sqsd --queue-url https://sqs.us-east-1.amazonaws.com/692679271423/event_queue_tfeiler_sqsd --web-hook http://localhost:8081/eventhandler -d -s 5 -v"

# alias launch_sqsd2021="sqsd --queue-url https://sqs.us-east-1.amazonaws.com/692679271423/litstream-prod2021-eq --web-hook http://localhost:8081/eventhandler -d -s 5 -v"

# alias launch_sqsd="sqsd --queue-url https://sqs.us-east-1.amazonaws.com/692679271423/event_queue_tfeiler_sqsd --web-hook http://localhost:8081/eventhandler -d -s 5 -v --access-key-id $SQSD_AWS_ACCESS_KEY_ID --secret-access-key $SQSD_AWS_SECRET_ACCESS_KEY"

# LAST ONES USED BEFORE REOWRKING INTO A function...
# alias xxxlaunch_sqsd="sqsd --queue-url https://sqs.us-east-1.amazonaws.com/736887025159/litstream-dev-developertesting-tfeiler-eq --web-hook http://localhost:8081/eventhandler -d -s 5 -v --access-key-id $SQSD_AWS_ACCESS_KEY_ID --secret-access-key $SQSD_AWS_SECRET_ACCESS_KEY"

# alias xxxlaunch_sqsd2021="sqsd --queue-url https://sqs.us-east-1.amazonaws.com/692679271423/litstream-prod2021-eq --web-hook http://localhost:8081/eventhandler -d -s 5 -v"

# declare -x DOCTER_HOME="/Users/tfeiler/development/docter_online/"
declare -x DOCTER_HOME="$HOME/development/docterOnline/"
# declare -x DOCTER_VM_HOME="/Users/tfeiler/development/docterVM/"
alias godocter="cd ${DOCTER_HOME}"
# alias godocterVM="cd ${DOCTER_VM_HOME}"

declare -x HAWC_HOME="$HOME/development/hawc_project/hawc/"

alias dj='source $HOME/development/shellScripts/special/djs.sh'
alias djj='source $HOME/development/shellScripts/special/djs.sh javascript'
alias djt='source $HOME/development/shellScripts/special/djs.sh templates'
alias djp='source $HOME/development/shellScripts/special/djs.sh python'

alias gohawc="cd ${HAWC_HOME}"
# alias activatehawc="initConda && conda activate hawc2021"
# alias activatehawc="workon hawc2021"
alias activatehawc="workon hawc2023 && declare -x SKIP_BMDS_TESTS=True"
# alias psql_hawc_local="psql -h localhost -p 5432 -d hawc_localdev -U hawc_user"
alias psql_hawc_local="psql -h localhost -p 5432 -d hawc -U hawc"
# alias psql_hawc_icfaws="psql -h hawc-internal-icf-dev-db.cotmuxecedep.us-east-1.rds.amazonaws.com -p 5432 -d icf_hawc_dev -U hawc_admin"
# alias psql_hawc_icfaws="psql -h ec2-3-228-3-19.compute-1.amazonaws.com -p 5432 -d hawc -U hawc"
alias psql_hawc_icfaws="ssh -tt hawc_icfaws '/home/ubuntu/psql_to_hawc.sh'"

alias goapi="cd ~/development/dragon_api"

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
# alias tunnel_check="checkTunnels.sh"

# autossh -M with a different monitor port for each instance. Keeps tunnel open on OSX
# alias tunnel_dragon_prod2020_start="autossh -M 20045 -N -f -L 9432:litstream-pg-prod-20210308.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 prod_jumpbox"
# alias tunnel_dragon_prod2020_stop="stopTunnelling.sh 9432:litstream-pg-prod-20210308.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432"





# CLEANED UP AS OF DECEMBER 2022
alias tunnel_check="tunneler.py -o check_tunnels"

# alias tunnel_litstream_prod2021_start="tunneler.py -e prod2021 -o start_tunnel"
# alias tunnel_litstream_prod2021_stop="tunneler.py -e prod2021 -o stop_tunnel"
# alias psql_litstream_prod2021="psql -h localhost -p 1432 -d litstream -U litstream_admin"
# alias redis_litstream_prod2021="redis-cli -h localhost -p 9742"

# alias tunnel_litstream_dev2021_start="tunneler.py -e dev2021 -o start_tunnel"
# alias tunnel_litstream_dev2021_stop="tunneler.py -e dev2021 -o stop_tunnel"
# alias psql_litstream_dev2021="psql -h localhost -p 2432 -d litstream_dev -U litstream_dev_admin"
# alias redis_litstream_dev2021="redis-cli -h localhost -p 9744"

# alias tunnel_litstream_sandbox2021_start="tunneler.py -e sandbox2021 -o start_tunnel"
# alias tunnel_litstream_sandbox2021_stop="tunneler.py -e sandbox2021 -o stop_tunnel"
# alias psql_litstream_sandbox2021="psql -h localhost -p 8432 -d dragon_env_backup -U dragon_sandbox_admin"
# alias redis_litstream_sandbox2021="redis-cli -h localhost -p 9760"

alias tunnel_litstream_sandbox_start="tunneler.py -e sandbox -o start_tunnel"
alias tunnel_litstream_sandbox_stop="tunneler.py -e sandbox -o stop_tunnel"
alias psql_litstream_sandbox="psql -h localhost -p 8432 -d litstream_sandbox -U ls_sandbox_admin"
alias redis_litstream_sandbox="redis-cli -h localhost -p 9736"
# alias mongo_litstream_sandbox="mongo --tls --tlsAllowInvalidCertificates ${MONGO_SANDBOX_PRIMARY_CONN}"
alias mongo_litstream_sandbox="mongosh ${MONGO_SANDBOX_PRIMARY_CONN}"

alias mongo_lfc_sandbox="mongosh ${MONGO_LFC_SANDBOX_PRIMARY_CONN}"


alias tunnel_litstream_dev_start="tunneler.py -e dev -o start_tunnel"
alias tunnel_litstream_dev_stop="tunneler.py -e dev -o stop_tunnel"
alias psql_litstream_dev="psql -h localhost -p 3432 -d litstream_dev -U litstream_dev_admin"
alias redis_litstream_dev="redis-cli -h localhost -p 9750"
# alias mongo_litstream_dev="mongo --tls --tlsAllowInvalidCertificates ${MONGO_DEV_PRIMARY_CONN}"
# alias mongosh_litstream_dev="mongosh --tls --tlsAllowInvalidCertificates ${MONGO_DEV_PRIMARY_CONN}"
alias mongo_litstream_dev="mongosh ${MONGO_DEV_PRIMARY_CONN}"


alias tunnel_litstream_prod_start="tunneler.py -e prod -o start_tunnel"
alias tunnel_litstream_prod_stop="tunneler.py -e prod -o stop_tunnel"
alias psql_litstream_prod="psql -h localhost -p 4432 -d litstream_prod -U litstream_prod_admin"
alias redis_litstream_prod="redis-cli -h localhost -p 9752"
# alias mongo_litstream_prod="mongo --tls --tlsAllowInvalidCertificates ${MONGO_PROD_PRIMARY_CONN}"
# alias mongosh_litstream_prod="mongosh --tls --tlsAllowInvalidCertificates ${MONGO_PROD_PRIMARY_CONN}"
alias mongo_litstream_prod="mongosh ${MONGO_PROD_PRIMARY_CONN}"

alias tunnel_litstream_unittest_start="tunneler.py -e unittest -o start_tunnel"
alias tunnel_litstream_unittest_stop="tunneler.py -e unittest -o stop_tunnel"
alias psql_litstream_unittest="psql -h localhost -p 9432 -d litstream_dev -U litstream_dev_admin"
alias redis_litstream_unittest="redis-cli -h localhost -p 9748"
# alias mongo_litstream_unittest="mongo --tls --tlsAllowInvalidCertificates ${MONGO_DEV_PRIMARY_CONN}"
# alias mongosh_litstream_unittest="mongosh --tls --tlsAllowInvalidCertificates ${MONGO_DEV_PRIMARY_CONN}"
alias mongo_litstream_unittest="mongosh ${MONGO_DEV_PRIMARY_CONN}"

# PYTRIM
alias mysql_pytrim_local="mysql -uroot pytrim"

alias tunnel_pytrim_dev_start="tunneler.py -e pytrim_dev -o start_tunnel"
alias tunnel_pytrim_dev_stop="tunneler.py -e pytrim_dev -o stop_tunnel"
alias mysql_pytrim_dev="mysql -h 127.0.0.1 -P 6603 -u ${PYTRIM_DEV_USERNAME} -p${PYTRIM_DEV_PASSWORD} pytrimv2"

alias launch_trim_devserver="MYSQLPASSWORD= FLASK_DEBUG=development cd ~/development/trim-builder/Scripts/ && python dev.py"

# as of 20221031
# tunnels don't quite work yet...
# alias tunnel_litmc_dev_start="tunneler.py -e litmc_dev -o start_tunnel"
# alias tunnel_litmc_dev_stop="tunneler.py -e litmc_dev -o stop_tunnel"
# this works but the name is annoying with litstream, so I disable
# alias psql_litmc_dev="psql -h localhost -p 6420 -d litemcee -U icflitemcee" #password testtest






alias tunnel_accessdragon_recovery_start="autossh -M 20030 -N -f -L 3310:accessdragon-20180903-recovery.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:3306 dev_jumpbox"
alias tunnel_accessdragon_recovery_stop="stopTunnelling.sh 3310:accessdragon-20180903-recovery.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:3306"
alias mysql_accessdragon_recovery="mysql -h127.0.0.1 -P3310 -u${ACCESS_DRAGON_PROD_USERNAME} -p${ACCESS_DRAGON_PROD_PASSWORD} -A ${ACCESS_DRAGON_PROD_SCHEMA}"

# alias tunnel_dragon_sandbox_start='autossh -M 20000 -N -f -L 8432:dragon-sandbox.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 -L 9736:litstream-sandbox-elcache-003.nbwrk0.0001.use1.cache.amazonaws.com:6379 dev_jumpbox'
# Jan 2020 - at the office, tunnel Mongo too, why not?
# alias tunnel_dragon_sandbox_start='autossh -M 20000 -N -f -L 8432:dragon-sandbox.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 -L 9736:litstream-sandbox-elcache-001.nbwrk0.0001.use1.cache.amazonaws.com:6379 -L 4545:aws-us-east-1-portal.20.dblayer.com:11426 dev_jumpbox'
# alias tunnel_dragon_sandbox_stop="stopTunnelling.sh 8432:dragon-sandbox.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432"

alias tunnel_docter_prod_start="autossh -M 20025 -N -f -L 9439:docter-prod-psql.cazjljg8okvt.us-east-2.rds.amazonaws.com:5432 -L 3312:${MMDBORD_MYSQL_HOST}:3306 prod_docter_jumpbox"
alias tunnel_docter_prod_stop="stopTunnelling.sh 9439:docter-prod-psql.cazjljg8okvt.us-east-2.rds.amazonaws.com:5432"

# mmdb-ord database is set up, from Azure box access it like:
# mysql.exe --host=mmdb-ord-20181127.cazjljg8okvt.us-east-2.rds.amazonaws.com --user=icfmmdb --password=h4ppyd4z3 ord
# to do work, see https://stackoverflow.com/questions/13717277/how-can-i-import-a-large-14-gb-mysql-dump-file-into-a-new-mysql-database

# from this machine, run tunnel_docter_prod_start and then:
alias mysql_mmdb_ord="mysql -h127.0.0.1 -P3312 -u${MMDBORD_MYSQL_USERNAME} -p${MMDBORD_MYSQL_PASSWORD} ${MMDBORD_MYSQL_DBNAME}"


alias tunnel_embsi_olddev_start="autossh -M 20020 -N -f -L 6462:embsi-dev-psql.c5vzduwbgj5d.us-east-1.rds.amazonaws.com:5432 dev_embsi_jumpbox_OLD"
alias tunnel_embsi_olddev_stop="stopTunnelling.sh 6462:embsi-dev-psql"

alias tunnel_embsi_dev_start="autossh -M 20040 -N -f -L 6482:emut-dev-psql.c9bgatqk4une.us-east-1.rds.amazonaws.com:5432 dev_embsi_jumpbox"
alias tunnel_embsi_dev_stop="stopTunnelling.sh 6482:emut-dev-psql"

# alias tunnel_embsi_prod_start="autossh -M 20035 -N -f -L 6472:emut-prod-psql.c9bgatqk4une.us-east-1.rds.amazonaws.com:5432 prod_embsi_jumpbox"
# alias tunnel_embsi_prod_stop="stopTunnelling.sh 6472:emut-prod-psql"

alias tunnel_embsi_prod_start="tunneler.py -e embsi_prod -o start_tunnel"
alias tunnel_embsi_prod_stop="tunneler.py -e embsi_prod -o stop_tunnel"

# curl localhost:9250/_cluster/health?pretty
# alias psql_dragon_development="psql -h localhost -p 7432 -d dragon -U dbadmin"
# alias psql_litstream_sandbox="psql -h localhost -p 8432 -d dragon_env_backup -U dragon_sandbox_admin"
# alias psql_dragon_production2020="psql -h localhost -p 9432 -d dragon -U dragon"
# alias psql_dragon_staging="psql -h dragon-postgresql-stage.c5vzduwbgj5d.us-east-1.rds.amazonaws.com -p 5432 -d stagedb -U dbadmin"
# alias psql_litstream_dev2021="psql -h localhost -p 2432 -d litstream_dev -U litstream_dev_admin"
# alias psql_litstream_prod2021="psql -h localhost -p 1432 -d litstream -U litstream_admin"


# alias redis_dragon_sandbox="redis-cli -h localhost -p 9736"
# alias redis_dragon_dev="redis-cli -h localhost -p 9738"
# alias redis_dragon_prod="redis-cli -h localhost -p 9740"

# alias psql_docter_development="psql -h localhost -p 5937 -d docter -U docter"
alias psql_docter_prod="psql -h localhost -p 9439 -d docter_db_prod -U docter_admin"

alias psql_embsi_devOLD="psql -h localhost -p 6462 -d embsi_dev -U embsi_admin"

alias psql_embsi_dev="psql -h localhost -p 6482 -d emut_db_dev -U emut_dev_admin"

alias psql_embsi_prod="psql -h localhost -p 6472 -d emut_db_prod -U emut_admin"

# where am I:
# 1. added AWSLambdaVPCAccessExecutionRole policy to "dragon-api-lambda" role in IAM
# 2. put ONE of my lambdas into a VPC.
# at this point, testing the lambda directly works. But testing via the API does not (hitting endpoint from python; haven't tried direct test in AWS console)
# maybe update api_custom_authorizer lambda function...
# maybe just write a simple Flask webapp and run it there...



# alias ssh_dev_web="ssh_aws dev_web"
# alias ssh_newdev_web="ssh_aws newdev_web"


# see http://www.saxonica.com/documentation/#!about/gettingstarted/gettingstartedjava
# alias saxon="java -cp $HOME/development/tools/saxon97/saxon9he.jar"
# alias saxonq="java -cp $HOME/development/tools/saxon97/saxon9he.jar net.sf.saxon.Query -t"
# alias saxont="java -cp $HOME/development/tools/saxon97/saxon9he.jar net.sf.saxon.Transform -t"

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

if [ 0 -eq 1 ]; then
	declare -x DRAGON_11_UPGRADE="yes"

	cd $DRAGON_HOME
	current_dragon_branch=`git rev-parse --abbrev-ref HEAD`
	cd -


	if [ "${DRAGON_11_UPGRADE}" == "yes" ]; then
		# we have this split while testing so we can switch back and forth easily. Eventually
		# this should be our default.
		echo "SPLIT CONFIG (icf.bash); setting up for Java 11 upgrade work"

		if [ "${current_dragon_branch}" != "feature/fall2020upgrades" ]; then
			echo "litstream is NOT currently on the 'feature/fall2020upgrades' branch and it probably SHOULD be!"
		fi

		declare -x TOMCAT_HOME="$HOME/development/tools/tomcat/apache-tomcat-8.5.58/"
		# set DRAGON to use Java 11
		echo "corretto64-11.0.8" > $DRAGON_HOME/.java-version

		# don't need to do this; correct branch ensures it
		# cat $DRAGON_HOME/pom.xml | sed 's-.*target.*-                    <target>11</target>-' > DRAGON_HOME/fixed.xml
	else
		echo "SPLIT CONFIG (icf.bash); falling back to Java 1.8 work"

		if [ "${current_dragon_branch}" = "feature/fall2020upgrades" ]; then
			echo "litstream IS currently on the 'feature/fall2020upgrades' branch and it probably should NOT be!"
		fi

		declare -x TOMCAT_HOME="$HOME/development/tools/tomcat/apache-tomcat-9.0.0.M18/"
		echo "1.8" > $DRAGON_HOME/.java-version
		# cat $DRAGON_HOME/pom.xml | sed 's-.*target.*-                    <target>1.7</target>-' > DRAGON_HOME/pom.xml
		# cat $DRAGON_HOME/pom.xml | sed 's-.*source.*-                    <source>1.7</source>-' > DRAGON_HOME/pom.xml
	fi
else
	# echo "SPLIT LITSTREAM 8/11 CONFIG DISABLED FOR SANITY'S SAKE; see icf.bash"
	declare -x TOMCAT_HOME="$HOME/development/tools/tomcat/apache-tomcat-8.5.100/"
fi

alias gotomcat="cd $TOMCAT_HOME"

# GCLOUD SDK - installed in ~/development/tools/google-cloud-sdk
declare -x CLOUDSDK_PYTHON="/usr/local/bin/python3"


# JAVA INSTALL ON NEW LAPTOP, JULY 2021
# declare -x PATH="/usr/local/opt/openjdk@11/bin:$PATH"
# export CPPFLAGS="-I/usr/local/opt/openjdk@11/include"


# JENV - START (jenv.be)
declare -x PATH="$HOME/.jenv/bin:${PATH}"
# echo 'eval "$(jenv init -)"' >> ~/.bash_profile

export PATH="$HOME/jenv/shims:${PATH}"
export JENV_SHELL=bash
export JENV_LOADED=1
unset JAVA_HOME
# "brew --cellar jenv" will show you base path, then poke around...
source '/opt/homebrew/Cellar/jenv/0.5.7/libexec/completions/jenv.bash'
# source '/usr/local/Cellar/jenv/0.5.4/libexec/libexec/../completions/jenv.bash'
jenv rehash 2>/dev/null
jenv refresh-plugins

# alias javaHomeReset="declare -x JAVA_HOME=$(/usr/libexec/java_home)"

# aliases to switch between versions, setting JAVA_HOME appropriately
alias javaHomeReset='declare -x JAVA_HOME=$(jenv javahome)'
# alias jenv11="jenv global corretto64-11.0.12 && javaHomeReset"
# alias jenv16="jenv global openjdk64-16.0.2 && javaHomeReset"
alias jenv11="jenv global corretto64-11.0.23 && javaHomeReset"
alias jenv22="jenv global openjdk64-22.0.1 && javaHomeReset"

declare -x LAPTOP_OLD="10.0.1.190"
alias ssh_old_laptop="ssh $LAPTOP_OLD"

jenv() {
  typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  enable-plugin|rehash|shell|shell-options)
    eval `jenv "sh-$command" "$@"`;;
  *)
    command jenv "$command" "$@";;
  esac
}

javaHomeReset
# JENV - END
# installed "homebrew install java11"
# then did "jenv add /usr/local/opt/openjdk@11
# then did "jenv add /Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home
# jenv global corretto64-11.0.12 # using this as global default on my new machine
# etc.
# 

# POSTGRES INSTALLATION NOTES (via "brew install postgresql@14")
# This formula has created a default database cluster with:
  # initdb --locale=C -E UTF-8 /opt/homebrew/var/postgresql@14
# For more details, read:
  # https://www.postgresql.org/docs/14/app-initdb.html
# 
# To start postgresql@14 now and restart at login:
  # brew services start postgresql@14
# Or, if you don't want/need a background service you can just run:
  # /opt/homebrew/opt/postgresql@14/bin/postgres -D /opt/homebrew/var/postgresql@14
# ==> Summary
# 🍺  /opt/homebrew/Cellar/postgresql@14/14.12: 3,322 files, 46.1MB
# ==> Running `brew cleanup postgresql@14`...
# Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
# Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
# ==> Caveats
# ==> postgresql@14
# This formula has created a default database cluster with:
  # initdb --locale=C -E UTF-8 /opt/homebrew/var/postgresql@14
# For more details, read:
  # https://www.postgresql.org/docs/14/app-initdb.html
# 
# To start postgresql@14 now and restart at login:
  # brew services start postgresql@14
# Or, if you don't want/need a background service you can just run:
  # /opt/homebrew/opt/postgresql@14/bin/postgres -D /opt/homebrew/var/postgresql@14


# MONGO INSTALLATION NOTES (via homebrew; I installed via "brew install mongodb-community@5.0"
# mongodb-community@5.0 is keg-only, which means it was not symlinked into /opt/homebrew,
# because this is an alternate version of another formula.
# 
# If you need to have mongodb-community@5.0 first in your PATH, run:
  # echo 'export PATH="/opt/homebrew/opt/mongodb-community@5.0/bin:$PATH"' >> /Users/38593/.bash_profile
# 
# To start mongodb/brew/mongodb-community@5.0 now and restart at login:
  # brew services start mongodb/brew/mongodb-community@5.0
# ==> Summary
# 🍺  /opt/homebrew/Cellar/mongodb-community@5.0/5.0.27: 13 files, 188.2MB, built in 2 seconds
# ==> Running `brew cleanup mongodb-community@5.0`...
# Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
# Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
# ==> Caveats
# ==> mongodb-community@5.0
# mongodb-community@5.0 is keg-only, which means it was not symlinked into /opt/homebrew,
# because this is an alternate version of another formula.
# 
# If you need to have mongodb-community@5.0 first in your PATH, run:
  # echo 'export PATH="/opt/homebrew/opt/mongodb-community@5.0/bin:$PATH"' >> /Users/38593/.bash_profile
# 
# To start mongodb/brew/mongodb-community@5.0 now and restart at login:
  # brew services start mongodb/brew/mongodb-community@5.0


# MYSQL INSTALLATION NOTES VIA HOMEBREW ("brew install mysql")
# We've installed your MySQL database without a root password. To secure it run:
    # mysql_secure_installation
#
# MySQL is configured to only allow connections from localhost by default
#
# To connect run:
    # mysql -u root
#
# To start mysql now and restart at login:
  # brew services start mysql
# Or, if you don't want/need a background service you can just run:
  # /opt/homebrew/opt/mysql/bin/mysqld_safe --datadir\=/opt/homebrew/var/mysql



# I installed pyenv with homebrew; is any of this actually needed?
if [ 1 -eq 1 ]; then
	declare -x PYENV_ROOT="$HOME/.pyenv"
	declare -x PATH="$PYENV_ROOT/bin:$PATH"
	declare -x PATH="$PYENV_ROOT/shims:$PATH"
	# export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
	export PYENV_SHELL=bash
	# see "brew --cellar pyenv" for base path, then poke around
	source '/opt/homebrew/Cellar/pyenv/2.4.2/completions/pyenv.bash'
	eval "$(pyenv init -)"
fi

# 20240124 I installed the github CLI, see https://dev.to/github/stop-struggling-with-terminal-commands-github-copilot-in-the-cli-is-here-to-help-4pnb
# but it seems out account doesn't have Copilot CLI enabled.
# alias copilot='gh copilot'
# alias gcs='gh copilot suggest'
# alias gce='gh copilot explain'

alias mysql_localserver_start="mysql.server start"
alias mysql_localserver_stop="mysql.server stop"
alias mysql_localserver_restart="mysql.server restart"

alias aws_whoami="aws sts get-caller-identity"

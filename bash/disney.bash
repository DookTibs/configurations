# declare -x FLEX_HOME="/Users/tfeiler/development/tools/flex/flex_sdk_4.6/"
# alias mymongo='mongo 127.0.0.1:27017/pipeline'

# alias nodemonloc='nodemon -e .js app.js --configFile ../../config/fullLocal.json'
alias nodemonloc="find -E . -regex './(api_core|worker|portal).js' -exec nodemon -e .js {} --configFile ../../config/fullLocal.json \;"

# clojure related
# alias clojure='java -cp ~/development/clojure/clojure-1.5.1/clojure-1.5.1.jar clojure.main'

# node related - for some reason node global installed stuff never seems added to my PATH or /bin or wherever it's sposed to?
# alias nodemon="/usr/local/share/npm/lib/node_modules/nodemon/nodemon.js"
# alias karma="/usr/local/share/npm/lib/node_modules/karma/bin/karma"
# declare -x PATH=${PATH}:/usr/local/share/npm/lib/node_modules/karma/bin

# tomcat related
# alias tcStart='$CATALINA_HOME/bin/startup.bat'
# alias tcStop='$CATALINA_HOME/bin/shutdown.bat'
# alias tcTail='tail -f $CATALINA_HOME/logs/tomcat.log'

# club penguin aliases
# declare -x CLUBPENGUIN="${HOME}/development/clubpenguin/mpclubpenguin/"

# screen aliases
# alias screenp="screen -c ${HOME}/screenConfigs/cpdev"
# alias screenf="screen -c ${HOME}/screenConfigs/fairies"
# alias sb='. switchBranch.sh'

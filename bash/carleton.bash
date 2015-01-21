declare -x REASON_WSG="/Users/tfeiler/remotes/wsgTfeilerReasonCore/reason_package_20140404"
declare -x REASON_VENT="/Users/tfeiler/remotes/ventnorTfeilerReason/reason_package"
declare -x MOODLE_WSG="/Users/tfeiler/remotes/wsgTfeilerMoodle"

alias rps='source /Users/tfeiler/development/shellScripts/special/rps.sh'

# see http://osxfuse.github.io/
alias smount_moodle="mountSsh.sh $_CARL_MY_USERNAME@$_DEV_MOODLE_SERVERNAME:$_SERVPATH_MOODLE wsgTfeilerMoodle 22"
alias smount_wsg="mountSsh.sh $_CARL_MY_USERNAME@$_DEV_MOODLE_SERVERNAME:$_SERVPATH_MOODLECORE wsgTfeilerReasonCore 22"
alias smount_vent="mountSsh.sh $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME:$_SERVPATH_SLOTE ventnorTfeilerReason 22"
alias smount_clamp="mountSsh.sh $_CARL_MY_USERNAME@$_CLAMP_SERVERNAME:$_SERVPATH_CLAMP mitreClampHome 22"
alias smount_comps="mountSsh.sh $_CARL_MY_USERNAME@$_LIVE_COMPS_SERVERNAME:$_SERVPATH_COMPS persiaComps 22"
alias smount_omeka="mountSsh.sh $_CARL_MY_USERNAME@$_DEV_OMEKA_SERVERNAME:$_SERVPATH_OMEKA wsgOmeka 22"

# ssh shortcuts
alias ssh_wsg="ssh -2 $_CARL_MY_USERNAME@$_DEV_MOODLE_SERVERNAME"
alias ssh_vent="ssh -2 $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME"
alias ssh_persia="ssh -2 $_CARL_MY_USERNAME@$_LIVE_COMPS_SERVERNAME"
alias ssh_chi="ssh -2 $_CARL_MY_USERNAME@$_LIVE_APPS_SERVERNAME"
alias ssh_chi5="ssh -2 $_CARL_MY_USERNAME@$_LIVE_WWW_SERVERNAME"
alias ssh_mitre="ssh -2 $_CARL_MY_USERNAME@mitre.clamp-it.org"

# mysql aliases
alias mysql_vent="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'mysql -u$_DEV_RSN_DB_USER -p$_DEV_RSN_DB_PASS $_DEV_RSN_DB_NAME_MYDEV'"
alias mysql_ventTest="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'mysql -u$_DEV_RSN_DB_USER -p$_DEV_RSN_DB_PASS $_DEV_RSN_DB_NAME_TEST'"
alias mysql_mbsOld="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'mysql -u$_DEV_MBS_DB_USER -p$_DEV_MBS_DB_PASS $_DEV_MBS_DB_NAME'"
alias mysql_moodle="ssh -t $_CARL_MY_USERNAME@$_DEV_MOODLE_SERVERNAME 'mysql -u$_DEV_MOODLE_DB_USER -p$_DEV_MOODLE_DB_PASS $_DEV_MOODLE_DB_NAME'"
alias mysql_thor="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'mysql -u$_DEV_RSN_DB_USER -p$_DEV_RSN_DB_PASS $_DEV_RSN_DB_NAME_THORDEV'"
alias mysql_doc="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'mysql -u$_DOC_DB_USER -p$_DOC_DB_PASS $_DOC_DB_NAME -h$_CARLETON_LIVE_MYSQL_SERVER'"

alias errorlog_vent="ssh -t $_CARL_MY_USERNAME@$_DEV_RSN_SERVERNAME 'tail -f $_SERVPATH_ERRLOG'"

alias moodleCheck='~/development/moodle/tools/PHP_CodeSniffer-2.0.0a2/scripts/phpcs --standard=/Users/tfeiler/development/moodle/tools/moodleCodeChecker/moodle/ruleset.xml'

alias goremotes='cd ~/remotes/'
alias goslote='cd ~/remotes/ventnorTfeilerReason/'
alias goform='cd ~/development/jsloteFormBuilder/formbuilder-rsn'
alias goomeka='cd ~/remotes/wsgOmeka/'

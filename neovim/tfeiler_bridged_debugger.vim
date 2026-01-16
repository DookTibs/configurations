let g:dvb_default_configuration = "hudnexus"

" register a configuration with DVB
let g:dvb_configurations["pydemo"] = {
	\"dvb_type": "pdb",
	\"bridge": {
		\"port": 4949,
		\"tmux_target": "DVB:tibsTesting.2"
	\},
	\"debugger": {
		\"launch_cmd": "python hello.py",
		\"tmux_target": "DVB:tibsTesting.1"
	\},
\}

" doesn't seem to work...
let g:dvb_configurations["hudnexus"] = {
	\"dvb_type": "pdb",
	\"bridge": {
		\"port": 4951,
		\"tmux_target": "HUDNEXUS:backend.1"
	\},
	\"debugger": {
		\"launch_cmd": "uvicorn api:app",
		\"tmux_target": "HUDNEXUS:backend.0"
	\},
\}

" not quite working yet...
let g:dvb_configurations["litstream"] = {
	\"dvb_type": "jdb",
	\"bridge": {
		\"port": 4950,
		\"tmux_target": "DRAGON:main.2"
	\},
	\"debugger": {
		\"launch_cmd": "jdb -connect com.sun.jdi.SocketAttach:port=9005,hostname=localhost -sourcepath /Users/38593/development/icf_dragon/src/main/java/",
		\"_launch_cmd": "jdb -attach 9005",
		\"tmux_target": "DRAGON:main.1",
		\"code_base_path": "/Users/38593/development/icf_dragon/src/main/java/"
	\},
\}

let g:dvb_configurations["hawc"] = {
	\"dvb_type": "pdb",
	\"bridge": {
		\"port": 4905,
		\"tmux_target": "HAWC:mycode.2"
	\},
	\"debugger": {
		\"launch_cmd": "manage.py runserver" ,
		\"tmux_target": "HAWC:mycode.1"
	\},
\}

let g:dvb_configurations["pytrim_deployer"] = {
	\"dvb_type": "pdb",
	\"bridge": {
		\"port": 4902,
		\"tmux_target": "DVB:tibsTesting.2"
	\},
	\"debugger": {
		\"launch_cmd": "python pytrim_deploy.py -c ../../../unsynced/dev.json -m elastic_ip",
		\"tmux_target": "DVB:tibsTesting.1"
	\},
\}

let g:dvb_configurations["javademo"] = {
	\"dvb_type": "jdb",
	\"bridge": {
		\"port": 5151,
		\"tmux_target": "DVB:tibsTesting.3"
	\},
	\"debugger": {
		\"launch_cmd": "jdb -attach 2121",
		\"tmux_target": "DVB:tibsTesting.2",
		\"code_base_path": "/Users/38593/development/sampleJavaDebug/"
	\},
\}



" exe 'nnoremap ' . g:dvb_leader . 'C' . ' :echo "hi!"<enter>'

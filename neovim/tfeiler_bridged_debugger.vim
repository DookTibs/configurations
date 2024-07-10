let g:dvb_default_configuration = "javademo"

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
		\"tmux_target": "DVB:tibsTesting.2"
	\},
	\"debugger": {
		\"launch_cmd": "jdb -attach 2121",
		\"tmux_target": "DVB:tibsTesting.1",
		\"code_base_path": "/Users/38593/development/sampleJavaDebug/"
	\},
\}



" exe 'nnoremap ' . g:dvb_leader . 'C' . ' :echo "hi!"<enter>'

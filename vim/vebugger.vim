" use "comma" as the leader command for debugging commands.

let g:vebugger_leader=','
let g:vebugger_use_tags=1
" let g:vebugger_view_source_cmd='edit'

" map d to something
exe 'nnoremap ' . g:vebugger_leader . 'd' . ' :call LaunchDragonDebugger()<enter>'

function! LaunchDragonDebugger()
	call vebugger#jdb#start('', {'srcpath': 'C:/Users/38593/workspace/icf_dragon/src/main/java/', 'args':['-connect', 'com.sun.jdi.SocketAttach:port=9005,hostname=localhost']})
endfunction

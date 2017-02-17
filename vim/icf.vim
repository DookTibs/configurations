" echo "Current Dir is:" currentDir

" set tags to whoever's install I'm looking at
if stridx("foo", "bar") == 0
elseif stridx(currentDir, "/home/38593/development/dragon_api") == 0
	map <BS> :call DragonAPITestSwitcher()<enter>
	map \ :call DragonAPITestRunner()<enter>
elseif stridx(currentDir, "/home/38593/development/acc") == 0
	map <BS> :call CellmateUpload("blink")<enter>
	map \ :call ReloadChromeTab("https://awesome-table.com")<enter>
elseif stridx(currentDir, "/cygdrive/c/Users/38593/workspace/icf_dragon") == 0
	let projectTags = "/cygdrive/c/Users/38593/workspace/icf_dragon/src/main/java/.dragonOnlineJavaTags"
	let jdkTags = "/home/38593/development/java/jdk_source/jdktags"
	let &tags = "tags," . projectTags . "," . jdkTags

	map <BS> :call SendFreshCommandToTMUX("tomcatHelper.sh redeploy")<enter>
endif

map <C-P> :r! cat /dev/clipboard<enter>

" based on the currently active edit window, figure out the last dir we are in and the part of the API we're looking
" at. We'll use this for things like switching between test/main source files, triggering appropriate test/deploy 
" commands, etc.
function! DragonAPIGetContext()
	let workingDir = system("pwd")
	let workingDir = substitute(workingDir, "\n", "", "")
	let workingDir = fnamemodify(workingDir, ':t')

	let currFilename = @%

	if (workingDir == "test")
		let lambdaName = substitute(currFilename, "_test", "", "")
		let lambdaName = substitute(lambdaName, ".py", "", "")
	else
		let lambdaName = workingDir
	endif

	let context = {'dir': workingDir, 'filename': currFilename, 'lambda': lambdaName}
	return context
endfunction

" based on the file I am editing, fire off the relevant test command
" takes optional param to specify the tmux target; defaults to pane 1 of current window
function! DragonAPITestRunner(...)
	let tmuxTarget="1"
	if a:0 > 0
		let tmuxTarget = a:1
	end

	let ctx = DragonAPIGetContext()
	call SendFreshCommandToTMUX("pyb runLocalTest -P lambda='" . ctx.lambda . "'", tmuxTarget)
endfunction

" based on the file I am editing, easily switch between the lambda implementation and the test script
function! DragonAPITestSwitcher()
	let ctx = DragonAPIGetContext()
	
	if (ctx.dir == "test")
		let targetFile = "../main/python/" . ctx.lambda . "/" . ctx.lambda . ".py"
	else
		let targetFile = "../../../test/" . ctx.lambda . "_test.py"
	endif

	try
		execute 'edit' targetFile
	catch
		echo "Unable to switch to " . targetFile . "; do you have unsaved changes?"
	endtry
endfunction

function! PublishLambda()
	echo "PublishLambda::start()"
	call inputsave()
	let versionDetails = input("Enter commit msg (leave blank to cancel): ")
	call inputrestore()
	echo "\n"

	if (versionDetails == "")
		echo "operation cancelled"
	else
		echo "Do something with [" . versionDetails . "]"
	endif
endfunction

" TODO - a AWS Lambda/API deploy function that asks for a message? Haven't done a Vimscript funciton yet that take sinput, could be interesting

" suggested by Eclim author
let g:SuperTabDefaultCompletionType = 'context'

let g:SuperTabContextDefaultCompletionType = "<c-n>"

" :lnext will jump to the next placed 'sign' - these are those markers that Eclim 
" dumps in the leftmost column to show compilation problems. :lprev goes backwards
" :ToggleLocationWindow toggles Vim's location-list window which gives details as to what the problem is
" leader is \ by default - I use this key for LOTS of stuff. It still works,
" but any command on \ is slower now that I am using leaders for stuff
nnoremap <silent> <buffer> <leader>w :call ToggleLocationWindow()<enter>
nnoremap <silent> <buffer> <leader>n :lnext<enter>
nnoremap <silent> <buffer> <leader>p :lprev<enter>

" for fast development reloading...
" :map <BS> :source icf.vim<enter>

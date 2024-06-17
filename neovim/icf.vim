" echo "Current Dir is:" currentDir


" set tags to whoever's install I'm looking at
if stridx("foo", "bar") == 0
elseif stridx(currentDir, "/Users/38593/development/expoagg-pipeline/serverless/expoagg-pipeline/py_handlers") == 0
	map \ :call RunCurrentExpoaggLambda("1")<enter>
elseif stridx(currentDir, $DRAGON_HOME . "src/main/CloudFormation") == 0
	set expandtab
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
	set syntax=yaml
elseif stridx(currentDir, "/Users/38593/development/llr/llrsim") == 0
	" let's try it instead with git commit hooks...
	" if executable("black") == 0
		" echo "WARNING - cannot find black/etc. on PATH; probably not in right venv."
		" echo "Consider quitting and run 'workon llrsim' before re-opening Vim"
	" else
		" echo "black will run on save...run 'cd /Users/38593/development/llr/llrsim && make lint' before pushing to Github"
		" autocmd BufWritePost *.py silent! !black -q --config /Users/38593/development/llr/llrsim/pyproject.toml %
	" endif
	map \ :call LlrSimDevUtil(1)<enter>
elseif stridx(currentDir, "/Users/38593/development/hawc_project/hawc") == 0
	" let &tags = "tags," . "/Users/38593/development/hawc_project/hawc/.hawcTags"
	let &tags = "tags," . "/Users/38593/development/hawc_project/hawc/.hawcTags," . "/Users/38593/development/hawc_project/hawc/.hawcVirtualEnvInstalledPackagesTags"


	" 2023 - HAWC switched linters from flake8 -> ruff
	" let hawcLinter="flake8"
	let hawcLinter="ruff"

	" CONSIDER MOVING SOME/ALL OF THIS OUT OF HAWC-SPECIFIC CONFIG AND INTO MAIN - ALE SEEMS MIGHTY USEFUL!!!
	" right now I'm just using a small part of ALE; my attempts to get things like symbol definition/autocomplete
	" were kind of annoying. Sticking with ctags for now; it's fast, good enough, and I understand it.
	if executable(hawcLinter) == 0
		echo "WARNING - cannot find " . hawcLinter . "/etc. on PATH; probably not in right venv."
		echo "Consider quitting and run 'activatehawc' before re-opening Vim"
	else
		" see https://github.com/dense-analysis/ale/tree/master/doc
		" let g:ale_linters = {'javascript': ['eslint'], 'python': [hawcLinter]}
		" let g:ale_fixers = {'javascript': ['eslint'], 'python': ['black', hawcLinter]}
		" this .flake8 file coems with the HAWC repo...

		" 2023-10 changes
		" I can't get Black working properly so let's go old school instead:
		" (see plugins.vim; official psf/black doesn't work with neovim, and the alternate I found
		" doesn't seem to work either)
		" 1. disable it from ALE config...
		let g:ale_linters = {'javascript': ['eslint'], 'python': []}
		let g:ale_fixers = {'javascript': ['eslint'], 'python': []}

		" echo "RUFF disabled; run 'make format' manually before committing/pushing..."

		" echo "stuff runs on save...run 'cd $HAWC_HOME && \"make lint\" (to check) / \"make format\" (to fix)' before push to Github"
		" autocmd BufWritePost *.py silent! !black -q --config /Users/38593/development/hawc_project/hawc/pyproject.toml %
		" autocmd BufWritePost *.py silent! !ruff format %
		"autocmd BufWritePost *.py echo "write pythong!" . "(" . getcwd() . ")"

		" https://vimtricks.com/p/get-the-current-file-path/
		echo "ruff re-enabled...but also run 'make lint' and 'make format' and run tests before pushing to Github"
		autocmd BufWritePost *.py silent !/Users/38593/development/configurations/neovim/ruffHelper.sh %:p



		if hawcLinter == "flake8"
			let g:ale_python_flake8_options = '--config=/Users/38593/development/hawc_project/hawc/.flake8'
		elseif hawcLinter == "ruff"
			" let g:ale_python_ruff_options = '--fix --show-fixes --config=/Users/38593/development/hawc_project/hawc/pyproject.toml'
			" let g:ale_python_ruff_options = '--fix'
		endif
		" let g:ale_linters_explicit = 1
		
		" I'd rather use the quickfix window; lets me use "unimpaired" to quickly move through any errors
		let g:ale_set_loclist = 0
		let g:ale_set_quickfix = 1
		let g:ale_open_list = 1

		" wheneer we save, ALE will attempt to fix simple errors (extra whitespace, etc.)
		let g:ale_fix_on_save = 1
		" can also use :ALEFix to fix code on demand
		
		" TODO - install a language server and try to get autocomplete / codehinting / etc. working with ALE!
		" this gets us at least some autocompletion but I'm not really digging it...it pops up automatically, 
		" is not working right with things I define, etc. I'd rather just use ctags for now.
		if 1 == 0
			let g:ale_linters = {'javascript': ['eslint'], 'python': ['pyls','flake8']}
			let g:ale_completion_delay = 100
			let g:ale_completion_enabled = 1
		endif
	endif
	
	
	" prior to discovering ALE I was using vim-flake8 plugin. Disabled for now.
	if 1 == 0
		" when saving a python file, fire flake8 linter. Note you need the hawc2020 Conda
		" environment running (like via 'activatehawc' alias).
		autocmd BufWritePost *.py call flake8#Flake8()

		" show markers in the gutter and in the exact position, where problems occur
		let g:flake8_show_in_gutter=1
		let g:flake8_show_in_file=1

		" the vim-flake8 plugin doesn't respect project specific .flake8 files by default, we need to force it
		let g:flake8_cmd="/Users/38593/opt/anaconda3/envs/hawc2020/bin/flake8\ --config=/Users/38593/development/hawc_project/hawc/.flake8"
		
		" I use tpope's "unimpaired" plugin; can use [q / ]q to go to prev/next error. [Q to go to the first.
		" Then you can use spacebar+q / spacebar+Q to navigate quickly through the quickfix list
		" nnoremap <silent> <buffer> <leader>q :cn<enter>
		" nnoremap <silent> <buffer> <leader>Q :cp<enter>
	endif

elseif stridx(currentDir, "/Users/38593/development/hawc/epahawc") == 0
	let &tags = "tags," . "/Users/38593/development/hawc/epahawc/.hawcTags"
	
	" \ should send the cache.clear() command to the manage.py shell running in the tmux HAWC_SERVERS session,
	" window 1, pane 1
	" map \ :call SendFreshCommandToTMUX("cache.clear()", "HAWC_SERVERS:1.1")<enter>
	
	" backspace should add some empty spaces on the debug console running in the tmux HAWC_SERVERS session,
	" window 1, pane 0
	map <BS> :call SendKeysToTMUX("HAWC_SERVERS:1.0", "Enter")<enter>

elseif stridx(currentDir, "/Users/38593/development/fhwa") == 0
	" map caret to wrap the next character in a "superscript" tag (think footnotes)
	map ^ li<sup>la</sup>

	" map backspace to wrap a line in the figure source footer style
	map <BS> I<tab><tab><tab><p class="figure-source">A</p>j

	" map @ to wrap cell text in "strong" and move to next line (1j replace with 8j or so to do columns
	map @ i<strong>/</tdi</strong>1j0/">ll
	map # i<em>/</tdi</em>1j0/">ll

	" map \ to reload the browser
	map \ :call ReloadChromeTab("localhost:4444")<enter>

	" and automatically run the compiler whenever I save
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh chap1.html 'CHAPTER 1: System Assets' CHAP1","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh chap2.html 'CHAPTER 2: Funding' CHAP2","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh chap3.html 'CHAPTER 3: Travel' CHAP3","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh chap4.html 'CHAPTER 4: Mobility and Access' CHAP4","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh chap5.html 'CHAPTER 5: Safety' CHAP5","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh chap6.html 'CHAPTER 6: Infrastructure Conditions' CHAP6","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh chap7.html 'CHAPTER 7: Capital Investment Scenarios' CHAP7","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh chap8.html 'CHAPTER 8: Supplemental Analysis' CHAP8","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh chap9.html 'CHAPTER 9: Sensitivity Analysis' CHAP9","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh chap10.html 'CHAPTER 10: Impacts of Investment' CHAP10","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh part4.html 'PART IV: Additional Information' PART4","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh chap13.html 'CHAPTER 13: Multimodal Transportation Systems: Pedestrian and Bicycle' CHAP13","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh part5.html 'PART V: Changes to the Highway Performance Monitoring System' PART5","2")
	" autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh part6.html 'PART VI: Appendices' PART6","2")
	autocmd BufWritePost *.html :call SendFreshCommandToTMUX("./fhwaCompiler.sh appendixb.html 'APPENDIX B: Bridge Investment Analysis Methodology' APPB","2")


elseif stridx(currentDir, "/Users/38593/development/uncertainty") == 0
	map <BS> :call ReloadChromeTab("localhost:5000")<enter>
	map \ :call SendFreshCommandToTMUX("python application.py")<enter>
	let &tags = "tags," . "/Users/38593/development/uncertainty/flask/.embsiTags"

	" let g:lsc_server_commands = { 'python': 'pyls' }
	" let g:lsc_auto_map = v:true " use default vim-lsc mappings
elseif stridx(currentDir, "/Users/38593/development/trim-builder") == 0
	map <BS> :call ReloadChromeTab("localhost:6060")<enter>
	let &tags = "tags," . "/Users/38593/development/trim-builder/.trimTags"
elseif stridx(currentDir, "/Users/38593/development/docter_online") == 0
	map <BS> :call ReloadChromeTab("localhost:5678")<enter>
	let &tags = "tags," . "/Users/38593/development/docter_online/.docterOnlineTags"

elseif stridx(currentDir, "/Users/38593/development/dragon_api") == 0
	" old Lambda mappings
	" let g:tibs_search_basedir="/Users/38593/development/dragon_api"
	" let &tags = "tags," . "/Users/38593/development/dragon_api/src/aws_lambda/main/python/.heroApiTags"
	" map <BS> :call DragonAPITestSwitcher()<enter>
	" map \ :call DragonAPITestRunner()<enter>
	
	" new Flask mappings
	map \ :call SendFreshCommandToTMUX("python application.py", "1")<enter>
	map <BS> :call SendFreshCommandToTMUX("python endpointTester.py local tom.feiler@icf.com /assessments/164241/studies?outputMapper=HeroMapper", "3")<enter>
elseif stridx(currentDir, "/Users/38593/development/acc") == 0
	map <BS> :call CellmateUpload("blink")<enter>
	map \ :call ReloadChromeTab("https://awesome-table.com")<enter>
" elseif stridx(currentDir, "/Users/38593/development/icf_dragon/src/main/scripts/customJsScriptStorage") == 0
elseif stridx(currentDir, "/Users/38593/development/icf_dragon/src/main/scripts/flexFormCustomJsScripts") == 0
	autocmd BufWritePost *.js :call StuffFlexFormJs()
elseif stridx(currentDir, "/Users/38593/development/icf_dragon") == 0
	" let g:lsc_server_commands = { 'java': '/Users/38593/development/tools/java-language-server/dist/lang_server_mac.sh' }
	" let g:lsc_auto_map = v:true " use default vim-lsc mappings
	
	let g:tibs_search_basedir="/Users/38593/development/icf_dragon/"
	let projectTags = "/Users/38593/development/icf_dragon/src/main/java/.dragonOnlineJavaTags"
	let jdkTags = "/Users/38593/development/java/jdk_source/jdktags"
	" let &tags = "tags," . projectTags . "," . jdkTags
	let &tags = "tags," . projectTags

	" map <BS> :call SendFreshCommandToTMUX("tomcatHelper.sh redeploy")<enter>
	map <BS> :call DragonOnlineDevUtil(1)<enter>

	autocmd BufWritePost * :call DragonOnlineDevUtil(0)
	" map \ :call ReloadChromeTab("explorer")<enter>

elseif stridx(currentDir, "/Users/38593/development/java/ris") == 0
	map <BS> :call SendFreshCommandToTMUX("ant")<enter>
	map \ :call SendFreshCommandToTMUX("java -jar dist/lib/RisImporter.jar")<enter>
endif


if $TOM_OS == 'cygwin'
	map <C-P> :r! cat /dev/clipboard<enter>
else
	map <C-P> :r! pbpaste<enter>
endif

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

function! StuffFlexFormJs()
	let currentDir = system("pwd")
	let currentDir = substitute(currentDir, "\n", "", "")
	let fullPath = currentDir . "/" . @%
	
	" old way, talks to flex_form_configurations
	let stuffCmd = $DRAGON_HOME . "/src/main/scripts/flexFormCustomJsHelper.py stuff " . fullPath
	
	" new way, talks to custom_step_scripts and shared_custom_scripts
	" let stuffCmd = $DRAGON_HOME . "/src/main/scripts/litstreamCustomJsHelper.py -o stuff -f " . fullPath
	" echo stuffCmd
	call system(stuffCmd)

	if (v:shell_error != 0)
		" checks exit code of flexFormCustomJsHelper.py; if non-zero, display this hint...
		echo "error stuffing (" . v:shell_error . ") - this will only work if using a Python VM with psycopg2 (like flexform_customjs)"
	" else
		" echo "Remember - if this was a new shared script, reload your buffer!"
	endif
endfunction

function! DragonOnlineDevUtil(userInteraction)
	" should break this into a fxn
	let currentDir = system("pwd")
	let currentDir = substitute(currentDir, "\n", "", "")

	if stridx(currentDir, "/Users/38593/development/icf_dragon/src/main/webapp/css") == 0
		if (a:userInteraction == 1)
			" let copyCmd = 'cp /Users/38593/development/icf_dragon/src/main/webapp/css/main.css /Users/38593/development/tools/tomcat/apache-tomcat-9.0.0.M18/webapps/ROOT/css/'
			let copyCmd = 'cp /Users/38593/development/icf_dragon/src/main/webapp/css/main.css $TOMCAT_HOME/webapps/ROOT/css/'
			call system(copyCmd)
			echo "copied main.css to TOMCAT_HOME (did you have gulp running?)..."
		endif
	elseif stridx(currentDir, "/Users/38593/development/icf_dragon/src/main/webapp") == 0
		" let fullPath = currentDir . "/" . @%
		silent write " save the file
		let relativeDir = substitute(currentDir, ".*icf_dragon/src/main/webapp", "", "")
		let relativeFilePath = relativeDir . "/" . @%
		" echo "sync webapp file [" . relativeDir . "]    [" . relativeFilePath . "]"
		let copyCmd = 'cp "' . currentDir . "/" . @% . '" "$TOMCAT_HOME/webapps/ROOT' . relativeDir . '/"'
		call system(copyCmd)

		" let curlCmd = 'curl "http://localhost:8081' . relativeFilePath . '"'
		" call system(curlCmd)
		if (a:userInteraction == 1)
			echo "copied " . relativeDir . "/" . @% . " to $TOMCAT_HOME webapps dir..."
		" else just do it silently in the background...
		endif
	elseif stridx(currentDir, "/Users/38593/development/icf_dragon/src/main/java") == 0
		" we only trigger a reploy if we actually launched the command intentionally.
		" if this fired as a result of a save action, we don't do it.
		if (a:userInteraction == 1)
			" cancel whatever's running, and then redeploy/rewatch
			
			" old way - in pane 1 of my current window
			" call SendFreshCommandToTMUX("C-c")
			" call SendFreshCommandToTMUX("tomcatHelper.sh redeploy && tomcatHelper.sh watch")

			" new way - in a window named "dragonTomcat"
			call system("createTmuxWindowIfNotThere.sh dragonTomcat")
			call SendFreshCommandToTMUX("C-c", "dragonTomcat")
			call SendFreshCommandToTMUX("tomcatHelper.sh redeploy && tomcatHelper.sh watch", "dragonTomcat")
			call system("tmux select-window -t 'dragonTomcat'")


			" echo "Build initiated in 'dragonTomcat' window..."
		endif
	else
		" echo "don't know how to handle this in " . currentDir . "..."
	endif
endfunction

function! RunCurrentExpoaggLambda(...)
	let tmuxTarget="1"
	let customEvent=v:null
	if a:0 > 0
		let tmuxTarget = a:1
	end

	if a:0 > 1
		let customEvent = a:2
	end

	" echo "runncurr, target='" . tmuxTarget . "', customEvent='" . customEvent . "'"

	" let workingDir = system("pwd")
	" let workingDir = substitute(workingDir, "\n", "", "")
	" let workingDir = fnamemodify(workingDir, ':t')

	let currFilename = @%
	" echo "file is " . currFilename

	let lambdaName = substitute(currFilename, ".py", "", "")
	" echo "lambda is " . lambdaName

	if customEvent is v:null
		call SendFreshCommandToTMUX("./runLambdaLocally.py " . lambdaName, tmuxTarget)
	else
		call SendFreshCommandToTMUX("./runLambdaLocally.py -f " . lambdaName . " -e " . customEvent, tmuxTarget)
	endif
endfunction

function! LlrSimDevUtil(userInteraction)
	let currentDir = system("pwd")
	let currentDir = substitute(currentDir, "\n", "", "")

    if stridx(currentDir, "/Users/38593/development/llr/llrsim") == 0
		" we only trigger a reploy if we actually launched the command intentionally.
		" if this fired as a result of a save action, we don't do it.
		if (a:userInteraction == 1)
			" cancel whatever's running, and then redeploy/rewatch
			
			" new way - in a window named "runner"
			call system("createTmuxWindowIfNotThere.sh runner")
			call SendFreshCommandToTMUX("C-c", "runner")
			call SendFreshCommandToTMUX("llrsim -c /Users/38593/development/llr/llrsim/sample_config.yml -o /Users/38593/development/llr/unsynced/output/", "runner")
			call system("tmux select-window -t 'runner'")
		endif
	else
		echo "don't know how to handle this in " . currentDir . "..."
	endif
endfunction

" for fast development reloading...
" map r :source ~/development/configurations/vim/icf.vim<enter>

" June 2024 - on my new laptop by default neovim prints a warning but then happily lets you edit in 
" multiple buffers. This is asking fo rtrouble.
function! SwapFix()
	echo "Warning - swap file for '" . expand("%") . "' ('" . v:swapname . "') exists; setting to read-only"
	let v:swapchoice="o"
endfunction
" autocmd SwapExists * let v:swapchoice="o"
autocmd SwapExists * call SwapFix()

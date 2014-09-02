" prior to splitting this up into separate files, this was my .vimrc as of 2014-09-02.
"
"
"
"
"
" STUFF TO INSTALL
" Brew
" exuberant ctags
" Node.js
"
" PLUGINS TO INSTALL
" taglist
" tmux_navigator
" slime?
"

" see http://www.openlogic.com/wazi/bid/262302/Three-tools-for-managing-Vim-plugins (has typos)
" for instance, to install my standard set of plugins, after Pathogen was set
" up, I did the following:
"		git clone git://github.com/christoomey/vim-tmux-navigator ~/.vim/bundle/vim-tmux-navigator
"		git clone git://github.com/vim-scripts/taglist.vim.git ~/.vim/bundle/taglist
"		git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline
let g:pathogen_disabled = []
" call add(g:pathogen_disabled, 'vim-airline')
execute pathogen#infect()

" airline
" always show the status line
set laststatus=2
" enable 256 colors - not strictly an airline thing, but that's where I came across it
set t_Co=256
let g:airline_powerline_fonts=1
let g:airline_theme='kolor'

" statusline experiments
function SetCustomStatusLine()
	call UpdateReasonPackageSwitcher()
	" return "RPS=[" . $RPS . "]"
	return "%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P"
endfunction

function UpdateReasonPackageSwitcher()
	let destinationPath = system("source /Users/tfeiler/development/shellScripts/special/rps.sh info")
	let newlineChopper = split(destinationPath, "\n")
	let rpsPath = newlineChopper[0]
	let $RPS = newlineChopper[0]
endfunction

" see http://www.blaenkdenum.com/posts/a-simpler-vim-statusline/ for example
" of making custom function output part of the status line.
" this fires every few seconds and also whenever you switch active buffers
" set statusline=%!SetCustomStatusLine()
" set statusline=%{SetCustomStatusLine()}

" vimdiff didn't work on OSX for me; I had to do:
" sudo ln -s /usr/bin/diff /usr/share/vim/vim73diff
" to get it working right

" colorschemes live in /usr/share/vim/vim73/colors/
" others that are ok: torte, delek, darkblue, slate, zellner
" also have some in ~/.vim/bundle like vim-colors-solarized (along with other plugins)
" colorscheme torteTibs
" colorscheme torte

" if doing solarized, need other stuff
" syntax enable
set background=dark
colorscheme solarized " see https://github.com/altercation/vim-colors-solarized / http://ethanschoonover.com/solarized

" this vimrc is used by cygwin vim.
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim

" stuff moved from mswin.vim so we don't take all of it - start
" next two lines are commented out on OSX but uncommented on Windows
" behave mswin
" set backspace=indent,eol,start whichwrap+=<,>,[,]
" these are commented out everywhere
" map <C-V>		"+gP
" cmap <C-V>		<C-R>+
" stuff moved from mswin.vim so we don't take all of it - end

set nu
set ai
highlight Normal guibg=Black guifg=White
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set incsearch
set hlsearch
syntax on
filetype on

" set working directory to whatever we just opened, interesting...
set autochdir

" this is ok, but only one file with a given name can be backed up at a time.
" i guess leave it this way for now.
" set backupdir=/cygdrive/c/Users/tfeiler/vimBackups/,.
set backupdir=~/vimBackups/,.

" this changes swap directory (double slash at end ensures unique filenames so
" you can edit multiple files from different dirs with same filename
" set directory=~/vimBackups//,.

" is any of this needed when using cygwin vim?
" set shell=C:/cygwin/bin/bash
"set shellxquote=\"
" not needed...
" set shellcmdflag=--login\ -c

"burn those lazy keyboard bridges
map [A :echo "use k to move up"
map [B :echo "use j to move down"
map [C :echo "use l to move right"
map [D :echo "use h to move left"

" not needed anymore, now I have tmux_navigator
" faster split switching
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l
" map <C-h> <C-w>h

" OLD WAY OF DOING THINGS
" map \ :!ant -buildfile \eclipse-workspace\fairies\srctools\flash\build.xml tool_addBadgeCard

" map \ :!ant -buildfile \eclipse-workspace\fairies\src\flash\build.xml birds
" map \ :!ant -buildfile \eclipse-workspace\fairies\src\flash\build.xml shopPanel

" new way - need to kickoff cygwin in order to run the shell script that does the copying/ant/etc.
" map \ :!C:\cygwin\bin\sh.exe fairiesBuildHelper.sh shopping

" map ^ :call ToggleBlockCommentC()<enter>j
map ^ :call IndentBouncer(1, 0)<enter>

" even better - variable it
" REMEMBER - you can also just do ':let buildHelper="foo"', etc. from within an editing session and change this on the fly, no more having to back out to edit _vimrc!
" let buildHelper="tool_infoCardSeed"
" let buildHelper="tool_mapExtrasToolMain"
"
let buildHelper="mapX"
" let buildHelper="caf"
" let buildHelper="shopping"
" let buildHelper="tradeIngredients"
" let buildHelper="tradeConfirm"
" let buildHelper="shopTopicSelector"
" let buildHelper="birds"
" let buildHelper="pachinko"
" let buildHelper="petalPickup"
" let buildHelper="rolipoli"
" let buildHelper="notification"
" let buildHelper="levelUp"
" let buildHelper="questDetails"
" let buildHelper="pixieDustMeter"
" let buildHelper="profile"
" let buildHelper="bee"
" let buildHelper="lullaby"
" let buildHelper="dragonfly"
" let buildHelper="memory"
" let buildHelper="ladybugs"
" let buildHelper="knitting"
" let buildHelper="recipeBrowserCraftCave"
" let buildHelper="craftResults"


let cpBuildHelper=""


let g:buildTypes = ['all', 'contentOnly'] " also antOnly, but rarely used...
let g:selectedBuildType = 0

" now we map things based on where we're working from so that slash/backspace
" can work differently for different types of projects...
let currentDir=system("pwd")
" echo "Current Dir is:" currentDir

" sometimes cydgrive doesnt appear in path which screws things up...
if currentDir[0:2] == "/c/"
	let currentDir="/cygdrive" . currentDir
endif

" echo currentDir[0:64]

" CTAGS STUFF START
let tlist_actionscript_settings = 'actionscript;c:classes;k:consts;p:properties;F:public methods;f:private methods;z:protected methods;g:getters;s:setters;v:variables'
let tlist_coffee_settings = 'coffee;c:classes;s:static methods;f:function;v:variable'
let Tlist_Auto_Open=0
let Tlist_Sort_Type='name'
let Tlist_Exit_OnlyWindow=1
if &diff
	" if diffing (especially with git), leaving this as 1 causes some errors
	" in generating tags
	let Tlist_Process_File_Always=0
else
	let Tlist_Process_File_Always=1
endif
map TT :TlistToggle<enter>

" set splits (including the preview window) to open below/right
" set splitbelow
" set splitright

" make the preview window smaller
" set previewheight=2

" maps the spacebar to show the prototype for what your cursor is over in the preview window
" map <Space> <C-w>}

" show the current tag prototype as an "echo". Doesn't support multiline
" prototypes but not bad! Follow up with <C-w>} to see tag prototype in
" preview window, or standard tag commands to jump to edit the file
function ShowTagPrototype()
	let wordUnderCursor = expand("<cword>")
	let tagSearchResult = taglist(wordUnderCursor)

	for tsr in tagSearchResult
		let fileContents = readfile(tsr["filename"])

		let searchPattern = tsr["cmd"]
		let searchPattern = searchPattern[1:len(searchPattern)-2] " chop off first/last character

		let lineIdx = match(fileContents, searchPattern)
		
		if (lineIdx != -1)
			let lineContents = fileContents[lineIdx]

			let leadin = ""
			if (len(tagSearchResult) > 1)
				let leadin = "(1/" . len(tagSearchResult) . ") "
			endif

			" strip leading whitespace
			let formattedLineContents = substitute(lineContents, "^[ \t]*","","")

			" add leadin
			let formattedLineContents = leadin . formattedLineContents

			" let formattedLineContents = formattedLineContents . " (" . len(formattedLineContents) . " / " . winwidth(0) . ")"

			" make sure it doesn't overflow...
			if (len(formattedLineContents) > winwidth(0))
				let formattedLineContents = formattedLineContents[:winwidth(0)-4] . "..."
			endif
			echo formattedLineContents
		else
			echo "No match found for tag \"" . wordUnderCursor . "\". (cmd was \"" . tsr["cmd"] . "\"."
		endif

		break
	endfor
endfunction
map <Space> :call ShowTagPrototype()<enter>

" nota bene - if taglist isn't working right (TlistToggle is empty for instance) then check to see if you are using
" windows ctags and cygwin vim, etc. Path can screw it up. If so edit taglist.vim and replace command like:
"             let ctags_cmd = ctags_cmd . ' "' . a:filename . '"'
" with:
"			  let ctags_cmd = ctags_cmd . ' `cygpath -m "' . a:filename . '"`'
"
set tags=tags,${FAIRIESSRC}flash/tags,${FAIRIES}srctools/flash/tags
" CTAGS STUFF END
" set tags to whoever's install I'm looking at
if stridx(currentDir, "/Users/tfeiler/remotes/ventnor") == 0
	let rsnMountBaseDir = substitute(currentDir, "\\(.*ventnor[a-zA-Z]*Reason\\).*", "\\1", "")
	let phpTags = rsnMountBaseDir . "/phpTags"
	" echo "php tags should be [" . phpTags . "]"
	" set tags=tags,phpTags
	let &tags = "tags," . phpTags
endif

if stridx("foo", "bar") == 0
	" echo this is just here so that I can re-order the elseif's easily...it's obviously always false
elseif stridx(currentDir, "/Users/tfeiler/development/learningWedges") == 0
	map \ :call ReloadChromeTab("/learningWedges/")<enter>
elseif stridx(currentDir, "/Users/tfeiler/development/rocket/tests") == 0
	map \ :call ReloadChromeTab("/rocket/")<enter>
elseif stridx(currentDir, "/Users/tfeiler/remotes/ventnorMryanReason") == 0
	" set tags=tags,/Users/tfeiler/remotes/ventnorMryanReason/phpTags
	map \ :call ReloadChromeTab("/home/testing/")<enter>
" elseif stridx(currentDir, "/Users/tfeiler/remotes/ventnorTfeilerReason/profiles") == 0
	" map \ :call ReloadChromeTab("/profiles/api.php")<enter>
elseif stridx(currentDir, $MOODLE_WSG) == 0
	set tags=tags,$MOODLE_WSG/tags
	set path=.,/usr/include,$MOODLE_WSG/

	" new test approach - run php syntax checker on the current file every
	" time I save it. Will this be annoying?
	" autocmd BufWritePost * call SendFreshCommandToTMUX("php -l " . expand(@%))

	" default slash behaviod - run a syntax check on the current file, and
	" spit out results to pane 1 of current tmux window
	map \ :call SendFreshCommandToTMUX("php -l " . expand(@%), "1")<enter>
	map <backspace> :call ReloadChromeTab("/moodletfeiler.wsgtest.its.carleton.edu/")<enter>
elseif stridx(currentDir, "/Users/tfeiler/development/gmapsTutorial") == 0
	map \ :call ReloadChromeTab("/gmapsTutorial/")<enter>
elseif stridx(currentDir, "/Users/tfeiler/development/polymerTests") == 0
	map \ :call ReloadChromeTab("/polymerTests/")<enter>
elseif stridx(currentDir, "/Users/tfeiler/development/barnDoorTests") == 0
	map \ :call ReloadChromeTab("https://slote.test.carleton.edu/home/")<enter>
	" map \ :call SendFreshCommandToTMUX("cd ~/development/barnDoorTests && cake release")<enter>
	map <backspace> :call SendFreshCommandToTMUX("cd ~/development/barnDoorTests && grunt deploy")<enter>
	set tags=tags,/Users/tfeiler/development/barnDoorTests/coffeeTags
elseif stridx(currentDir, "/Users/tfeiler/development/learningCoffeeScript") == 0
	map \ :call SendFreshCommandToTMUX("coffee -m -c helloWorld.coffee")<enter>
	map <backspace> :call ReloadChromeTab("sourceMapTest.html")<enter>
elseif stridx(currentDir, "/Users/tfeiler/remotes/wsgTfeilerReasonCore") == 0
	" map \ :call ReloadChromeTab("tfeiler.wsgtest.its.carleton.edu")<enter>
	map \ :call ReloadFirefoxTab("http://tfeiler.wsgtest.its.carleton.edu/playground/")<enter>
	" set tags=tags,/Users/tfeiler/remotes/wsgTfeilerReasonCore/phpTags

	" path is used when using the "gf" (aka "goto file" shortcuts in vim).
	" this lets me type "gf" when over a filename that appears in something
	" like include_once or reason_include_once and open the appropriate
	" file. (doesn't have tag history or anything). Can also do "CTRL-W f";
	" this will open the new file in a new horizontal split located above the
	" current split. REALLY NICE!
	set path=.,/usr/include,,${REASON_WSG}/reason_4.0/lib/local/,${REASON_WSG}/reason_4.0/lib/core/,${REASON_WSG}/,${REASON_WSG}/carl_util/

elseif stridx(currentDir, "/Users/tfeiler/remotes/ventnorTfeilerReason") == 0
	if stridx(currentDir, "/Users/tfeiler/remotes/ventnorTfeilerReason/reason_package/reason_4.0/lib/local/scripts/reminders") == 0
		map \ :call SendFreshCommandToTMUX("~/development/shellScripts/sshRelated/runFindOldPoliciesRemote.sh")<enter>
		
		" use this one if ssh'ed into ventnor and cd'ed into correct dir
		" map \ :call SendFreshCommandToTMUX("/usr/local/wsg/php5/bin/php -d include_path=/usr/local/webapps/branches/slote-apps/reason_package/ find_old_policies.php")<enter>
	elseif stridx(currentDir, "/Users/tfeiler/remotes/ventnorTfeilerReason/reason_package_local/local/scripts/upgrade") == 0
		map \ :call SendFreshCommandToTMUX("/usr/local/wsg/php5/bin/php -d include_path=/usr/local/webapps/branches/slote-apps/reason_package/ datatypeTests.php")<enter>
	elseif stridx(currentDir, "/Users/tfeiler/remotes/ventnorTfeilerReason/reason_package/reason_4.0/lib/core/minisite_templates/modules") == 0
		map \ :call ReloadChromeTab("slote.test.carleton.edu/handbook")<enter>
	elseif stridx(currentDir, "/Users/tfeiler/remotes/ventnorTfeilerReason/reason_package_local/local/minisite_templates/modules") == 0
		" map \ :call ReloadChromeTab("slote.test.carleton.edu/giving/giftmap-demo")<enter>
		" map \ :call ReloadChromeTab("slote.test.carleton.edu/home")<enter>
		map \ :call ReloadChromeTab("https://slote.test.carleton.edu/campus/webgroup/reason101/mbs/")<enter>
	elseif stridx(currentDir, "/Users/tfeiler/remotes/ventnorTfeilerReason/reason_package_local/local/scripts/upgrade/mbs") == 0
		map \ :call SendFreshCommandToTMUX("/usr/local/wsg/php5/bin/php -d include_path=/usr/local/webapps/branches/slote-apps/reason_package/ mbsCreation.php")<enter>
	else
		" map \ :call ReloadChromeTab("slote.test.carleton.edu/thor/plasmature")<enter>
		map \ :call ReloadChromeTab("slote.test.carleton.edu/reason/index.php")<enter>
	endif
	" map \ :call SendKeysToTMUX("2", '"ant -buildfile $BACON/CatalogDescriptor/build.xml" Enter')<enter>
	
	" set tags=tags,/Users/tfeiler/remotes/ventnorTfeilerReason/phpTags
	set path=.,/usr/include,,${REASON_VENT}/reason_4.0/lib/local/,${REASON_VENT}/reason_4.0/lib/core/,${REASON_VENT}/,${REASON_VENT}/carl_util/
elseif stridx(currentDir, "/Users/tfeiler/development/jsloteFormBuilder/formbuilder-rsn") == 0
	map <backspace> :call ReloadChromeTab("formbuilder-rsn/index.html")<enter>
	" map <backspace> :call ReloadChromeTab("slote.test.carleton.edu/reason/index.php")<enter>
	map \ :call SendFreshCommandToTMUX("grunt \&\& ./copyToReason.sh")<enter>
	set tags=tags,/Users/tfeiler/development/jsloteFormBuilder/formbuilder-rsn/coffeeTags
elseif stridx(currentDir, "/Users/tfeiler/development/jsloteFormBuilder/formbuilder") == 0
	set tags=tags,/Users/tfeiler/development/jsloteFormBuilder/formbuilder/coffeeTags
elseif stridx(currentDir, "/Users/tfeiler/development/treeBrowser") == 0
	map \ :call ReloadChromeTab("http://tfeiler57864.acs.carleton.edu/devArea/treeBrowser/index.html")<enter>
else
	" echo "WORKING ON UNKNOWN!"
	
	" a couple of example ways to trigger things

	" map \ :call FIFO("ant compileBacon")<enter>

	" if $TOM_OS == "osx"
		" map \ :execute "!cpUiBuildHelper.sh " . cpBuildHelper<enter>
	" elseif $TOM_OS == "cygwin"
		" map \ :execute "!C:/cygwin/bin/sh.exe cpUiBuildHelper.sh " . cpBuildHelper
	" endif

	" map  :call ToggleBuildType()
	" map \ :execute "!C:/cygwin/bin/sh.exe fairiesBuildHelper.sh " . buildHelper . " " . g:buildTypes[g:selectedBuildType]
	" map \ :call LaunchLuaInterpreterOnCurrentFile()
	" map  :!cat letrec.ss \| ./interpreter.exe
endif

"
" got two new ways of firing off commands from vim, to separate
" terminals/windows/panes. If in tmux, the SendFreshCommandToTMUX /
" SendKeysToTMUX stuff is very flexible and probably easiest; lets me send
" CTRL characters to kill processes, target any window/pane easily, etc.
"
" If I'm not in tmux (cygwin for instance) the second approach with named
" pipes is maybe easier, sending stuff to a FIFO. That also lets me do it with
" separate terminal windows if that is something that makes sense for a
" particular workflow.
"
"

" include an extra enter to get past the "Press ENTER to type command to continue" prompt
" map \ :call SendKeysToTMUX("assetPipe.2", "C-c \"clear\" Enter \"date\" Enter \"node app.js\" Enter")<enter><enter>
" map  :call SendFreshCommandToTMUX("assetPipe.2", "node app.js")<enter><enter>

" simple wrapper that cancels out previous cmd if any, clears screen, puts a
" datestamp up, and then calls SendKeysToTMUX

" takes optional second param to specify the tmux target; defaults to pane 1 of current window
function SendFreshCommandToTMUX(cmdString, ...)
	let tmuxTarget="1"
	if a:0 > 0
		let tmuxTarget = a:1
	end

	" if (a:skipCancel > 0)
		" let updatedCmdString = "\"clear\" Enter \"" . a:cmdString . "\" Enter"
	" else
		" let updatedCmdString = "C-c \"clear\" Enter \"date\" Enter \"" . a:cmdString . "\" Enter"
	" end
	let updatedCmdString = "\"clear\" Enter \"" . a:cmdString . "\" Enter"

	echo "update [" . updatedCmdString . "]"
	call SendKeysToTMUX(tmuxTarget, updatedCmdString)
endfunction

" sends keys to some tmux window. Maybe look into vimux/tslime?
function SendKeysToTMUX(target, cmdString)
	" let fullCmd = "!tmux send-keys -t " . a:target . " " . a:cmdString
	" echo "full cmd [" . fullCmd . "]"
	" silent execute fullCmd
	" redraw!
	
	let fullCmd = "tmux send-keys -t " . a:target . " " . a:cmdString
	call system(fullCmd)
	redraw!

endfunction

" examples
" :call FIFO("javac Foo.java") # sends compile cmd to fifo /tmp/vimCmds
" :call FIFO("java Foo", "B") # sends run cmd to fifo /tmp/vimCmdsB
" use in conjunction with listenForVimCommands.sh / http://blog.jb55.com/post/29072842980/sending-commands-from-vim-to-a-separate-tmux-pane
function FIFO(cmd, ...)
	if a:0 > 0
		let pipeName = "/tmp/vimCmds" . a:1
	else
		let pipeName = "/tmp/vimCmds"
	end

	" echo "need to send [" . a:cmd . "] to [" . pipeName . "]"
	let fullCmd = "!echo \"clear ; echo \"STARTFIFOCMD\" ; date ; " . a:cmd . "\" > " . pipeName
	" echo "full cmd [" . fullCmd . "]"
	silent execute fullCmd
	redraw!
endfunction

function StartWithTag(tagName)
	"silent execute "!sleep 1"
	let launchTagCmd = "ta " . a:tagName
	execute launchTagCmd
	set syntax=actionscript
endfunction

function SetExpandTabForIndentedLanguages()
	let currentFileType=&filetype
	" echo "sample fxn! [" currentFileType "]/[" @% "]"
	set nosmartindent

	if currentFileType == "python" || currentFileType == "coffee"
		" echo "python/coffee/etc. - expandtab"
		set expandtab
	else
		let fullFilename=expand("%:p")
		" echo "full name [" fullFilename "]"

		if currentFileType == "php" && (stridx(fullFilename, "${MOODLE_WSG}") == 0 || stridx(fullFilename, "/Users/tfeiler/remotes/mitreClampHome") == 0)
			" moodle coding standards call for spaces not tabs
			" echo "php in moodle - expandtab"
			set expandtab
			
			" new - trying out as per moodle suggestions
			set smartindent
		else
			" echo "ANYTHING ELSE - change it back"
			set noexpandtab
		endif
	endif
endfunction


function BuildFrameworkAndSandbox()
	echo "building framework and sandfox!"
	!ant -buildfile "c:/cvsWorkspace/fairies/src/flash/build.xml" framework
	!ant -buildfile "c:/cvsWorkspace/fairies/src/flash/build.xml" miniGameUnitTest
	echo "all done!"
endfunction


"function BuildReg()
	"echo "building reg!"
	"!ant -buildfile "c:/eclipse-workspace/dos_widgets/pixie_hollow/registration/build.xml"
	"echo "copying file to destination!"
	"!cp "/c/eclipse-workspace/dos_widgets/pixie_hollow/registration/deploy/registration.swf" /c/dropbox/20110726_ramp/
	"echo "all done!"
"endfunction

"function Foobar(str)
	"echo "Foobar on [" . a:str . "], some env var [" . $FAIRIESSRC . "], " . stridx("Hello there", "Ello") . "..."
	"
	"if stridx(g:currentDir, $FAIRIES . "srctools/") == 0
		"echo "WE ARE IN SRCTOOLS!"
	"elseif stridx(g:currentDir, $FAIRIESSRC) == 0
		"echo "WE ARE IN FAIRIESSRC"
	"else
		"echo "DUNNO WHERE WE ARE (" . g:currentDir . ")"
	"endif
"
"endfunction
"function Foobar(str)
	"echo "tags set to [" . &tags . "]"
"endfunction
"map \ :call Foobar("heythere")

function LaunchLuaInterpreterOnCurrentFile()
	" execute "!'C:/Program Files (x86)/Lua/5.1/lua.exe' C:/development/lua/foo.lua"
	" @% contains the filename of the file currently being edited
	execute "!'C:/Program Files (x86)/Lua/5.1/lua.exe' " . @%
endfunction
	
" 2013-03-08; write the file, compile the desired widget, reload the tab. NICE!
function OneClickFairyBuilder()
	write
	execute "!C:/cygwin/bin/sh.exe fairiesBuildHelper.sh " . g:buildHelper . " " . g:buildTypes[g:selectedBuildType] . " reloadChromeTab"

	" let bar = "C:/cygwin/bin/sh.exe fairiesBuildHelper.sh " . g:buildHelper . " " . g:buildTypes[g:selectedBuildType]
	" echo "try command [" . bar . "]..."
	" let ignoreMe = system(bar)
	" echo "shell error? [" . v:shell_error . "]"
	
	" let foo = system("echo $?")

	" one approach, can't figure out how to read this in...
	" let foo=$?
	" echo "shell? [" . foo . "]"
	" call ReloadChromeTab("/home/tfeiler/player/fairies/www/live.html")
endfunction

function ToggleBlockCommentC()
	call ToggleBlockComment("/*", "*/")
endfunction

function ToggleBlockComment(startSequence, endSequence)
	let line = getline(".")

	let startIdx = stridx(line, a:startSequence)
	let endIdx = stridx(line, a:endSequence)

	" couldn't get regex approach to work here...
	"let probe = matchstr(line, a:startSequence . ".*" . a:endSequence)
	if (startIdx > -1 && endIdx > startIdx)
		let repl = substitute(line, escape(a:startSequence, a:startSequence), "", "")
		let repl = substitute(repl, escape(a:endSequence, a:endSequence), "", "")
	else
		let repl = substitute(line, "\\(.*\\)", a:startSequence . "\\1" . a:endSequence, "")
	endif

	call setline(".", repl)
endfunction

" wrapping it in a function means we can get it to run in the background sorta, and not screw up vim's display
" this requires Chromix installation and a running Chromix server
function ReloadChromeTab(pattern)
	" silent execute "!chromix with " . a:pattern . " reload"
	" silent execute "!chromix with " . a:pattern . " goto " . a:pattern
	
	" best compromise - loads, creates if necessary, and focuses. Some of the
	" other options work great if I only have a single page I'm looking at,
	" but if I'm viewing multiple pages (like a website and a testsuite say)
	" it's worth it to step through this extra hoop
	" silent execute "!chromix with " . a:pattern . " close ; chromix load " . a:pattern
	" silent execute "!chromix with " . a:pattern . " reload ; chromix with " . a:pattern . " focus"
	silent execute "!chromix load " . a:pattern . " ; chromix with " . a:pattern . " reload"
	redraw!
	echo "reloading Chrome tabs with [" . a:pattern . "] url's..."
endfunction

function ReloadFirefoxTab(pattern)
	silent execute "!osascript /Users/tfeiler/development/appleScripts/firefoxReloader.scpt " . a:pattern
	redraw!
	echo "reloading Firefox tab with [" . a:pattern . "] url's..."
endfunction

function ToggleBuildType()
	" if g:buildType == "all" | let g:buildType="contentOnly" | else | let g:buildType="all" | endif
	" echo "buildType now" g:buildType
	let g:selectedBuildType = (g:selectedBuildType + 1) % len(g:buildTypes)
	echo "buildType now" g:buildTypes[g:selectedBuildType] "(if you want backspace to function normally, remove mapping to ToggleBuildType in _vimrc...)"
endfunction

" maps = key to delete between mark a and b into buffer a
" map = :'a,'bd a

" maps + key to yank between mark a and b into buffer a
" map + :'a,'bya a

" map plus to toggle buffers
map + :e #

" if on windows might need this...
" set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" syntax setup
au BufRead,BufNewFile *.as set filetype=actionscript
au BufRead,BufNewFile *.jsfl set filetype=javascript
au BufRead,BufNewFile *.json set filetype=json
au BufRead,BufNewFile *.clj set filetype=clojure
au BufRead,BufNewFile *.coffee set filetype=coffee
au BufRead,BufNewFile Cakefile set filetype=coffee
" unnecessary: on windows and osx gvim (there just drop the syntax file in the right dir and it will autoload),
" but needed on cygwin vim (which looks in a different syntax directory, /usr/share/vim/vim73/syntax)
" au! Syntax actionscript source /cygdrive/c/Vim/vim73/syntax/actionscript.vim

" whenever I open a python/coffee/etc file, set tabs to expand
" au FileType python set expandtab
au FileType * call SetExpandTabForIndentedLanguages()
" au FileType * call UpdateReasonPackageSwitcher()

" when editing php, make shift-K run this command that looks stuff up from php
" docs!
au FileType php set keywordprg=~/development/shellScripts/vim/php_doc.sh

" remember folds when I exit/re-enter
" au BufWinLeave ?* mkview
" au BufWinEnter ?* silent loadview


" slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" rainbow parentheses
" " au VimEnter * RainbowParenthesesActivate
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
" map ) :RainbowParenthesesToggle<enter>

" clojure
" au BufRead,BufNewFile *.clj xmap \ <Plug>SlimeRegionSend
" au BufRead,BufNewFile *.clj nmap \ <Plug>SlimeParagraphSend






" **************** INDENTATION BASED NAVIGATION: START ********************

" function I (tjf) wrote to help navigate indentation-based languages like CoffeeScript,
" or even langauges where indentation isn't necessarily required but is
" usually observed; for instance if/else/endif with nice indentation in
" VimScript is a lot easier to navigate by using this function!
"
" I have this mapped to ^; next to % which I use for similar
" navigation in bracketed langs
"
" This runs either down or up, looking for something that is less indented
" than what we're currently looking at. Behavior for going up/down is a little
" different but gets pretty decent results.
"
" works pretty well although slightly strange behavior when faced with
" something like this in ~coffeescript:
"
" if ()
"	for ()
"	  while ()
"	    doSomething
"
" running IndentBouncer on either the "if" or "for" lines of this
" type of construct takes us to "doSomething"...but then running it a second
" time from there takes us back to "while". The "up" direction on a lang like
" CS can't suss out what the person editing actually wants. Maybe I could
" stuff a timed variable someplace, or maybe this is just a limitation of this
" type of language. The g:indent_bounce_breadcrumb stuff below is a simple
" workaround for this type of thing that makes repeated calls to this function
" a bit more 'stable'.
" 
"
let g:indent_bounce_breadcrumb = "-1,-1"
function! IndentBouncer(direction, timesThru)
	let lineNum = line('.')
	let startLineNum = lineNum
	let lastLineNum = line('$')
	let startIndent = indent(lineNum)

	let crumbSeparator = ","

	let stepVal = a:direction " 1 = down/forward, -1 = up/backward

	" special case - when going back up, see if the indent_bounce_breadcrumb
	" variable applies.
	if (stepVal == -1)
		let crumbs = split(g:indent_bounce_breadcrumb, crumbSeparator)

		if (crumbs[1] == startLineNum)
			exe crumbs[0]
			return
		endif
	endif

	while (lineNum > 0 && lineNum <= lastLineNum)
		let lineNum = lineNum + stepVal

		let lineContents = getline(lineNum)
		let indent = indent(lineNum)

		if (lineContents != "")
			if (stepVal == 1)
				if (indent <= startIndent)
					let destination = lineNum - 1
					
					" now back up a bit to find the first non-empty line
					while (destination >= startLineNum)
						let lineContents = getline(destination)

						if (lineContents != "")
							if (destination == startLineNum)
								" if destination is the same, it might
								" be more fruitful to look in other
								" direction...this gets us the %-style toggle
								if (a:timesThru == 0)
									call IndentBouncer(stepVal * -1, a:timesThru + 1)
									return
								endif
							else
								" go to that line! (and remember something about this bounce)
								let g:indent_bounce_breadcrumb = startLineNum . crumbSeparator . destination
								exe destination
								return
							endif
						endif
						let destination = destination + (stepVal * -1)
					endwhile
				endif
			else
				if (indent < startIndent)
					" go to that line!
					exe lineNum
					return
				endif
			endif
		endif
	endwhile
endfunction






" See http://vim.wikia.com/wiki/VimTip103
" Useful for navigating through indentation as opposed to braces based
" languages, like Python or Coffeescript.
"
"
" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" taken from http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

" use "gx" to open urls in browser

" Moving back and forth between lines of same or lower indentation.
" nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
" nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
" nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
" nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
" vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
" vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
" vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
" vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
" onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
" onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
" onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
" onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>
" **************** INDENTATION BASED NAVIGATION: END ******************** 

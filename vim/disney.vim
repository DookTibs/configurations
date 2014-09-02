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

function ToggleBuildType()
	" if g:buildType == "all" | let g:buildType="contentOnly" | else | let g:buildType="all" | endif
	" echo "buildType now" g:buildType
	let g:selectedBuildType = (g:selectedBuildType + 1) % len(g:buildTypes)
	echo "buildType now" g:buildTypes[g:selectedBuildType] "(if you want backspace to function normally, remove mapping to ToggleBuildType in _vimrc...)"
endfunction

set tags=tags,${FAIRIESSRC}flash/tags,${FAIRIES}srctools/flash/tags

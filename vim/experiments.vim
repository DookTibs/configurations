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

" au FileType * call UpdateReasonPackageSwitcher()

" see http://www.blaenkdenum.com/posts/a-simpler-vim-statusline/ for example
" of making custom function output part of the status line.
" this fires every few seconds and also whenever you switch active buffers
" set statusline=%!SetCustomStatusLine()
" set statusline=%{SetCustomStatusLine()}


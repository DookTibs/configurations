
" TO LAUNCH MANUALLY I HAD A SCRIPT THAT DOES THIS:
" cd /Users/tfeiler/development/tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository
"
" java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 -Declipse.application=org.eclipse.jdt.ls.core.id1 -Dosgi.bundles.defaultStartLevel=4 -Declipse.product=org.eclipse.jdt.ls.core.product -Dlog.level=ALL -noverify -Xmx1G -jar ./plugins/org.eclipse.equinox.launcher_1.6.200.v20210416-2027.jar -configuration ./config_mac -data /Users/tfeiler/development/ --add-modules=ALL-SYSTEM --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED

if 1 == 0
	let g:ale_completion_enabled = 1

	" let g:ale_java_eclipselsp_path = "/Users/tfeiler/development/tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository"

	let g:ale_java_eclipselsp_path = "/Users/tfeiler/development/tools/eclipse.jdt.ls"
	let g:ale_java_eclipselsp_config_path = "/Users/tfeiler/development/tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac"
	let g:ale_java_eclipselsp_workspace_path = "/Users/tfeiler/development"

	let g:ale_linters = {
	\   'java': ['eclipselsp'],
	\}
endif




if 1 == 0

	" see https://github.com/dense-analysis/ale/tree/master/doc
	let g:ale_linters = {'javascript': ['eslint'], 'python': ['flake8']}
	let g:ale_fixers = {'javascript': ['eslint'], 'python': ['black']}
	let g:ale_python_flake8_options = '--config=/Users/tfeiler/development/hawc_project/hawc/.flake8'
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
endif

if 1 == 0
	let g:ale_linters = {'javascript': ['eslint'], 'python': ['pyls','flake8']}
	let g:ale_completion_delay = 100
	let g:ale_completion_enabled = 1
endif

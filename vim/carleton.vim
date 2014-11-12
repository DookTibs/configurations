" echo "Current Dir is:" currentDir

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
elseif stridx(currentDir, "/Users/tfeiler/remotes/mitreClampHome") == 0
	set tags=tags,/Users/tfeiler/remotes/mitreClampHome/tjfdev20140926/tags
elseif stridx(currentDir, "/Users/tfeiler/remotes/ventnorTfeilerReason") == 0
	let relativePath = substitute(currentDir, "/Users/tfeiler/remotes/ventnorTfeilerReason/\\(.*\\)", "\\1", "")
	" echo "relativepath [" . relativePath . "]..."
	if stridx(relativePath, "reason_package/reason_4.0/lib/local/scripts/reminders") == 0
		map \ :call SendFreshCommandToTMUX("~/development/shellScripts/sshRelated/runFindOldPoliciesRemote.sh")<enter>
		" use this one if ssh'ed into ventnor and cd'ed into correct dir
		" map \ :call SendFreshCommandToTMUX("/usr/local/wsg/php5/bin/php -d include_path=/usr/local/webapps/branches/slote-apps/reason_package/ find_old_policies.php")<enter>
	elseif stridx(relativePath, "reason_package_local/local/minisite_templates/modules/form/views/thor_custom") == 0
		map \ :call ReloadChromeTab("https://slote.test.carleton.edu/campus/webdev/testing/cams-studio-booking/")<enter>
	elseif stridx(relativePath, "reason_package_local/local/classes/admin/modules") == 0
		map \ :call ReloadChromeTab("cur_module=ResourceSpaceImport")<enter>
	elseif stridx(relativePath, "reason_package_local/local/scripts/cleanup") == 0
		map \ :call SendFreshCommandToTMUX("php -d include_path=/usr/local/webapps/branches/slote-apps/reason_package/ ldap_dupe_repairs.php", "3")<enter>
	elseif stridx(relativePath, "reason_package_local/local/scripts/upgrade") == 0
		map \ :call SendFreshCommandToTMUX("/usr/local/wsg/php5/bin/php -d include_path=/usr/local/webapps/branches/slote-apps/reason_package/ datatypeTests.php")<enter>
	elseif stridx(relativePath, "rest/ems") == 0
		" map \ :call ReloadChromeTab("slote.test.carleton.edu/rest/ems/")<enter>
		map \ :call SendFreshCommandToTMUX("reasonApiTester.sh -u /rest/ems/cams/studio_a/20140914/20140920", "1")<enter>
		" map <backspace> :call SendFreshCommandToTMUX("reasonApiTester.sh -v -u /rest/ems/cams/20140901/20141031", "1")<enter>
		map <backspace> :call SendFreshCommandToTMUX("curl https://slote.test.carleton.edu/rest/tester.php", "1")<enter>
	elseif stridx(relativePath, "reason_package/reason_4.0/lib/core/minisite_templates/modules") == 0
		map \ :call ReloadChromeTab("slote.test.carleton.edu/handbook")<enter>
	elseif stridx(relativePath, "reason_package_local/local/minisite_templates/modules") == 0
		" map \ :call ReloadChromeTab("slote.test.carleton.edu/giving/giftmap-demo")<enter>
		" map \ :call ReloadChromeTab("slote.test.carleton.edu/home")<enter>
		map \ :call ReloadChromeTab("https://slote.test.carleton.edu/campus/webgroup/reason101/mbs/")<enter>
	elseif stridx(relativePath, "reason_package_local/local/scripts/upgrade/mbs") == 0
		map \ :call SendFreshCommandToTMUX("/usr/local/wsg/php5/bin/php -d include_path=/usr/local/webapps/branches/slote-apps/reason_package/ mbsCreation.php")<enter>
	elseif stridx(relativePath, "tjf/cams") == 0
		map \ :call SendFreshCommandToTMUX("./recompile.sh", "1")<enter>
	elseif stridx(relativePath, "tjf") == 0
		map \ :call ReloadChromeTab("slote.test.carleton.edu/tjf")<enter>
	else
		map \ :call ReloadChromeTab("slote.test.carleton.edu/reason/index.php")<enter>
	endif
	
	" set tags=tags,/Users/tfeiler/remotes/ventnorTfeilerReason/phpTags
	set path=.,/usr/include,,${REASON_VENT}/reason_4.0/lib/local/,${REASON_VENT}/reason_4.0/lib/core/,${REASON_VENT}/,${REASON_VENT}/carl_util/
elseif stridx(currentDir, "/Users/tfeiler/development") == 0
	let devSubportion = substitute(currentDir, "/Users/tfeiler/development/\\([a-zA-Z0-0]*\\).*", "\\1", "")
	map <backspace> :call ReloadChromeTab("http://tfeiler57864.acs.carleton.edu/devArea/" . devSubportion . "/")<enter>
	map \ :call SendFreshCommandToTMUX("./recompile.sh", "1")<enter>

	" for example, if in /Users/tfeiler/development/learningWedges, \ is mapped to reload url "/learningWedges/"
	" or if we're in /Users/tfeiler/development/rocket/tests, \ is mapped to reload url "/rocket/"

	" some subareas require a little more tweaking
	if stridx(currentDir, "/Users/tfeiler/development/barnDoorTests") == 0
		map \ :call ReloadChromeTab("https://slote.test.carleton.edu/home/")<enter>
		" map \ :call SendFreshCommandToTMUX("cd ~/development/barnDoorTests && cake release")<enter>
		map <backspace> :call SendFreshCommandToTMUX("cd ~/development/barnDoorTests && grunt deploy")<enter>
		set tags=tags,/Users/tfeiler/development/barnDoorTests/coffeeTags
	elseif stridx(currentDir, "/Users/tfeiler/development/learningCoffeeScript") == 0
		map \ :call SendFreshCommandToTMUX("coffee -m -c helloWorld.coffee")<enter>
		map <backspace> :call ReloadChromeTab("sourceMapTest.html")<enter>
	elseif stridx(currentDir, "/Users/tfeiler/development/jsloteFormBuilder/formbuilder-rsn") == 0
		map <backspace> :call ReloadChromeTab("formbuilder-rsn/index.html")<enter>
		" map <backspace> :call ReloadChromeTab("slote.test.carleton.edu/reason/index.php")<enter>
		" map \ :call SendFreshCommandToTMUX("grunt \&\& ./copyToReason.sh")<enter>
		map \ :call SendFreshCommandToTMUX("grunt")<enter>
		set tags=tags,/Users/tfeiler/development/jsloteFormBuilder/formbuilder-rsn/coffeeTags
	elseif stridx(currentDir, "/Users/tfeiler/development/jsloteFormBuilder/formbuilder") == 0
		set tags=tags,/Users/tfeiler/development/jsloteFormBuilder/formbuilder/coffeeTags
	endif
elseif stridx(currentDir, $MOODLE_WSG) == 0
	set tags=tags,$MOODLE_WSG/tags
	set path=.,/usr/include,$MOODLE_WSG/

	" new test approach - run php syntax checker on the current file every
	" time I save it. Will this be annoying?
	" autocmd BufWritePost * call SendFreshCommandToTMUX("php -l " . expand(@%))

	" default slash behavior - run a syntax check on the current file, and
	" spit out results to pane 1 of current tmux window
	map \ :call SendFreshCommandToTMUX("php -l " . expand(@%), "1")<enter>
	map <backspace> :call ReloadChromeTab("/moodletfeiler.wsgtest.its.carleton.edu/")<enter>
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
else
	" echo "WORKING ON UNKNOWN!"
endif

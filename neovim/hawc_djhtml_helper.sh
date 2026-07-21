#!/bin/bash

# OLD WAY
# cd /Users/38593/development/hawc_project/hawc
# echo "	Running djhtml..."
# djhtml --tabwidth 2 $1

# NEW WAY
# See ~/development/configurations/neovim/icf.vim for more explanation
# usage: hawc_djhtml_helper.sh <hawc_local_parent_dir> <full_path_to_file>
# e.g.: hawc_djhtml_helper.sh hawc2026usepa /Users/38593/development...../apps/mechanistic/templates/mechanistic/chemical_form.html
# typically called via Vim autocmd
# (this script assumes a good value for hawc_local_parent_dir)
cd /Users/38593/development/hawc_project/$1/ && djhtml --tabwidth 2 $2

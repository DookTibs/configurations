#!/bin/bash

# OLD WAY
# cd /Users/38593/development/hawc_project/hawc
# ruff format $1 && ruff $1 --fix --show-fixes

# NEW WAY
# See ~/development/configurations/neovim/icf.vim for more explanation
# usage: hawc_ruff_helper.sh <hawc_local_parent_dir> <full_path_to_file>
# e.g.: hawc_ruff_helper.sh hawc2026usepa /Users/38593/development...../apps/mechanistic/admin.py
# typically called via Vim autocmd
# (this script assumes a good value for hawc_local_parent_dir)
cd /Users/38593/development/hawc_project/$1/ && ruff format $2 && ruff $2 --fix --show-fixes

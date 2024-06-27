#!/bin/bash
cd /Users/38593/development/hawc_project/hawc
ruff format $1 && ruff $1 --fix --show-fixes

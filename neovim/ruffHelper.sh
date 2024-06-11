#!/bin/bash
cd /Users/tfeiler/development/hawc_project/hawc
ruff format $1 && ruff $1 --fix --show-fixes

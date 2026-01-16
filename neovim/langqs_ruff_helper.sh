#!/bin/bash
cd /Users/38593/development/langqs
ruff format $1 && ruff $1 --fix --show-fixes

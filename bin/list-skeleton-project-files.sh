#!/bin/sh -e

find -E "${HOME}/Code/Personal" -type f -path '*-skeleton\/*' -and ! -regex '^.*/(build|node_modules|bower_components|vendor|\.git|\.idea|\.pyvenv)/.*$'

#!/bin/sh

export YELLOW=`echo '\033[1;33m'`
export LIGHT_CYAN=`echo '\033[1;36m'`
export NOCOLOR=`echo '\033[0m'`

export LESS="-iMSx4 -FXR"

PAGER="gsed \"s/\([[:space:]]\+[0-9.\-]\+\)$/${LIGHT_CYAN}\1$NOCOLOR/;" 
PAGER="${PAGER}s/\([[:space:]]\+[0-9.\-]\+[[:space:]]\)/${LIGHT_CYAN}\1$NOCOLOR/g;" 
PAGER="${PAGER}s/|/$YELLOW|$NOCOLOR/g;s/^\([-+]\+\)/$YELLOW\1$NOCOLOR/\" 2>/dev/null | less"
export PAGER

psql

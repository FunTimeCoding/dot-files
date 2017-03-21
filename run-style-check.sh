#!/bin/sh -e

if [ "$(command -v shellcheck || true)" = "" ]; then
    echo "Command not found: shellcheck"

    exit 1
fi

CONCERN_FOUND=false
CONTINUOUS_INTEGRATION_MODE=false

if [ "${1}" = --ci-mode ]; then
    shift
    mkdir -p build/log
    CONTINUOUS_INTEGRATION_MODE=true
fi

SYSTEM=$(uname)

if [ "${SYSTEM}" = Darwin ]; then
    FIND=gfind
else
    FIND=find
fi

# shellcheck disable=SC2016
SHELL_SCRIPT_CONCERNS=$(${FIND} . -name '*.sh' -regextype posix-extended ! -regex '^.*/(build|\.git|tmp)/.*$' -exec sh -c 'shellcheck ${1} || true' '_' '{}' \;)

if [ ! "${SHELL_SCRIPT_CONCERNS}" = "" ]; then
    CONCERN_FOUND=true
    echo "Shell script concerns:"
    echo "${SHELL_SCRIPT_CONCERNS}"

    if [ "${CONTINUOUS_INTEGRATION_MODE}" = true ]; then
        echo "${SHELL_SCRIPT_CONCERNS}" > build/log/shellcheck.txt
    fi
fi

# shellcheck disable=SC2016
EMPTY_FILES=$(${FIND} . -empty -regextype posix-extended ! -regex '^.*/(build|\.git|\.vagrant|tmp)/.*$')

if [ ! "${EMPTY_FILES}" = "" ]; then
    CONCERN_FOUND=true
    echo
    echo "Empty files:"
    echo
    echo "${EMPTY_FILES}"

    if [ "${CONTINUOUS_INTEGRATION_MODE}" = true ]; then
        echo "${EMPTY_FILES}" > build/log/empty-files.txt
    fi
fi

# shellcheck disable=SC2016
TO_DOS=$(${FIND} . -regextype posix-extended -type f -and ! -regex '^.*/(\.git|\.idea)/.*$' -exec sh -c 'grep -Hrn TODO "${1}" | grep -v "${2}"' '_' '{}' '${0}' \;)

if [ ! "${TO_DOS}" = "" ]; then
    CONCERN_FOUND=true
    echo
    echo "To dos:"
    echo
    echo "${TO_DOS}"

    if [ "${CONTINUOUS_INTEGRATION_MODE}" = true ]; then
        echo "${TO_DOS}" > build/log/to-dos.txt
    fi
fi

# shellcheck disable=SC2016
SHELLCHECK_IGNORES=$(${FIND} . -regextype posix-extended -type f -and ! -regex '^.*/(\.git|\.idea)/.*$' -exec sh -c 'grep -Hrn "# shellcheck" "${1}" | grep -v "${2}"' '_' '{}' '${0}' \;)

if [ ! "${SHELLCHECK_IGNORES}" = "" ]; then
    CONCERN_FOUND=true
    echo
    echo "Shellcheck ignores:"
    echo
    echo "${SHELLCHECK_IGNORES}"

    if [ "${CONTINUOUS_INTEGRATION_MODE}" = true ]; then
        echo "${SHELLCHECK_IGNORES}" > build/log/shellcheck-ignores.txt
    fi
fi

if [ "${CONCERN_FOUND}" = true ]; then
    echo
    echo "Concern(s) found."

    exit 2
fi

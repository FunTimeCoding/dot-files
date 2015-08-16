#!/bin/sh -e

if [ ! "${TMUX}" = "" ]; then
    exit 0
fi

has_session()
{
    tmux has-session -t "${1}" 2>/dev/null
}

TMUX_CMD="tmux -2"
DEFAULT_NAME="1"

if ! has_session "${DEFAULT_NAME}"; then
    ${TMUX_CMD} new-session -s "${DEFAULT_NAME}" -d
fi

OPTIONS=$(tmux list-sessions -F "#S" | tr '\n' ' ')
OPTIONS="${OPTIONS} NEW"
echo "Select session from: ${OPTIONS}"
read OPTION

case ${OPTION} in
    "NEW")
        echo "Enter new session name:"
        read SESSION_NAME
        ${TMUX_CMD} new-session -s "${SESSION_NAME}"
        break
        ;;
    *)
        ${TMUX_CMD} attach-session -t "${OPTION}"
        break
        ;;
esac

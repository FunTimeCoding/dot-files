#!/bin/sh -e

if [ ! "${TMUX}" = "" ]; then
    exit 0
fi

has_session()
{
    tmux has-session -t "${1}" 2>/dev/null
}

TMUX_COMMAND="tmux -2"
DEFAULT_NAME="1"

if ! has_session "${DEFAULT_NAME}"; then
    ${TMUX_COMMAND} new-session -s "${DEFAULT_NAME}" -d
fi

OPTIONS=$(tmux list-sessions -F "#S" | tr '\n' ' ')
OPTIONS="${OPTIONS} quad new"
echo "Select session from: ${OPTIONS}"
read -r OPTION

case ${OPTION} in
    new)
        echo "Enter new session name:"
        read -r SESSION_NAME
        ${TMUX_COMMAND} new-session -s "${SESSION_NAME}"
        ;;
    quad)
        if ! has_session "${OPTION}"; then
            ${TMUX_COMMAND} new-session -s "${OPTION}" -d
            ${TMUX_COMMAND} split-window -v
            ${TMUX_COMMAND} split-window -h
            ${TMUX_COMMAND} select-pane -t 0
            ${TMUX_COMMAND} split-window -h
            ${TMUX_COMMAND} select-pane -t 0
        fi

        ${TMUX_COMMAND} attach-session -t "${OPTION}"
        ;;
    *)
        ${TMUX_COMMAND} attach-session -t "${OPTION}"
        ;;
esac

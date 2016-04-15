#!/bin/sh -e

if [ ! "${TMUX}" = "" ]; then
    echo "Already in tmux."

    exit 1
fi

has_session()
{
    tmux has-session -t "${1}" 2>/dev/null
}

DEFAULT_NAME="1"

if ! has_session "${DEFAULT_NAME}"; then
    tmux -2 new-session -s "${DEFAULT_NAME}" -d
fi

OPTIONS=$(tmux list-sessions -F "#S" | tr '\n' ' ')
OPTIONS="${OPTIONS} quad new"
echo "Select session from: ${OPTIONS}"
read -r OPTION

case ${OPTION} in
    new)
        echo "Enter new session name:"
        read -r SESSION_NAME
        tmux -2 new-session -s "${SESSION_NAME}"
        ;;
    quad)
        if ! has_session "${OPTION}"; then
            tmux new-session -s "${OPTION}" -d
            tmux split-window -v
            tmux split-window -h
            tmux select-pane -t 0
            tmux split-window -h
            tmux select-pane -t 0
        fi

        tmux -2 attach-session -t "${OPTION}"
        ;;
    *)
        tmux -2 attach-session -t "${OPTION}"
        ;;
esac

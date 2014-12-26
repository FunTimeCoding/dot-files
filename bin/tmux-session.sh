#!/bin/bash

[ "${TMUX}" = "" ] || exit 0

has_session () {
    tmux has-session -t $1 2>/dev/null
}

DEFAULT_NAME="_default"

if ! has_session "${DEFAULT_NAME}"; then
    tmux new-session -s "${DEFAULT_NAME}" -d
fi

PS3="Select session: "
OPTIONS=($(tmux list-sessions -F "#S") "NEW")

select OPTION in "${OPTIONS[@]}"
do
    case ${OPTION} in
        "NEW")
            read -p "Enter new session name: " SESSION_NAME
            tmux new-session -s "${SESSION_NAME}"
            break
            ;;
        *)
            tmux attach-session -t "${OPTION}"
            break
            ;;
    esac
done

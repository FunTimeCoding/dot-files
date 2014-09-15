#!/bin/bash
#export PATH=$PATH:/usr/local/bin:/Users/shiin/Library/Python/2.7/bin

# abort if we're already inside a tmux session
[ "${TMUX}" = "" ] || exit 0

has_session () {
    tmux has-session -t $1 2>/dev/null
}

# startup a default session if none currently exists
DEFAULT_NAME="_default"
if ! has_session "${DEFAULT_NAME}"; then
    tmux new-session -s "${DEFAULT_NAME}" -d
    #  MAC_VIM="/Applications/MacVim.app"

    if [ -x "${MAC_VIM}" ]; then
        tmux new-window -t "${DEFAULT_NAME}:2" -n 'mvim' "open ${MAC_VIM}"
    fi
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

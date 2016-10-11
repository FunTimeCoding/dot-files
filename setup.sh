#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)
WORK_DIRECTORY="${HOME}/.dotfiles"

if [ ! "${WORK_DIRECTORY}" = "${SCRIPT_DIRECTORY}" ]; then
    echo "Dotfiles directory must be ${WORK_DIRECTORY}."

    exit 1
fi

SSH_DIRECTORY="${HOME}/.ssh"

if [ -d "${SSH_DIRECTORY}" ]; then
    rm -rf "${SSH_DIRECTORY}"
fi

FILES=$(find "${SCRIPT_DIRECTORY}" -maxdepth 1 -name '.*' -not -path '*.git' -and -not -path "${WORK_DIRECTORY}" | awk -F / '{ print $NF }')

for FILE in ${FILES}; do
    ln -snf "${WORK_DIRECTORY}/${FILE}" "${HOME}/${FILE}"
done

CONFIG_DIRECTORY="${HOME}/.config"
mkdir -p "${CONFIG_DIRECTORY}"
POWERLINE_SYMLINK="${CONFIG_DIRECTORY}/powerline"

if [ ! -L "${POWERLINE_SYMLINK}" ]; then
    ln -s "${WORK_DIRECTORY}/powerline" "${POWERLINE_SYMLINK}"
fi

NEOVIM_CONFIG_SYMLINK="${CONFIG_DIRECTORY}/nvim"

if [ ! -L "${NEOVIM_CONFIG_SYMLINK}" ]; then
    ln -s "${WORK_DIRECTORY}/.vim" "${NEOVIM_CONFIG_SYMLINK}"
fi

NEOBUNDLE_DIRECTORY="${HOME}/.vim/bundle/neobundle.vim"

if [ -d "${NEOBUNDLE_DIRECTORY}" ]; then
    cd "${NEOBUNDLE_DIRECTORY}"
    git pull
else
    git clone https://github.com/Shougo/neobundle.vim "${NEOBUNDLE_DIRECTORY}"
fi

OH_MY_ZSH_DIRECTORY="${HOME}/.oh-my-zsh"

if [ -d "${OH_MY_ZSH_DIRECTORY}" ]; then
    cd "${OH_MY_ZSH_DIRECTORY}"
    git pull
else
    git clone https://github.com/robbyrussell/oh-my-zsh "${OH_MY_ZSH_DIRECTORY}"
fi

ZSH_SYNTAX_HIGHLIGHTING="${OH_MY_ZSH_DIRECTORY}/custom/plugins/zsh-syntax-highlighting"

if [ -d "${ZSH_SYNTAX_HIGHLIGHTING}" ]; then
    cd "${ZSH_SYNTAX_HIGHLIGHTING}"
    git pull
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_SYNTAX_HIGHLIGHTING}"
fi

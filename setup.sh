#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)
WORK_DIRECTORY="${HOME}/.dotfiles"
NON_INTERACTIVE=false

if [ ! "${WORK_DIRECTORY}" = "${SCRIPT_DIRECTORY}" ]; then
    echo "Dotfiles directory must be ${WORK_DIRECTORY}."

    exit 1
fi

if [ "${1}" = "--non-interactive" ]; then
    NON_INTERACTIVE=true
fi

SSH_DIRECTORY="${HOME}/.ssh"

if [ -d "${SSH_DIRECTORY}" ]; then
    if [ "${NON_INTERACTIVE}" = true ]; then
        OPT="y"
    else
        echo "Directory ${SSH_DIRECTORY} already exists. Replace it? (y/n) This will rm -rf ${SSH_DIRECTORY}."
        read -r OPT
    fi

    case ${OPT} in
        y)
            rm -rf "${SSH_DIRECTORY}"
            ;;
        n)
            exit 0
            ;;
        *)
            echo "Invalid choice."

            exit 1
            ;;
    esac
fi

FILES=$(find "${SCRIPT_DIRECTORY}" -maxdepth 1 -name '.*' -not -path '*.git' -and -not -path "${WORK_DIRECTORY}" | awk -F/ '{print $NF}')

for FILE in ${FILES}; do
    ln -snf "${WORK_DIRECTORY}/${FILE}" "${HOME}/${FILE}"
done

CONFIG_DIRECTORY="${HOME}/.config"
mkdir -p "${CONFIG_DIRECTORY}"
ln -snf "${WORK_DIRECTORY}/powerline" "${HOME}/.config/powerline"
NEOBUNDLE_PATH="${HOME}/.vim/bundle/neobundle.vim"

if [ ! -d "${NEOBUNDLE_PATH}" ]; then
    git clone https://github.com/Shougo/neobundle.vim "${NEOBUNDLE_PATH}"
fi

LOCAL_BIN_DIRECTORY="${HOME}/.local/bin"

if [ ! -d "${LOCAL_BIN_DIRECTORY}" ]; then
    mkdir -p "${LOCAL_BIN_DIRECTORY}"
fi

OH_MY_ZSH_DIRECTORY="${HOME}/.oh-my-zsh"

if [ ! -d "${OH_MY_ZSH_DIRECTORY}" ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh "${OH_MY_ZSH_DIRECTORY}"
fi

ZSH_SYNTAX_HIGHLIGHTING="${OH_MY_ZSH_DIRECTORY}/custom/plugins/zsh-syntax-highlighting"

if [ ! -d "${ZSH_SYNTAX_HIGHLIGHTING}" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_SYNTAX_HIGHLIGHTING}"
fi

ln -snf "${WORK_DIRECTORY}/.vim" "${HOME}/.config/nvim"

if ! command -v php > /dev/null 2>&1; then
    echo "PHP is not installed, Composer not installed."

    exit 0
fi

COMPOSER_BIN="${LOCAL_BIN_DIRECTORY}/composer"

if [ ! -f "${COMPOSER_BIN}" ]; then
    curl -sS https://getcomposer.org/installer | php -- --install-dir="${LOCAL_BIN_DIRECTORY}" --filename=composer
fi

COMPOSER_DIRECTORY="${HOME}/.composer"

if [ ! -d "${COMPOSER_DIRECTORY}" ]; then
    mkdir -p "${COMPOSER_DIRECTORY}"
fi

COMPOSER_CONFIG="${HOME}/.composer/composer.json"

if [ ! -f "${COMPOSER_CONFIG}" ] || [ ! -L "${COMPOSER_CONFIG}" ]; then
    ln -snf "${WORK_DIRECTORY}/composer.json" "${COMPOSER_CONFIG}"
fi

COMPOSER_LOCK="${HOME}/.composer/composer.lock"

if [ ! -f "${COMPOSER_LOCK}" ]; then
    cd "${COMPOSER_DIRECTORY}" || exit 1
    ${COMPOSER_BIN} self-update
    ${COMPOSER_BIN} install
fi

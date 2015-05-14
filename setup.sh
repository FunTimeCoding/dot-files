#!/bin/sh -ex

SCRIPT_DIR=$(cd "$(dirname "${0}")"; pwd)
WORK_DIR="${HOME}/.dotfiles"

if [ ! "${WORK_DIR}" = "${SCRIPT_DIR}" ]; then
    echo "Dotfiles directory must be ${WORK_DIR}."

    exit 1
fi

SSH_DIR="${HOME}/.ssh"

if [ -d "${SSH_DIR}" ]; then
    echo "Directory ${SSH_DIR} already exists. Replace it? (y/n) This will rm -rf ${SSH_DIR}."
    read OPT

    case ${OPT} in
        y)
            echo "Deleting ${SSH_DIR}."
            rm -rf "${SSH_DIR}"
            ;;
        n)
            echo "Setup canceled."

            exit 0
            ;;
        *)
            echo "Invalid choice."

            exit 1
            ;;
    esac
fi

echo "Updating symlinks."
FILES=$(find "${SCRIPT_DIR}" -maxdepth 1 -name '.*' -not -path '*.git' -and -not -path "${WORK_DIR}" | awk -F/ '{print $NF}')

for FILE in ${FILES}; do
    ln -snf "${WORK_DIR}/${FILE}" "${HOME}/${FILE}"
done

mkdir -p "${HOME}/.config"
ln -snf "${WORK_DIR}/powerline" "${HOME}/.config/powerline"

if type pip > /dev/null; then
    OS=$(uname)
    if [ "${OS}" = "Linux" ]; then
        pip install --user -U powerline-status
    elif [ "${OS}" = "Darwin" ]; then
        pip install -U powerline-status
    fi
else
    echo "pip is not installed, not installing powerline-status"
fi

NEOBUNDLE_PATH="${HOME}/.vim/bundle/neobundle.vim"

if [ ! -d "${NEOBUNDLE_PATH}" ]; then
    echo "Downloading NeoBundle."
    git clone https://github.com/Shougo/neobundle.vim "${NEOBUNDLE_PATH}"
fi

LOCAL_BIN_DIR="${HOME}/.local/bin"

if [ ! -d "${LOCAL_BIN_DIR}" ]; then
    echo "Setting up ${LOCAL_BIN_DIR}."
    mkdir -p "${LOCAL_BIN_DIR}"
fi

OH_MY_ZSH_DIR="${HOME}/.oh-my-zsh"

if [ ! -d "${OH_MY_ZSH_DIR}" ]; then
    echo "Setting up ${OH_MY_ZSH_DIR}."
    git clone git://github.com/robbyrussell/oh-my-zsh.git "${OH_MY_ZSH_DIR}"
fi

ZSH_SYNTAX_HIGHLIGHTING="${OH_MY_ZSH_DIR}/custom/plugins/zsh-syntax-highlighting/"

if [ ! -d "${ZSH_SYNTAX_HIGHLIGHTING}" ]; then
    echo "downloading zsh-syntax-highlighting"
    git clone git@github.com:zsh-users/zsh-syntax-highlighting.git "${ZSH_SYNTAX_HIGHLIGHTING}"
fi

if ! type php > /dev/null; then
    echo "PHP is not installed, not installing Composer."

    exit 0
fi

COMPOSER_BIN="${LOCAL_BIN_DIR}/composer"

if [ ! -f "${COMPOSER_BIN}" ]; then
    echo "Downloading Composer."
    curl -sS https://getcomposer.org/installer | php -- --install-dir="${LOCAL_BIN_DIR}" --filename=composer
fi

COMPOSER_DIR="${HOME}/.composer"

if [ ! -d "${COMPOSER_DIR}" ]; then
    echo "Creating Composer directory."
    mkdir -p "${COMPOSER_DIR}"
fi

COMPOSER_CONFIG="${HOME}/.composer/composer.json"

if [ ! -f "${COMPOSER_CONFIG}" ] || [ ! -L "${COMPOSER_CONFIG}" ]; then
    echo "Symlinking composer.json."
    ln -snf "${WORK_DIR}/composer.json" "${COMPOSER_CONFIG}"
fi

COMPOSER_LOCK="${HOME}/.local/php/composer.lock"

if [ ! -f "${COMPOSER_LOCK}" ]; then
    echo "Installing Composer packages."
    cd "${COMPOSER_DIR}"
    ${COMPOSER_BIN} install
fi

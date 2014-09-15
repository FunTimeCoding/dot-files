#!/bin/sh -ex
# e: fail hard
# x: verbose

WORK_DIR="${HOME}/.dotfiles"

[ ! -d "${WORK_DIR}" ] && echo "Dotfiles directory must be ${WORK_DIR}." && exit 1

cd "${WORK_DIR}"

SSH_DIR="${HOME}/.ssh"

if [ -d "${SSH_DIR}" ]; then
    echo "Directory ${SSH_DIR} already exists. Replace it? This will rm -rf ${SSH_DIR}."
	select RESULT in "Yes" "No"; do
		case ${RESULT} in
			Yes ) 
				echo "Deleting ${SSH_DIR}."
				rm -rf "${SSH_DIR}"
				break;;
			No ) 
				echo "Setup canceled."
				exit 0;;
		esac
	done
fi

echo "Creating and updating symlinks."

ln -snf "${WORK_DIR}/.ssh" "${HOME}/.ssh"

ln -snf "${WORK_DIR}/.vim" "${HOME}/.vim"
ln -snf "${WORK_DIR}/.vimrc" "${HOME}/.vimrc"
ln -snf "${WORK_DIR}/.vimrc" "${HOME}/.nvimrc"

ln -snf "${WORK_DIR}/.gitconfig" "${HOME}/.gitconfig"
ln -snf "${WORK_DIR}/.gitignore_global" "${HOME}/.gitignore_global"

ln -snf "${WORK_DIR}/.zshrc" "${HOME}/.zshrc"
ln -snf "${WORK_DIR}/.zlogin" "${HOME}/.zlogin"
ln -snf "${WORK_DIR}/.zlogout" "${HOME}/.zlogout"
ln -snf "${WORK_DIR}/.zshenv" "${HOME}/.zshenv"

ln -snf "${WORK_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
ln -snf "${WORK_DIR}/.tmuxinator" "${HOME}/.tmuxinator"
ln -snf "${WORK_DIR}/.muttrc" "${HOME}/.muttrc"
ln -snf "${WORK_DIR}/.hushlogin" "${HOME}/.hushlogin"

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

COMPOSER_FILE="${LOCAL_BIN_DIR}/composer"
if [ ! -f "${COMPOSER_FILE}" ]; then
    curl -sS https://getcomposer.org/installer | php -- --install-dir="${LOCAL_BIN_DIR}" --filename=composer
fi

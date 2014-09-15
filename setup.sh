#!/bin/sh

WORK_DIR="${HOME}/.dotfiles"

[ ! -d "${WORK_DIR}" ] && echo "dotfiles directory must be ${WORK_DIR}" && exit 1

cd "${WORK_DIR}"

SSH_DIR="${HOME}/.ssh"

if [ -d "${SSH_DIR}" ]; then
	echo "${SSH_DIR} already exists, delete?"
	select RESULT in "Yes" "No"; do
		case ${RESULT} in
			Yes ) 
				echo "deleting ${SSH_DIR}"
				rm -rf "${SSH_DIR}"
				break;;
			No ) 
				echo "exiting"
				exit 0;;
		esac
	done
fi

echo "creating and updating symlinks"

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

echo "downloading neobundle"
git clone https://github.com/Shougo/neobundle.vim .vim/bundle/neobundle.vim

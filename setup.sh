#!/bin/sh

WORK_DIR="${HOME}/.dotfiles"

[ ! -d "${WORK_DIR}" ] && echo "dotfiles directory must be ${WORK_DIR}" && exit 1

cd "${WORK_DIR}"

ln -snf "${WORK_DIR}/.ssh" "${HOME}/.ssh"

ln -snf "${WORK_DIR}/.vim" "${HOME}/.vim"
ln -snf "${WORK_DIR}/.vimrc" "${HOME}/.vimrc"

ln -snf "${WORK_DIR}/.gitconfig" "${HOME}/.gitconfig"
ln -snf "${WORK_DIR}/.gitignore" "${HOME}/.gitignore"

ln -snf "${WORK_DIR}/.zshrc" "${HOME}/.zshrc"
ln -snf "${WORK_DIR}/.zlogin" "${HOME}/.zlogin"
ln -snf "${WORK_DIR}/.zlogout" "${HOME}/.zlogout"
ln -snf "${WORK_DIR}/.zshenv" "${HOME}/.zshenv"

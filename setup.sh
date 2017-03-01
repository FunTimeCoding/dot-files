#!/bin/sh -e

if [ -d "${HOME}/.ssh" ]; then
    rm -rf "${HOME}/.ssh"
fi

FILES=$(find . -maxdepth 1 -name '.*' -not -path '*.git' -and -not -path . | awk -F / '{ print $NF }')

for FILE in ${FILES}; do
    ln -snf "${PWD}/${FILE}" "${HOME}/${FILE}"
done

if [ ! -d "${HOME}/src/oh-my-zsh" ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh "${HOME}/src/oh-my-zsh"
fi

if [ ! -d "${HOME}/src/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "${HOME}/src/zsh-syntax-highlighting"
fi

mkdir -p "${HOME}/.config"
ln -snf "${PWD}/powerline" "${HOME}/.config/powerline"
ln -snf "${PWD}/nvim" "${HOME}/.config/nvim"
ln -snf "${HOME}/src/oh-my-zsh" "${HOME}/.oh-my-zsh"
ln -snf "${HOME}/src/zsh-syntax-highlighting" "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

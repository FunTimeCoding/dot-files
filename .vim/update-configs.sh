#!/bin/sh -e

TEMPORARY_DIRECTORY="${HOME}/tmp/vim"
mkdir -p "${TEMPORARY_DIRECTORY}"
SALT_DIRECTORY="${TEMPORARY_DIRECTORY}/vim-salt"

if [ ! -d "${SALT_DIRECTORY}" ]; then
    git clone https://github.com/saltstack/salt-vim "${SALT_DIRECTORY}"
else
    cd "${SALT_DIRECTORY}"
    git pull
fi

cp "${SALT_DIRECTORY}/ftdetect/sls.vim" "${HOME}/.vim/ftdetect"
cp "${SALT_DIRECTORY}/ftplugin/sls.vim" "${HOME}/.vim/ftplugin"
cp "${SALT_DIRECTORY}/syntax/sls.vim" "${HOME}/.vim/syntax"
NGINX_DIRECTORY="${TEMPORARY_DIRECTORY}/nginx"

if [ ! -d "${NGINX_DIRECTORY}" ]; then
    git clone https://github.com/nginx/nginx "${NGINX_DIRECTORY}"
else
    cd "${NGINX_DIRECTORY}"
    git pull
fi

cp "${NGINX_DIRECTORY}/contrib/vim/ftdetect/nginx.vim" "${HOME}/.vim/ftdetect"
cp "${NGINX_DIRECTORY}/contrib/vim/ftplugin/nginx.vim" "${HOME}/.vim/ftplugin"
cp "${NGINX_DIRECTORY}/contrib/vim/syntax/nginx.vim" "${HOME}/.vim/syntax"
cp "${NGINX_DIRECTORY}/contrib/vim/indent/nginx.vim" "${HOME}/.vim/indent"
LOGSTASH_DIRECTORY="${TEMPORARY_DIRECTORY}/vim-logstash"

if [ ! -d "${LOGSTASH_DIRECTORY}" ]; then
    git clone https://github.com/robbles/logstash.vim "${LOGSTASH_DIRECTORY}"
else
    cd "${LOGSTASH_DIRECTORY}"
    git pull
fi

cp "${LOGSTASH_DIRECTORY}/ftdetect/logstash.vim" "${HOME}/.vim/ftdetect"
cp "${LOGSTASH_DIRECTORY}/syntax/logstash.vim" "${HOME}/.vim/syntax"
EUNUCH_DIRECTORY="${TEMPORARY_DIRECTORY}/vim-eunuch"

if [ ! -d "${EUNUCH_DIRECTORY}" ]; then
    git clone https://github.com/tpope/vim-eunuch "${EUNUCH_DIRECTORY}"
else
    cd "${EUNUCH_DIRECTORY}"
    git pull
fi

cp "${EUNUCH_DIRECTORY}/plugin/eunuch.vim" "${HOME}/.vim/plugin"
cp "${EUNUCH_DIRECTORY}/doc/eunuch.txt" "${HOME}/.vim/doc"
THRIFT_DIRECTORY="${TEMPORARY_DIRECTORY}/vim-thrift"

if [ ! -d "${THRIFT_DIRECTORY}" ]; then
    git clone https://github.com/solarnz/thrift.vim "${THRIFT_DIRECTORY}"
else
    cd "${THRIFT_DIRECTORY}"
    git pull
fi

cp "${THRIFT_DIRECTORY}/ftdetect/thrift.vim" "${HOME}/.vim/ftdetect"
cp "${THRIFT_DIRECTORY}/syntax/thrift.vim" "${HOME}/.vim/syntax"
SYSTEMD_DIRECTORY="${TEMPORARY_DIRECTORY}/vim-systemd"

if [ ! -d "${SYSTEMD_DIRECTORY}" ]; then
    git clone https://github.com/Matt-Deacalion/vim-systemd-syntax "${SYSTEMD_DIRECTORY}"
else
    cd "${SYSTEMD_DIRECTORY}"
    git pull
fi

cp "${SYSTEMD_DIRECTORY}/ftdetect/systemd.vim" "${HOME}/.vim/ftdetect"
cp "${SYSTEMD_DIRECTORY}/ftplugin/systemd.vim" "${HOME}/.vim/ftplugin"
cp "${SYSTEMD_DIRECTORY}/syntax/systemd.vim" "${HOME}/.vim/syntax"
DOCKER_DIRECTORY="${TEMPORARY_DIRECTORY}/docker"

if [ ! -d "${DOCKER_DIRECTORY}" ]; then
    git clone https://github.com/docker/docker "${DOCKER_DIRECTORY}"
else
    cd "${DOCKER_DIRECTORY}"
    git pull
fi

cp "${DOCKER_DIRECTORY}/contrib/syntax/vim/ftdetect/dockerfile.vim" "${HOME}/.vim/ftdetect"
cp "${DOCKER_DIRECTORY}/contrib/syntax/vim/syntax/dockerfile.vim" "${HOME}/.vim/syntax"
cp "${DOCKER_DIRECTORY}/contrib/syntax/vim/doc/dockerfile.txt" "${HOME}/.vim/doc"
ICINGA2_DIRECTORY="${TEMPORARY_DIRECTORY}/icinga2"

if [ ! -d "${ICINGA2_DIRECTORY}" ]; then
    git clone https://github.com/Icinga/icinga2 "${ICINGA2_DIRECTORY}"
else
    cd "${ICINGA2_DIRECTORY}"
    git pull
fi

cp "${ICINGA2_DIRECTORY}/tools/syntax/vim/ftdetect/icinga2.vim" "${HOME}/.vim/ftdetect"
cp "${ICINGA2_DIRECTORY}/tools/syntax/vim/syntax/icinga2.vim" "${HOME}/.vim/syntax"
ROBOT_DIRECTORY="${TEMPORARY_DIRECTORY}/vim-robot"

if [ ! -d "${ROBOT_DIRECTORY}" ]; then
    git clone https://github.com/mfukar/robotframework-vim "${ROBOT_DIRECTORY}"
else
    cd "${ROBOT_DIRECTORY}"
    git pull
fi

cp "${ROBOT_DIRECTORY}/ftdetect/robot.vim" "${HOME}/.vim/ftdetect"
cp "${ROBOT_DIRECTORY}/after/syntax/robot.vim" "${HOME}/.vim/after/syntax"
JINJA_DIRECTORY="${TEMPORARY_DIRECTORY}/jinja"

if [ ! -d "${JINJA_DIRECTORY}" ]; then
    git clone https://github.com/pallets/jinja "${JINJA_DIRECTORY}"
else
    cd "${JINJA_DIRECTORY}"
    git pull
fi

cp "${JINJA_DIRECTORY}/ext/Vim/jinja.vim" "${HOME}/.vim/syntax"
COMMENTARY_DIRECTORY="${TEMPORARY_DIRECTORY}/vim-commentary"

if [ ! -d "${COMMENTARY_DIRECTORY}" ]; then
    git clone https://github.com/tpope/vim-commentary "${COMMENTARY_DIRECTORY}"
else
    cd "${COMMENTARY_DIRECTORY}"
    git pull
fi

cp "${COMMENTARY_DIRECTORY}/plugin/commentary.vim" "${HOME}/.vim/plugin"

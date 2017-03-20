#!/bin/sh -e

SALT_DIRECTORY="${HOME}/src/vim-salt"
cp "${SALT_DIRECTORY}/ftdetect/sls.vim" "${HOME}/.vim/ftdetect"
cp "${SALT_DIRECTORY}/ftplugin/sls.vim" "${HOME}/.vim/ftplugin"
cp "${SALT_DIRECTORY}/syntax/sls.vim" "${HOME}/.vim/syntax"

NGINX_DIRECTORY="${HOME}/src/nginx"
cp "${NGINX_DIRECTORY}/contrib/vim/ftdetect/nginx.vim" "${HOME}/.vim/ftdetect"
cp "${NGINX_DIRECTORY}/contrib/vim/ftplugin/nginx.vim" "${HOME}/.vim/ftplugin"
cp "${NGINX_DIRECTORY}/contrib/vim/syntax/nginx.vim" "${HOME}/.vim/syntax"
cp "${NGINX_DIRECTORY}/contrib/vim/indent/nginx.vim" "${HOME}/.vim/indent"

LOGSTASH_DIRECTORY="${HOME}/src/vim-logstash"
cp "${LOGSTASH_DIRECTORY}/ftdetect/logstash.vim" "${HOME}/.vim/ftdetect"
cp "${LOGSTASH_DIRECTORY}/syntax/logstash.vim" "${HOME}/.vim/syntax"

EUNUCH_DIRECTORY="${HOME}/src/vim-eunuch"
cp "${EUNUCH_DIRECTORY}/plugin/eunuch.vim" "${HOME}/.vim/plugin"
cp "${EUNUCH_DIRECTORY}/doc/eunuch.txt" "${HOME}/.vim/doc"

THRIFT_DIRECTORY="${HOME}/src/vim-thrift"
cp "${THRIFT_DIRECTORY}/ftdetect/thrift.vim" "${HOME}/.vim/ftdetect"
cp "${THRIFT_DIRECTORY}/syntax/thrift.vim" "${HOME}/.vim/syntax"

SYSTEMD_DIRECTORY="${HOME}/src/vim-systemd"
cp "${SYSTEMD_DIRECTORY}/ftdetect/systemd.vim" "${HOME}/.vim/ftdetect"
cp "${SYSTEMD_DIRECTORY}/ftplugin/systemd.vim" "${HOME}/.vim/ftplugin"
cp "${SYSTEMD_DIRECTORY}/syntax/systemd.vim" "${HOME}/.vim/syntax"

DOCKER_DIRECTORY="${HOME}/src/docker"
cp "${DOCKER_DIRECTORY}/contrib/syntax/vim/ftdetect/dockerfile.vim" "${HOME}/.vim/ftdetect"
cp "${DOCKER_DIRECTORY}/contrib/syntax/vim/syntax/dockerfile.vim" "${HOME}/.vim/syntax"
cp "${DOCKER_DIRECTORY}/contrib/syntax/vim/doc/dockerfile.txt" "${HOME}/.vim/doc"

ICINGA2_DIRECTORY="${HOME}/src/icinga2"
cp "${ICINGA2_DIRECTORY}/tools/syntax/vim/ftdetect/icinga2.vim" "${HOME}/.vim/ftdetect"
cp "${ICINGA2_DIRECTORY}/tools/syntax/vim/syntax/icinga2.vim" "${HOME}/.vim/syntax"

ROBOT_DIRECTORY="${HOME}/src/vim-robot"
cp "${ROBOT_DIRECTORY}/ftdetect/robot.vim" "${HOME}/.vim/ftdetect"
cp "${ROBOT_DIRECTORY}/after/syntax/robot.vim" "${HOME}/.vim/after/syntax"

JINJA_DIRECTORY="${HOME}/src/jinja"
cp "${JINJA_DIRECTORY}/ext/Vim/jinja.vim" "${HOME}/.vim/syntax"

COMMENTARY_DIRECTORY="${HOME}/src/vim-commentary"
cp "${COMMENTARY_DIRECTORY}/plugin/commentary.vim" "${HOME}/.vim/plugin"

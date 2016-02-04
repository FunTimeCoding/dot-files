#!/bin/sh -e

cd "${HOME}"/Documents
rsync -avz --delete ftp.rfc-editor.org::rfcs-text-only RFC

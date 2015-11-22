#!/bin/sh

cat <<EOF | sendmail -t
To: funtimecoding@gmail.com
Subject: test subject
From: shiin@shiin.org

test body
EOF

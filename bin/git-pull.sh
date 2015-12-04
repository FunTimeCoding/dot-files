#!/bin/sh -e

git stash
git pull --rebase
git stash pop

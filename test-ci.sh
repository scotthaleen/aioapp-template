#!/usr/bin/env sh

set -ex

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
echo "sh $(which sh)"

APP=aio_example

./cookie-test.py "${APP}"

cd "${APP}"

make venv_build

ls -lah .
ls -lah "${APP}"/

cat "${APP}"/.python-version
make tox

cd "${APP}"
tox -e devrun

pyenv uninstall -f "${APP}_project"
pyenv uninstall -f "${APP}"


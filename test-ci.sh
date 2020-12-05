#!/bin/bash

set -ex

APP=aio_example

./cookie-test.py "${APP}"


cd "${APP}"
make venv_build
make tox

cd "${APP}"
python -m tox -e devrun


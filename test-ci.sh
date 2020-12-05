#!/bin/bash

set -e

APP=aio_example

./cookie-test.py "${APP}"

cd "${APP}"
make venv_build
make tox

cd "${APP}"
python -m tox -e devrun


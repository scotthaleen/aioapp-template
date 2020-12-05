#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys

from cookiecutter.main import cookiecutter

cookiecutter(".",
             no_input=True,
             extra_context={"project_pkg": sys.argv[1]})

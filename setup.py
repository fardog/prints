#!/usr/bin/env python
from setuptools import setup, find_packages
from os.path import join


libraries = [l.strip() for l in open("requirements.txt").readlines()]

PKG = "prints"
VERSION = "unknown"
exec(open(join(PKG, "_version.py")).read())

setup(
    name=PKG,
    version=VERSION,
    author="Nathan Wittstock <nate@fardog.io>",
    packages=find_packages(),
    install_requires=libraries,
    scripts=["scripts/solid"],
)

# SPDX-FileCopyrightText: 2024 Jakub Wasylków <kuba_160@protonmail.com>
# SPDX-License-Identifier: CC-PDDC

#!/bin/bash

# dl
gcc dl.c -o dl -g -ldl

# plug
PE_CFLAGS=`pkgconf --cflags python3-embed`
PE_LIBS=`pkgconf --libs python3-embed`

cython --3str example.pyx
gcc example.c lpython.c $PE_CFLAGS $PE_LIBS -fPIC -shared -g -o python.so

# install
cp -v python.so ~/.local/lib/deadbeef/python.so

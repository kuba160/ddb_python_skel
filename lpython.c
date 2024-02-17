// SPDX-FileCopyrightText: 2024 Jakub Wasylków <kuba_160@protonmail.com>
// SPDX-License-Identifier: CC-PDDC

#include "deadbeef.h"
#include "example.h"

PyObject *pmodule = NULL;

void lpython_init() {
    if (PyImport_AppendInittab("example", PyInit_example) == -1) {
        printf("Error: could not extend in-built modules table\n");
    }
    Py_Initialize();
    pmodule = PyImport_ImportModule("example");
}

void lpython_cleanup() {
    Py_Finalize();
}

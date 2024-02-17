// SPDX-FileCopyrightText: 2024 Jakub Wasylków <kuba_160@protonmail.com>
// SPDX-License-Identifier: CC-PDDC

#include <stdio.h>
#include <dlfcn.h>
#include "deadbeef.h"

typedef void(*init_func_t)(void);
typedef DB_plugin_t* (*load_func_t)(DB_functions_t*);

int main(int argc, char *argv[]) {
    if (argc <=1) {
        printf("USAGE: %s [PLUGIN]\n", argv[0]);
        return 1;
    }
    void* lib = dlopen(argv[1], RTLD_LAZY);
    if (lib == NULL) {
        fprintf(stderr, "Error opening library: %s\n", dlerror());
        return 1;
    }

    // init
    load_func_t load_func = (load_func_t)dlsym(lib, "python_load");
    if (load_func == NULL) {
        fprintf(stderr, "Error finding function: %s\n", dlerror());
        dlclose(lib);
        return 1;
    }
    printf("python_load found\n");

    DB_functions_t funcs = {0};
    funcs.log = printf;

    DB_plugin_t *plug = load_func(&funcs);
    printf("python_load called\n");

    if (!plug) {
        printf("loading plugin failed\n");
        return 1;
    }

    // start and stop
    if (!plug->start) {
        printf("Plugin does not have start!\n");
        return 1;
    }
    plug->start();

    if (!plug->stop) {
        printf("Plugin does not have stop!\n");
        return 1;
    }
    plug->stop();

    dlclose(lib);
    return 0;
}

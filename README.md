# ddb_python_skel

Proof of concept on how to integrate Python/Cython with deadbeef.

## Building

You need Python, Cython and C compiler (currently gcc, but can be changed in `make.sh`).

Running `make.sh` will compile `dl.c` for basic testing of the generated library. Then it will generate `example.c` from Cython code and link it together with `lpython.c` which is some basic wrapper for Python initialization. Example plugin will be generated as `python.so` and then copied to `~/.local/lib/deadbeef/`.

## Notes

- I spent some time getting the subclassing to work and couldn't figure out how to have a pure python subclass for (custom) plugin specification, it requires Cython class (`cdef class`) to work.
- There can occur some data corruption with plugin info strings so be warned (happens to me when I try to print them out lol)
- Code is a mess I suppose and I'm not sure if I will work on that (just wanted to see if it is possible)
- I forgot to mention but the `deadbeef.pxd` is partially generated with `pxdgen` (was PITA to set it up). It needed some tweaks but the modifications are placed at the beginning.
 

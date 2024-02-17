# SPDX-FileCopyrightText: 2024 Jakub Wasylków <kuba_160@protonmail.com>
# SPDX-License-Identifier: CC-PDDC

include "deadbeef.pxd"

cdef extern from "lpython.h":
    void lpython_init()
    void lpython_cleanup()

cdef public int plug_start() noexcept:
    return plug_class.start()

cdef public int plug_stop() noexcept:
    ret = plug_class.stop()
    lpython_cleanup()
    return ret

cdef public int connect() noexcept:
    return plug_class.connect()

cdef public int disconnect() noexcept:
    return plug_class.disconnect()


cdef struct PlugInfo:
    const char * id
    const char * name
    const char * descr
    const char * copyright
    const char * website
    const char * configdialog
    int32_t type
    int16_t api_vmajor
    int16_t api_vminor
    int16_t version_major
    int16_t version_minor
    uint32_t flags

cdef class PluginClass:
    cdef PlugInfo info
    cdef DB_plugin_t plugin

    cdef DB_plugin_t* get_pluginfo(self):
        return &self.plugin
    def __cinit__(self,
        PlugInfo i):
        self.info = i
        self.plugin = DB_plugin_t(
            type = i.type,
            api_vmajor = i.api_vmajor,
            api_vminor = i.api_vminor,
            version_major = i.version_major,
            version_minor = i.version_minor,
            flags = i.flags,
            reserved1 = 0,
            reserved2 = 0,
            reserved3 = 0,
            id = i.id,
            name = i.name,
            descr = i.descr,
            copyright = i.copyright,
            website = i.website,
            command = NULL,
            start = plug_start,
            stop = plug_stop,
            connect = NULL,
            disconnect = NULL,
            exec_cmdline = NULL,
            get_actions = NULL,
            message = NULL,
            configdialog = i.configdialog
        )
    # @property
    # def version_major(self):
    #     return self.plugin.version_major
    # @version_major.setter
    # def version_major(self, new_v):
    #     self.plugin.version_major = new_v

    def start(self):
        return 0
    def stop(self):
        return 0
    def connect(self):
        return 0
    def disconnect(self):
        return 0
    def exec_cmdline(self, cmdline, cmdline_size, response):
        pass
    def get_actions(self, item):
        return None
    def message(self, id, ctx, p1, p2):
        pass

cdef PlugInfo plug_info = PlugInfo(name = "Python Skeleton plugin",
                                   id = "python_skel",
                                   descr = "Example python plugin",
                                   copyright = "CC-PDDC (Public domain)",
                                   website = "https://github.com/kuba160/ddb_python_skel",
                                   configdialog = "",
                                   api_vmajor = 1,
                                   api_vminor = 18,
                                   version_major = 0,
                                   version_minor = 1,
                                   flags = 0,
                                   type = DB_PLUGIN_MISC)

cdef class PluginSubClass(PluginClass):

    # def __init__(self, PlugInfo info):
    #     pass
    # #    #super().__init__(info)
    # #    #PluginClass.__cinit__(self,info)
    # #    #print(info)

    def start(self):
        # deadbeef.log(bytes(str(self.info).encode('utf-8')))
        deadbeef.log("Hello from Python/Cython!\n")
        return 0

    def stop(self):
        deadbeef.log("Python plugin stop\n")
        return 0


cdef PluginClass plug_class = None
cdef public DB_functions_t * deadbeef;

cdef public DB_plugin_t * python_load(DB_functions_t *funcs):
    global deadbeef
    global plug_class
    lpython_init()
    deadbeef = funcs
    plug_class = PluginSubClass(plug_info)
    return plug_class.get_pluginfo()

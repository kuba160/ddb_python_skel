# SPDX-FileCopyrightText: 2024 Jakub Wasylków <kuba_160@protonmail.com>
# SPDX-License-Identifier: CC-PDDC

# extra needed
cdef enum:
    DB_API_VERSION_MAJOR = 1
    DB_API_VERSION_MINOR = 18


cdef extern from "dirent.h" nogil:
    ctypedef struct DIR:
        pass
    cdef struct dirent:
        char* d_name

    dirent* readdir(DIR* dirp)
    int readdir_r(DIR *dirp, dirent *entry, dirent **result)

from cpython.getargs cimport va_list
from libc.time cimport time_t
from libc.stdio cimport FILE
from libc.stdint cimport int32_t, uint32_t, uint8_t, intptr_t, uintptr_t, int64_t, uint64_t, int16_t
# generated with pxdgen
cdef extern from "./deadbeef.h":

    cdef struct scriptableItem_s

    ctypedef scriptableItem_s ddb_scriptable_item_t

    cpdef enum:
        DDB_IS_SUBTRACK
        DDB_IS_READONLY
        DDB_HAS_EMBEDDED_CUESHEET
        DDB_TAG_ID3V1
        DDB_TAG_ID3V22
        DDB_TAG_ID3V23
        DDB_TAG_ID3V24
        DDB_TAG_APEV2
        DDB_TAG_VORBISCOMMENTS
        DDB_TAG_CUESHEET
        DDB_TAG_ICY
        DDB_TAG_ITUNES
        DDB_TAG_MASK

    cdef struct DB_playItem_s:
        int32_t startsample
        int32_t endsample
        int32_t shufflerating

    ctypedef DB_playItem_s ddb_playItem_t

    ctypedef ddb_playItem_t DB_playItem_t

    ctypedef struct ddb_playlist_t:
        char unused

    cdef struct DB_metaInfo_s:
        DB_metaInfo_s* next
        const char* key
        const char* value
        int valuesize

    ctypedef DB_metaInfo_s DB_metaInfo_t

    cdef struct DB_id3v2_frame_s:
        DB_id3v2_frame_s* next
        char id[5]
        uint32_t size
        uint8_t flags[2]
        uint8_t data[0]

    ctypedef DB_id3v2_frame_s DB_id3v2_frame_t

    cdef struct DB_id3v2_tag_s:
        uint8_t version[2]
        uint8_t flags
        DB_id3v2_frame_t* frames

    ctypedef DB_id3v2_tag_s DB_id3v2_tag_t

    cdef struct DB_apev2_frame_s:
        DB_apev2_frame_s* next
        uint32_t flags
        char key[256]
        uint32_t size
        uint8_t data[0]

    ctypedef DB_apev2_frame_s DB_apev2_frame_t

    cdef struct DB_apev2_tag_s:
        uint32_t version
        uint32_t flags
        DB_apev2_frame_t* frames

    ctypedef DB_apev2_tag_s DB_apev2_tag_t

    cpdef enum:
        DB_PLUGIN_DECODER
        DB_PLUGIN_OUTPUT
        DB_PLUGIN_DSP
        DB_PLUGIN_MISC
        DB_PLUGIN_VFS
        DB_PLUGIN_PLAYLIST
        DB_PLUGIN_GUI
        DB_PLUGIN_MEDIASOURCE

    cpdef enum output_state_t:
        OUTPUT_STATE_STOPPED
        OUTPUT_STATE_PLAYING
        OUTPUT_STATE_PAUSED

    cpdef enum ddb_playback_state_e:
        DDB_PLAYBACK_STATE_STOPPED
        DDB_PLAYBACK_STATE_PLAYING
        DDB_PLAYBACK_STATE_PAUSED

    ctypedef ddb_playback_state_e ddb_playback_state_t

    cpdef enum playback_order_t:
        PLAYBACK_ORDER_LINEAR
        PLAYBACK_ORDER_SHUFFLE_TRACKS
        PLAYBACK_ORDER_RANDOM
        PLAYBACK_ORDER_SHUFFLE_ALBUMS

    cpdef enum playback_mode_t:
        PLAYBACK_MODE_LOOP_ALL
        PLAYBACK_MODE_NOLOOP
        PLAYBACK_MODE_LOOP_SINGLE

    cpdef enum ddb_shuffle_e:
        DDB_SHUFFLE_OFF
        DDB_SHUFFLE_TRACKS
        DDB_SHUFFLE_RANDOM
        DDB_SHUFFLE_ALBUMS

    ctypedef ddb_shuffle_e ddb_shuffle_t

    cpdef enum ddb_repeat_e:
        DDB_REPEAT_ALL
        DDB_REPEAT_OFF
        DDB_REPEAT_SINGLE

    ctypedef ddb_repeat_e ddb_repeat_t

    cpdef enum ddb_playlist_change_t:
        DDB_PLAYLIST_CHANGE_CONTENT
        DDB_PLAYLIST_CHANGE_CREATED
        DDB_PLAYLIST_CHANGE_DELETED
        DDB_PLAYLIST_CHANGE_POSITION
        DDB_PLAYLIST_CHANGE_TITLE
        DDB_PLAYLIST_CHANGE_SELECTION
        DDB_PLAYLIST_CHANGE_SEARCHRESULT
        DDB_PLAYLIST_CHANGE_PLAYQUEUE

    ctypedef struct ddb_event_t:
        int event
        int size

    ctypedef struct ddb_event_track_t:
        ddb_event_t ev
        DB_playItem_t* track
        float playtime
        time_t started_timestamp

    ctypedef struct ddb_event_trackchange_t:
        ddb_event_t ev
        DB_playItem_t* from_ "from"
        DB_playItem_t* to
        float playtime
        time_t started_timestamp

    ctypedef struct ddb_event_state_t:
        ddb_event_t ev
        int state

    ctypedef struct ddb_event_playpos_t:
        ddb_event_t ev
        DB_playItem_t* track
        float playpos

    cdef struct DB_conf_item_s:
        char* key
        char* value
        DB_conf_item_s* next

    ctypedef DB_conf_item_s DB_conf_item_t

    cpdef enum:
        DB_EV_NEXT
        DB_EV_PREV
        DB_EV_PLAY_CURRENT
        DB_EV_PLAY_NUM
        DB_EV_STOP
        DB_EV_PAUSE
        DB_EV_PLAY_RANDOM
        DB_EV_TERMINATE
        DB_EV_PLAYLIST_REFRESH
        DB_EV_REINIT_SOUND
        DB_EV_CONFIGCHANGED
        DB_EV_TOGGLE_PAUSE
        DB_EV_ACTIVATED
        DB_EV_PAUSED
        DB_EV_PLAYLISTCHANGED
        DB_EV_VOLUMECHANGED
        DB_EV_OUTPUTCHANGED
        DB_EV_PLAYLISTSWITCHED
        DB_EV_SEEK
        DB_EV_ACTIONSCHANGED
        DB_EV_DSPCHAINCHANGED
        DB_EV_SELCHANGED
        DB_EV_PLUGINSLOADED
        DB_EV_FOCUS_SELECTION
        DB_EV_PLAYBACK_STATE_DID_CHANGE
        DB_EV_PLAY_NEXT_ALBUM
        DB_EV_PLAY_PREV_ALBUM
        DB_EV_PLAY_RANDOM_ALBUM
        DB_EV_FIRST
        DB_EV_SONGCHANGED
        DB_EV_SONGSTARTED
        DB_EV_SONGFINISHED
        DB_EV_TRACKINFOCHANGED
        DB_EV_SEEKED
        DB_EV_TRACKFOCUSCURRENT
        DB_EV_CURSOR_MOVED
        DB_EV_MAX

    cpdef enum pl_column_t:
        DB_COLUMN_STANDARD
        DB_COLUMN_FILENUMBER
        DB_COLUMN_PLAYING
        DB_COLUMN_ALBUM_ART
        DB_COLUMN_CUSTOM

    cpdef enum:
        DDB_REPLAYGAIN_ALBUMGAIN
        DDB_REPLAYGAIN_ALBUMPEAK
        DDB_REPLAYGAIN_TRACKGAIN
        DDB_REPLAYGAIN_TRACKPEAK

    cpdef enum ddb_rg_source_mode_e:
        DDB_RG_SOURCE_MODE_PLAYBACK_ORDER
        DDB_RG_SOURCE_MODE_TRACK
        DDB_RG_SOURCE_MODE_ALBUM

    ctypedef ddb_rg_source_mode_e ddb_rg_source_mode_t

    cpdef enum ddb_rg_processing_e:
        DDB_RG_PROCESSING_NONE
        DDB_RG_PROCESSING_GAIN
        DDB_RG_PROCESSING_PREVENT_CLIPPING

    ctypedef ddb_rg_processing_e ddb_rg_processing_t

    ctypedef struct ddb_replaygain_settings_t:
        int _size
        int source_mode
        uint32_t processing_flags
        float preamp_with_rg
        float preamp_without_rg
        int has_album_gain
        int has_track_gain
        float albumgain
        float albumpeak
        float trackgain
        float trackpeak

    cpdef enum ddb_sort_order_t:
        DDB_SORT_DESCENDING
        DDB_SORT_ASCENDING
        DDB_SORT_RANDOM

    cpdef enum ddb_sys_directory_t:
        DDB_SYS_DIR_CONFIG
        DDB_SYS_DIR_PREFIX
        DDB_SYS_DIR_DOC
        DDB_SYS_DIR_PLUGIN
        DDB_SYS_DIR_PIXMAP
        DDB_SYS_DIR_CACHE
        DDB_SYS_DIR_PLUGIN_RESOURCES

    ctypedef struct DB_FILE:
        DB_vfs_s* vfs

    cdef struct DB_md5_s:
        char data[88]

    ctypedef DB_md5_s DB_md5_t

    ctypedef struct ddb_waveformat_t:
        int bps
        int channels
        int samplerate
        uint32_t channelmask
        int is_float
        uint32_t flags

    cpdef enum:
        DDB_WAVEFORMAT_FLAG_IS_DOP

    const int DDB_FREQ_BANDS

    const int DDB_FREQ_MAX_CHANNELS

    cdef struct ddb_audio_data_s:
        ddb_waveformat_t* fmt
        float* data
        int nframes

    ctypedef ddb_audio_data_s ddb_audio_data_t

    cdef struct ddb_fileadd_data_s:
        int visibility
        ddb_playlist_t* plt
        ddb_playItem_t* track

    ctypedef ddb_fileadd_data_s ddb_fileadd_data_t

    cpdef enum:
        DDB_TF_CONTEXT_HAS_INDEX
        DDB_TF_CONTEXT_HAS_ID
        DDB_TF_CONTEXT_NO_DYNAMIC
        DDB_TF_CONTEXT_MULTILINE
        DDB_TF_CONTEXT_TEXT_DIM
        DDB_TF_CONTEXT_NO_MUTEX_LOCK

    cpdef enum:
        DDB_TF_ESC_DIM
        DDB_TF_ESC_RGB

    cdef struct ddb_file_found_data_s:
        ddb_playlist_t* plt
        const char* filename
        int is_dir

    ctypedef ddb_file_found_data_s ddb_file_found_data_t

    ctypedef void (*_ddb_tf_context_t_ddb_tf_context_t_ddb_tf_context_s_metadata_transformer_ft)(ddb_tf_context_s* ctx, char* data, size_t size)

    cdef struct ddb_tf_context_s:
        int _size
        uint32_t flags
        ddb_playItem_t* it
        ddb_playlist_t* plt
        int idx
        int id
        int iter
        int update
        int dimmed
        _ddb_tf_context_t_ddb_tf_context_t_ddb_tf_context_s_metadata_transformer_ft metadata_transformer

    ctypedef ddb_tf_context_s ddb_tf_context_t

    cpdef enum:
        DDB_LOG_LAYER_DEFAULT
        DDB_LOG_LAYER_INFO

    ctypedef enum ddb_insert_file_result_t:
        DDB_INSERT_FILE_RESULT_SUCCESS
        DDB_INSERT_FILE_RESULT_UNRECOGNIZED_FILE
        DDB_INSERT_FILE_RESULT_RECOGNIZED_FAILED
        DDB_INSERT_FILE_RESULT_RELATIVE_PATH
        DDB_INSERT_FILE_RESULT_NULL_FILENAME
        DDB_INSERT_FILE_RESULT_ESCAPE_CHARACTERS_IN_FILENAME
        DDB_INSERT_FILE_RESULT_NO_FILE_EXTENSION
        DDB_INSERT_FILE_RESULT_CUESHEET_ERROR

    ctypedef enum ddb_insert_file_flags_t:
        DDB_INSERT_FILE_FLAG_FOLLOW_SYMLINKS
        DDB_INSERT_FILE_FLAG_ENTER_ARCHIVES

    cdef struct DB_plugin_s

    ctypedef void (*_DB_functions_t_DB_functions_t_md5_ft)(uint8_t sig[16], const char* in_, int len)

    ctypedef void (*_DB_functions_t_DB_functions_t_md5_to_str_ft)(char* str, const uint8_t sig[16])

    ctypedef void (*_DB_functions_t_DB_functions_t_md5_init_ft)(DB_md5_t* s)

    ctypedef void (*_DB_functions_t_DB_functions_t_md5_append_ft)(DB_md5_t* s, const uint8_t* data, int nbytes)

    ctypedef void (*_DB_functions_t_DB_functions_t_md5_finish_ft)(DB_md5_t* s, uint8_t digest[16])

    ctypedef DB_output_s* (*_DB_functions_t_DB_functions_t_get_output_ft)()

    ctypedef float (*_DB_functions_t_DB_functions_t_playback_get_pos_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_playback_set_pos_ft)(float pos)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_streamer_get_playing_track_ft)()

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_streamer_get_streaming_track_ft)()

    ctypedef float (*_DB_functions_t_DB_functions_t_streamer_get_playpos_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_streamer_ok_to_read_ft)(int len)

    ctypedef void (*_DB_functions_t_DB_functions_t_streamer_reset_ft)(int full)

    ctypedef int (*_DB_functions_t_DB_functions_t_streamer_read_ft)(char* bytes, int size)

    ctypedef void (*_DB_functions_t_DB_functions_t_streamer_set_bitrate_ft)(int bitrate)

    ctypedef int (*_DB_functions_t_DB_functions_t_streamer_get_apx_bitrate_ft)()

    ctypedef DB_fileinfo_s* (*_DB_functions_t_DB_functions_t_streamer_get_current_fileinfo_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_streamer_get_current_playlist_ft)()

    ctypedef ddb_dsp_context_s* (*_DB_functions_t_DB_functions_t_streamer_get_dsp_chain_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_streamer_set_dsp_chain_ft)(ddb_dsp_context_s* chain)

    ctypedef void (*_DB_functions_t_DB_functions_t_streamer_dsp_refresh_ft)()

    ctypedef const char* (*_DB_functions_t_DB_functions_t_get_config_dir_ft)()

    ctypedef const char* (*_DB_functions_t_DB_functions_t_get_prefix_ft)()

    ctypedef const char* (*_DB_functions_t_DB_functions_t_get_doc_dir_ft)()

    ctypedef const char* (*_DB_functions_t_DB_functions_t_get_plugin_dir_ft)()

    ctypedef const char* (*_DB_functions_t_DB_functions_t_get_pixmap_dir_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_do_not_call_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_thread_start_fn_ft)(void* ctx)

    ctypedef intptr_t (*_DB_functions_t_DB_functions_t_thread_start_ft)(_DB_functions_t_DB_functions_t_thread_start_fn_ft fn, void* ctx)

    ctypedef void (*_DB_functions_t_DB_functions_t_thread_start_low_priority_fn_ft)(void* ctx)

    ctypedef intptr_t (*_DB_functions_t_DB_functions_t_thread_start_low_priority_ft)(_DB_functions_t_DB_functions_t_thread_start_low_priority_fn_ft fn, void* ctx)

    ctypedef int (*_DB_functions_t_DB_functions_t_thread_join_ft)(intptr_t tid)

    ctypedef int (*_DB_functions_t_DB_functions_t_thread_detach_ft)(intptr_t tid)

    ctypedef void (*_DB_functions_t_DB_functions_t_thread_exit_ft)(void* retval)

    ctypedef uintptr_t (*_DB_functions_t_DB_functions_t_mutex_create_ft)()

    ctypedef uintptr_t (*_DB_functions_t_DB_functions_t_mutex_create_nonrecursive_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_mutex_free_ft)(uintptr_t mtx)

    ctypedef int (*_DB_functions_t_DB_functions_t_mutex_lock_ft)(uintptr_t mtx)

    ctypedef int (*_DB_functions_t_DB_functions_t_mutex_unlock_ft)(uintptr_t mtx)

    ctypedef uintptr_t (*_DB_functions_t_DB_functions_t_cond_create_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_cond_free_ft)(uintptr_t cond)

    ctypedef int (*_DB_functions_t_DB_functions_t_cond_wait_ft)(uintptr_t cond, uintptr_t mutex)

    ctypedef int (*_DB_functions_t_DB_functions_t_cond_signal_ft)(uintptr_t cond)

    ctypedef int (*_DB_functions_t_DB_functions_t_cond_broadcast_ft)(uintptr_t cond)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_ref_ft)(ddb_playlist_t* plt)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_unref_ft)(ddb_playlist_t* plt)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_get_count_ft)()

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_get_head_ft)(int plt)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_get_sel_count_ft)(int plt)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_add_ft)(int before, const char* title)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_remove_ft)(int plt)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_clear_ft)(ddb_playlist_t* plt)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_clear_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_set_curr_ft)(ddb_playlist_t* plt)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_set_curr_idx_ft)(int plt)

    ctypedef ddb_playlist_t* (*_DB_functions_t_DB_functions_t_plt_get_curr_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_get_curr_idx_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_move_ft)(int from_, int before)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_load_cb_ft)(DB_playItem_t* it, void* data)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_load_ft)(ddb_playlist_t* plt, DB_playItem_t* after, const char* fname, int* pabort, _DB_functions_t_DB_functions_t_plt_load_cb_ft cb, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_save_cb_ft)(DB_playItem_t* it, void* data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_save_ft)(ddb_playlist_t* plt, DB_playItem_t* first, DB_playItem_t* last, const char* fname, int* pabort, _DB_functions_t_DB_functions_t_plt_save_cb_ft cb, void* user_data)

    ctypedef ddb_playlist_t* (*_DB_functions_t_DB_functions_t_plt_get_for_idx_ft)(int idx)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_get_title_ft)(ddb_playlist_t* plt, char* buffer, int bufsize)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_set_title_ft)(ddb_playlist_t* plt, const char* title)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_modified_ft)(ddb_playlist_t* handle)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_get_modification_idx_ft)(ddb_playlist_t* handle)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_get_item_idx_ft)(ddb_playlist_t* plt, DB_playItem_t* it, int iter)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_add_meta_ft)(ddb_playlist_t* handle, const char* key, const char* value)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_replace_meta_ft)(ddb_playlist_t* handle, const char* key, const char* value)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_append_meta_ft)(ddb_playlist_t* handle, const char* key, const char* value)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_set_meta_int_ft)(ddb_playlist_t* handle, const char* key, int value)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_set_meta_float_ft)(ddb_playlist_t* handle, const char* key, float value)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_plt_find_meta_ft)(ddb_playlist_t* handle, const char* key)

    ctypedef DB_metaInfo_t* (*_DB_functions_t_DB_functions_t_plt_get_metadata_head_ft)(ddb_playlist_t* handle)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_delete_metadata_ft)(ddb_playlist_t* handle, DB_metaInfo_t* meta)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_find_meta_int_ft)(ddb_playlist_t* handle, const char* key, int def_)

    ctypedef float (*_DB_functions_t_DB_functions_t_plt_find_meta_float_ft)(ddb_playlist_t* handle, const char* key, float def_)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_delete_all_meta_ft)(ddb_playlist_t* handle)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_insert_item_ft)(ddb_playlist_t* playlist, DB_playItem_t* after, DB_playItem_t* it)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_insert_file_cb_ft)(DB_playItem_t* it, void* data)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_insert_file_ft)(ddb_playlist_t* playlist, DB_playItem_t* after, const char* fname, int* pabort, _DB_functions_t_DB_functions_t_plt_insert_file_cb_ft cb, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_insert_dir_cb_ft)(DB_playItem_t* it, void* data)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_insert_dir_ft)(ddb_playlist_t* plt, DB_playItem_t* after, const char* dirname, int* pabort, _DB_functions_t_DB_functions_t_plt_insert_dir_cb_ft cb, void* user_data)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_set_item_duration_ft)(ddb_playlist_t* plt, DB_playItem_t* it, float duration)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_remove_item_ft)(ddb_playlist_t* playlist, DB_playItem_t* it)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_getselcount_ft)(ddb_playlist_t* playlist)

    ctypedef float (*_DB_functions_t_DB_functions_t_plt_get_totaltime_ft)(ddb_playlist_t* plt)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_get_item_count_ft)(ddb_playlist_t* plt, int iter)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_delete_selected_ft)(ddb_playlist_t* plt)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_set_cursor_ft)(ddb_playlist_t* plt, int iter, int cursor)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_get_cursor_ft)(ddb_playlist_t* plt, int iter)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_select_all_ft)(ddb_playlist_t* plt)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_crop_selected_ft)(ddb_playlist_t* plt)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_get_first_ft)(ddb_playlist_t* plt, int iter)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_get_last_ft)(ddb_playlist_t* plt, int iter)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_get_item_for_idx_ft)(ddb_playlist_t* playlist, int idx, int iter)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_move_items_ft)(ddb_playlist_t* to, int iter, ddb_playlist_t* from_, DB_playItem_t* drop_before, uint32_t* indexes, int count)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_copy_items_ft)(ddb_playlist_t* to, int iter, ddb_playlist_t* from_, DB_playItem_t* before, uint32_t* indices, int cnt)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_search_reset_ft)(ddb_playlist_t* plt)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_search_process_ft)(ddb_playlist_t* plt, const char* text)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_sort_ft)(ddb_playlist_t* plt, int iter, int id, const char* format, int order)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_add_file_cb_ft)(DB_playItem_t* it, void* data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_add_file_ft)(ddb_playlist_t* plt, const char* fname, _DB_functions_t_DB_functions_t_plt_add_file_cb_ft cb, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_add_dir_cb_ft)(DB_playItem_t* it, void* data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_add_dir_ft)(ddb_playlist_t* plt, const char* dirname, _DB_functions_t_DB_functions_t_plt_add_dir_cb_ft cb, void* user_data)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_insert_cue_from_buffer_ft)(ddb_playlist_t* plt, DB_playItem_t* after, DB_playItem_t* origin, const uint8_t* buffer, int buffersize, int numsamples, int samplerate)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_insert_cue_ft)(ddb_playlist_t* plt, DB_playItem_t* after, DB_playItem_t* origin, int numsamples, int samplerate)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_lock_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_unlock_ft)()

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_pl_item_alloc_ft)()

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_pl_item_alloc_init_ft)(const char* fname, const char* decoder_id)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_item_ref_ft)(DB_playItem_t* it)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_item_unref_ft)(DB_playItem_t* it)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_item_copy_ft)(DB_playItem_t* out, DB_playItem_t* in_)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_add_files_begin_ft)(ddb_playlist_t* plt)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_add_files_end_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_get_idx_of_ft)(DB_playItem_t* it)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_get_idx_of_iter_ft)(DB_playItem_t* it, int iter)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_pl_get_for_idx_ft)(int idx)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_pl_get_for_idx_and_iter_ft)(int idx, int iter)

    ctypedef float (*_DB_functions_t_DB_functions_t_pl_get_totaltime_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_getcount_ft)(int iter)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_delete_selected_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_set_cursor_ft)(int iter, int cursor)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_get_cursor_ft)(int iter)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_crop_selected_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_getselcount_ft)()

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_pl_get_first_ft)(int iter)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_pl_get_last_ft)(int iter)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_set_selected_ft)(DB_playItem_t* it, int sel)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_is_selected_ft)(DB_playItem_t* it)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_save_current_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_save_all_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_select_all_ft)()

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_pl_get_next_ft)(DB_playItem_t* it, int iter)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_pl_get_prev_ft)(DB_playItem_t* it, int iter)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_format_title_ft)(DB_playItem_t* it, int idx, char* s, int size, int id, const char* fmt)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_format_title_escaped_ft)(DB_playItem_t* it, int idx, char* s, int size, int id, const char* fmt)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_format_time_ft)(float t, char* dur, int size)

    ctypedef ddb_playlist_t* (*_DB_functions_t_DB_functions_t_pl_get_playlist_ft)(DB_playItem_t* it)

    ctypedef DB_metaInfo_t* (*_DB_functions_t_DB_functions_t_pl_get_metadata_head_ft)(DB_playItem_t* it)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_delete_metadata_ft)(DB_playItem_t* it, DB_metaInfo_t* meta)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_add_meta_ft)(DB_playItem_t* it, const char* key, const char* value)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_append_meta_ft)(DB_playItem_t* it, const char* key, const char* value)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_set_meta_int_ft)(DB_playItem_t* it, const char* key, int value)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_set_meta_float_ft)(DB_playItem_t* it, const char* key, float value)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_delete_meta_ft)(DB_playItem_t* it, const char* key)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_pl_find_meta_ft)(DB_playItem_t* it, const char* key)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_find_meta_int_ft)(DB_playItem_t* it, const char* key, int def_)

    ctypedef float (*_DB_functions_t_DB_functions_t_pl_find_meta_float_ft)(DB_playItem_t* it, const char* key, float def_)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_replace_meta_ft)(DB_playItem_t* it, const char* key, const char* value)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_delete_all_meta_ft)(DB_playItem_t* it)

    ctypedef float (*_DB_functions_t_DB_functions_t_pl_get_item_duration_ft)(DB_playItem_t* it)

    ctypedef uint32_t (*_DB_functions_t_DB_functions_t_pl_get_item_flags_ft)(DB_playItem_t* it)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_set_item_flags_ft)(DB_playItem_t* it, uint32_t flags)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_items_copy_junk_ft)(DB_playItem_t* from_, DB_playItem_t* first, DB_playItem_t* last)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_set_item_replaygain_ft)(DB_playItem_t* it, int idx, float value)

    ctypedef float (*_DB_functions_t_DB_functions_t_pl_get_item_replaygain_ft)(DB_playItem_t* it, int idx)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_playqueue_push_ft)(DB_playItem_t* it)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_playqueue_clear_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_playqueue_pop_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_playqueue_remove_ft)(DB_playItem_t* it)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_playqueue_test_ft)(DB_playItem_t* it)

    ctypedef void (*_DB_functions_t_DB_functions_t_volume_set_db_ft)(float dB)

    ctypedef float (*_DB_functions_t_DB_functions_t_volume_get_db_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_volume_set_amp_ft)(float amp)

    ctypedef float (*_DB_functions_t_DB_functions_t_volume_get_amp_ft)()

    ctypedef float (*_DB_functions_t_DB_functions_t_volume_get_min_db_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_id3v1_read_ft)(DB_playItem_t* it, DB_FILE* fp)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_id3v1_find_ft)(DB_FILE* fp)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_id3v1_write_ft)(FILE* fp, DB_playItem_t* it, const char* enc)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_id3v2_find_ft)(DB_FILE* fp, int* psize)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_id3v2_read_ft)(DB_playItem_t* it, DB_FILE* fp)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_id3v2_read_full_ft)(DB_playItem_t* it, DB_id3v2_tag_t* tag, DB_FILE* fp)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_id3v2_convert_24_to_23_ft)(DB_id3v2_tag_t* tag24, DB_id3v2_tag_t* tag23)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_id3v2_convert_23_to_24_ft)(DB_id3v2_tag_t* tag23, DB_id3v2_tag_t* tag24)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_id3v2_convert_22_to_24_ft)(DB_id3v2_tag_t* tag22, DB_id3v2_tag_t* tag24)

    ctypedef void (*_DB_functions_t_DB_functions_t_junk_id3v2_free_ft)(DB_id3v2_tag_t* tag)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_id3v2_write_ft)(FILE* file, DB_id3v2_tag_t* tag)

    ctypedef DB_id3v2_frame_t* (*_DB_functions_t_DB_functions_t_junk_id3v2_add_text_frame_ft)(DB_id3v2_tag_t* tag, const char* frame_id, const char* value)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_id3v2_remove_frames_ft)(DB_id3v2_tag_t* tag, const char* frame_id)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_apev2_read_ft)(DB_playItem_t* it, DB_FILE* fp)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_apev2_read_mem_ft)(DB_playItem_t* it, char* mem, int size)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_apev2_read_full_ft)(DB_playItem_t* it, DB_apev2_tag_t* tag_store, DB_FILE* fp)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_apev2_read_full_mem_ft)(DB_playItem_t* it, DB_apev2_tag_t* tag_store, char* mem, int memsize)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_apev2_find_ft)(DB_FILE* fp, int32_t* psize, uint32_t* pflags, uint32_t* pnumitems)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_apev2_remove_frames_ft)(DB_apev2_tag_t* tag, const char* frame_id)

    ctypedef DB_apev2_frame_t* (*_DB_functions_t_DB_functions_t_junk_apev2_add_text_frame_ft)(DB_apev2_tag_t* tag, const char* frame_id, const char* value)

    ctypedef void (*_DB_functions_t_DB_functions_t_junk_apev2_free_ft)(DB_apev2_tag_t* tag)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_apev2_write_ft)(FILE* fp, DB_apev2_tag_t* tag, int write_header, int write_footer)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_get_leading_size_ft)(DB_FILE* fp)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_get_leading_size_stdio_ft)(FILE* fp)

    ctypedef void (*_DB_functions_t_DB_functions_t_do_not_call2_ft)(DB_playItem_t*, DB_playItem_t*, DB_playItem_t*)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_junk_detect_charset_ft)(const char* s)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_recode_ft)(const char* in_, int inlen, char* out, int outlen, const char* cs)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_iconv_ft)(const char* in_, int inlen, char* out, int outlen, const char* cs_in, const char* cs_out)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_rewrite_tags_ft)(DB_playItem_t* it, uint32_t flags, int id3v2_version, const char* id3v1_encoding)

    ctypedef DB_FILE* (*_DB_functions_t_DB_functions_t_fopen_ft)(const char* fname)

    ctypedef void (*_DB_functions_t_DB_functions_t_fclose_ft)(DB_FILE* f)

    ctypedef size_t (*_DB_functions_t_DB_functions_t_fread_ft)(void* ptr, size_t size, size_t nmemb, DB_FILE* stream)

    ctypedef int (*_DB_functions_t_DB_functions_t_fseek_ft)(DB_FILE* stream, int64_t offset, int whence)

    ctypedef int64_t (*_DB_functions_t_DB_functions_t_ftell_ft)(DB_FILE* stream)

    ctypedef void (*_DB_functions_t_DB_functions_t_rewind_ft)(DB_FILE* stream)

    ctypedef int64_t (*_DB_functions_t_DB_functions_t_fgetlength_ft)(DB_FILE* stream)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_fget_content_type_ft)(DB_FILE* stream)

    ctypedef void (*_DB_functions_t_DB_functions_t_fset_track_ft)(DB_FILE* stream, DB_playItem_t* it)

    ctypedef void (*_DB_functions_t_DB_functions_t_fabort_ft)(DB_FILE* stream)

    ctypedef int (*_DB_functions_t_DB_functions_t_sendmessage_ft)(uint32_t id, uintptr_t ctx, uint32_t p1, uint32_t p2)

    ctypedef ddb_event_t* (*_DB_functions_t_DB_functions_t_event_alloc_ft)(uint32_t id)

    ctypedef void (*_DB_functions_t_DB_functions_t_event_free_ft)(ddb_event_t* ev)

    ctypedef int (*_DB_functions_t_DB_functions_t_event_send_ft)(ddb_event_t* ev, uint32_t p1, uint32_t p2)

    ctypedef void (*_DB_functions_t_DB_functions_t_conf_lock_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_conf_unlock_ft)()

    ctypedef const char* (*_DB_functions_t_DB_functions_t_conf_get_str_fast_ft)(const char* key, const char* def_)

    ctypedef void (*_DB_functions_t_DB_functions_t_conf_get_str_ft)(const char* key, const char* def_, char* buffer, int buffer_size)

    ctypedef float (*_DB_functions_t_DB_functions_t_conf_get_float_ft)(const char* key, float def_)

    ctypedef int (*_DB_functions_t_DB_functions_t_conf_get_int_ft)(const char* key, int def_)

    ctypedef int64_t (*_DB_functions_t_DB_functions_t_conf_get_int64_ft)(const char* key, int64_t def_)

    ctypedef void (*_DB_functions_t_DB_functions_t_conf_set_str_ft)(const char* key, const char* val)

    ctypedef void (*_DB_functions_t_DB_functions_t_conf_set_int_ft)(const char* key, int val)

    ctypedef void (*_DB_functions_t_DB_functions_t_conf_set_int64_ft)(const char* key, int64_t val)

    ctypedef void (*_DB_functions_t_DB_functions_t_conf_set_float_ft)(const char* key, float val)

    ctypedef DB_conf_item_t* (*_DB_functions_t_DB_functions_t_conf_find_ft)(const char* group, DB_conf_item_t* prev)

    ctypedef void (*_DB_functions_t_DB_functions_t_conf_remove_items_ft)(const char* key)

    ctypedef int (*_DB_functions_t_DB_functions_t_conf_save_ft)()

    ctypedef DB_decoder_s** (*_DB_functions_t_DB_functions_t_plug_get_decoder_list_ft)()

    ctypedef DB_vfs_s** (*_DB_functions_t_DB_functions_t_plug_get_vfs_list_ft)()

    ctypedef DB_output_s** (*_DB_functions_t_DB_functions_t_plug_get_output_list_ft)()

    ctypedef DB_dsp_s** (*_DB_functions_t_DB_functions_t_plug_get_dsp_list_ft)()

    ctypedef DB_playlist_s** (*_DB_functions_t_DB_functions_t_plug_get_playlist_list_ft)()

    ctypedef DB_plugin_s** (*_DB_functions_t_DB_functions_t_plug_get_list_ft)()

    ctypedef const char** (*_DB_functions_t_DB_functions_t_plug_get_gui_names_ft)()

    ctypedef const char* (*_DB_functions_t_DB_functions_t_plug_get_decoder_id_ft)(const char* id)

    ctypedef void (*_DB_functions_t_DB_functions_t_plug_remove_decoder_id_ft)(const char* id)

    ctypedef DB_plugin_s* (*_DB_functions_t_DB_functions_t_plug_get_for_id_ft)(const char* id)

    ctypedef int (*_DB_functions_t_DB_functions_t_is_local_file_ft)(const char* fname)

    ctypedef int (*_DB_functions_t_DB_functions_t_pcm_convert_ft)(const ddb_waveformat_t* inputfmt, const char* input, const ddb_waveformat_t* outputfmt, char* output, int inputsize)

    ctypedef int (*_DB_functions_t_DB_functions_t_dsp_preset_load_ft)(const char* fname, ddb_dsp_context_s** head)

    ctypedef int (*_DB_functions_t_DB_functions_t_dsp_preset_save_ft)(const char* fname, ddb_dsp_context_s* head)

    ctypedef void (*_DB_functions_t_DB_functions_t_dsp_preset_free_ft)(ddb_dsp_context_s* head)

    ctypedef ddb_playlist_t* (*_DB_functions_t_DB_functions_t_plt_alloc_ft)(const char* title)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_free_ft)(ddb_playlist_t* plt)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_set_fast_mode_ft)(ddb_playlist_t* plt, int fast)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_is_fast_mode_ft)(ddb_playlist_t* plt)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_metacache_add_string_ft)(const char* str)

    ctypedef void (*_DB_functions_t_DB_functions_t_metacache_remove_string_ft)(const char* str)

    ctypedef void (*_DB_functions_t_DB_functions_t_metacache_ref_ft)(const char* str)

    ctypedef void (*_DB_functions_t_DB_functions_t_metacache_unref_ft)(const char* str)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_pl_find_meta_raw_ft)(DB_playItem_t* it, const char* key)

    ctypedef int (*_DB_functions_t_DB_functions_t_streamer_dsp_chain_save_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_get_meta_ft)(DB_playItem_t* it, const char* key, char* val, int size)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_get_meta_raw_ft)(DB_playItem_t* it, const char* key, char* val, int size)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_get_meta_ft)(ddb_playlist_t* handle, const char* key, char* val, int size)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_meta_exists_ft)(DB_playItem_t* it, const char* key)

    ctypedef void (*_DB_functions_t_DB_functions_t_vis_waveform_listen_callback_ft)(void* ctx, const ddb_audio_data_t* data)

    ctypedef void (*_DB_functions_t_DB_functions_t_vis_waveform_listen_ft)(void* ctx, _DB_functions_t_DB_functions_t_vis_waveform_listen_callback_ft callback)

    ctypedef void (*_DB_functions_t_DB_functions_t_vis_waveform_unlisten_ft)(void* ctx)

    ctypedef void (*_DB_functions_t_DB_functions_t_vis_spectrum_listen_callback_ft)(void* ctx, const ddb_audio_data_t* data)

    ctypedef void (*_DB_functions_t_DB_functions_t_vis_spectrum_listen_ft)(void* ctx, _DB_functions_t_DB_functions_t_vis_spectrum_listen_callback_ft callback)

    ctypedef void (*_DB_functions_t_DB_functions_t_vis_spectrum_unlisten_ft)(void* ctx)

    ctypedef void (*_DB_functions_t_DB_functions_t_audio_set_mute_ft)(int mute)

    ctypedef int (*_DB_functions_t_DB_functions_t_audio_is_mute_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_background_job_increment_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_background_job_decrement_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_have_background_jobs_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_get_idx_ft)(ddb_playlist_t* plt)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_save_n_ft)(int n)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_save_config_ft)(ddb_playlist_t* plt)

    ctypedef int (*_DB_functions_t_DB_functions_t_listen_file_added_callback_ft)(ddb_fileadd_data_t* data, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_listen_file_added_ft)(_DB_functions_t_DB_functions_t_listen_file_added_callback_ft callback, void* user_data)

    ctypedef void (*_DB_functions_t_DB_functions_t_unlisten_file_added_ft)(int id)

    ctypedef void (*_DB_functions_t_DB_functions_t_listen_file_add_beginend_callback_begin_ft)(ddb_fileadd_data_t* data, void* user_data)

    ctypedef void (*_DB_functions_t_DB_functions_t_listen_file_add_beginend_callback_end_ft)(ddb_fileadd_data_t* data, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_listen_file_add_beginend_ft)(_DB_functions_t_DB_functions_t_listen_file_add_beginend_callback_begin_ft callback_begin, _DB_functions_t_DB_functions_t_listen_file_add_beginend_callback_end_ft callback_end, void* user_data)

    ctypedef void (*_DB_functions_t_DB_functions_t_unlisten_file_add_beginend_ft)(int id)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_load2_callback_ft)(DB_playItem_t* it, void* user_data)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_load2_ft)(int visibility, ddb_playlist_t* plt, ddb_playItem_t* after, const char* fname, int* pabort, _DB_functions_t_DB_functions_t_plt_load2_callback_ft callback, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_add_file2_callback_ft)(DB_playItem_t* it, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_add_file2_ft)(int visibility, ddb_playlist_t* plt, const char* fname, _DB_functions_t_DB_functions_t_plt_add_file2_callback_ft callback, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_add_dir2_callback_ft)(DB_playItem_t* it, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_add_dir2_ft)(int visibility, ddb_playlist_t* plt, const char* dirname, _DB_functions_t_DB_functions_t_plt_add_dir2_callback_ft callback, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_insert_file2_callback_ft)(DB_playItem_t* it, void* user_data)

    ctypedef ddb_playItem_t* (*_DB_functions_t_DB_functions_t_plt_insert_file2_ft)(int visibility, ddb_playlist_t* playlist, ddb_playItem_t* after, const char* fname, int* pabort, _DB_functions_t_DB_functions_t_plt_insert_file2_callback_ft callback, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_insert_dir2_callback_ft)(DB_playItem_t* it, void* user_data)

    ctypedef ddb_playItem_t* (*_DB_functions_t_DB_functions_t_plt_insert_dir2_ft)(int visibility, ddb_playlist_t* plt, ddb_playItem_t* after, const char* dirname, int* pabort, _DB_functions_t_DB_functions_t_plt_insert_dir2_callback_ft callback, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_add_files_begin_ft)(ddb_playlist_t* plt, int visibility)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_add_files_end_ft)(ddb_playlist_t* plt, int visibility)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_deselect_all_ft)(ddb_playlist_t* plt)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_set_scroll_ft)(ddb_playlist_t* plt, int scroll)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_get_scroll_ft)(ddb_playlist_t* plt)

    ctypedef char* (*_DB_functions_t_DB_functions_t_tf_compile_ft)(const char* script)

    ctypedef void (*_DB_functions_t_DB_functions_t_tf_free_ft)(char* code)

    ctypedef int (*_DB_functions_t_DB_functions_t_tf_eval_ft)(ddb_tf_context_t* ctx, const char* code, char* out, int outlen)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_sort_v2_ft)(ddb_playlist_t* plt, int iter, int id, const char* format, int order)

    ctypedef int (*_DB_functions_t_DB_functions_t_playqueue_push_ft)(DB_playItem_t* it)

    ctypedef void (*_DB_functions_t_DB_functions_t_playqueue_pop_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_playqueue_remove_ft)(DB_playItem_t* it)

    ctypedef void (*_DB_functions_t_DB_functions_t_playqueue_clear_ft)()

    ctypedef int (*_DB_functions_t_DB_functions_t_playqueue_test_ft)(DB_playItem_t* it)

    ctypedef int (*_DB_functions_t_DB_functions_t_playqueue_get_count_ft)()

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_playqueue_get_item_ft)(int n)

    ctypedef int (*_DB_functions_t_DB_functions_t_playqueue_remove_nth_ft)(int n)

    ctypedef void (*_DB_functions_t_DB_functions_t_playqueue_insert_at_ft)(int n, DB_playItem_t* it)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_get_system_dir_ft)(int dir_id)

    ctypedef void (*_DB_functions_t_DB_functions_t_action_set_playlist_ft)(ddb_playlist_t* plt)

    ctypedef ddb_playlist_t* (*_DB_functions_t_DB_functions_t_action_get_playlist_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_tf_import_legacy_ft)(const char* fmt, char* out, int outsize)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_search_process2_ft)(ddb_playlist_t* plt, const char* text, int select_results)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_plt_process_cue_ft)(ddb_playlist_t* plt, DB_playItem_t* after, DB_playItem_t* it, uint64_t numsamples, int samplerate)

    ctypedef DB_metaInfo_t* (*_DB_functions_t_DB_functions_t_pl_meta_for_key_ft)(DB_playItem_t* it, const char* key)

    ctypedef void (*_DB_functions_t_DB_functions_t_log_detailed_ft)(DB_plugin_s* plugin, uint32_t layers, const char* fmt)

    ctypedef void (*_DB_functions_t_DB_functions_t_vlog_detailed_ft)(DB_plugin_s* plugin, uint32_t layer, const char* fmt, va_list ap)

    ctypedef void (*_DB_functions_t_DB_functions_t_log_ft)(const char* fmt)

    ctypedef void (*_DB_functions_t_DB_functions_t_vlog_ft)(const char* fmt, va_list ap)

    ctypedef void (*_DB_functions_t_DB_functions_t_log_viewer_register_callback_ft)(DB_plugin_s* plugin, uint32_t layers, const char* text, void* ctx)

    ctypedef void (*_DB_functions_t_DB_functions_t_log_viewer_register_ft)(_DB_functions_t_DB_functions_t_log_viewer_register_callback_ft callback, void* ctx)

    ctypedef void (*_DB_functions_t_DB_functions_t_log_viewer_unregister_callback_ft)(DB_plugin_s* plugin, uint32_t layers, const char* text, void* ctx)

    ctypedef void (*_DB_functions_t_DB_functions_t_log_viewer_unregister_ft)(_DB_functions_t_DB_functions_t_log_viewer_unregister_callback_ft callback, void* ctx)

    ctypedef int (*_DB_functions_t_DB_functions_t_register_fileadd_filter_callback_ft)(ddb_file_found_data_t* data, void* user_data)

    ctypedef int (*_DB_functions_t_DB_functions_t_register_fileadd_filter_ft)(_DB_functions_t_DB_functions_t_register_fileadd_filter_callback_ft callback, void* user_data)

    ctypedef void (*_DB_functions_t_DB_functions_t_unregister_fileadd_filter_ft)(int id)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_metacache_get_string_ft)(const char* str)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_metacache_add_value_ft)(const char* value, size_t valuesize)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_metacache_get_value_ft)(const char* value, size_t valuesize)

    ctypedef void (*_DB_functions_t_DB_functions_t_metacache_remove_value_ft)(const char* value, size_t valuesize)

    ctypedef void (*_DB_functions_t_DB_functions_t_replaygain_apply_ft)(ddb_waveformat_t* fmt, char* bytes, int numbytes)

    ctypedef void (*_DB_functions_t_DB_functions_t_replaygain_apply_with_settings_ft)(ddb_replaygain_settings_t* settings, ddb_waveformat_t* fmt, char* bytes, int numbytes)

    ctypedef void (*_DB_functions_t_DB_functions_t_replaygain_init_settings_ft)(ddb_replaygain_settings_t* settings, DB_playItem_t* it)

    ctypedef void (*_DB_functions_t_DB_functions_t_sort_track_array_ft)(ddb_playlist_t* playlist, DB_playItem_t** tracks, int num_tracks, const char* format, int order)

    ctypedef DB_playItem_t* (*_DB_functions_t_DB_functions_t_pl_item_init_ft)(const char* fname)

    ctypedef int64_t (*_DB_functions_t_DB_functions_t_pl_item_get_startsample_ft)(DB_playItem_t* it)

    ctypedef int64_t (*_DB_functions_t_DB_functions_t_pl_item_get_endsample_ft)(DB_playItem_t* it)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_item_set_startsample_ft)(DB_playItem_t* it, int64_t sample)

    ctypedef void (*_DB_functions_t_DB_functions_t_pl_item_set_endsample_ft)(DB_playItem_t* it, int64_t sample)

    ctypedef float (*_DB_functions_t_DB_functions_t_plt_get_selection_playback_time_ft)(ddb_playlist_t* plt)

    ctypedef int (*_DB_functions_t_DB_functions_t_junk_get_tail_size_ft)(DB_FILE* fp)

    ctypedef void (*_DB_functions_t_DB_functions_t_junk_get_tag_offsets_ft)(DB_FILE* fp, uint32_t* head, uint32_t* tail)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_is_loading_cue_ft)(ddb_playlist_t* plt)

    ctypedef void (*_DB_functions_t_DB_functions_t_streamer_set_shuffle_ft)(ddb_shuffle_t shuffle)

    ctypedef ddb_shuffle_t (*_DB_functions_t_DB_functions_t_streamer_get_shuffle_ft)()

    ctypedef void (*_DB_functions_t_DB_functions_t_streamer_set_repeat_ft)(ddb_repeat_t repeat)

    ctypedef ddb_repeat_t (*_DB_functions_t_DB_functions_t_streamer_get_repeat_ft)()

    ctypedef DB_metaInfo_t* (*_DB_functions_t_DB_functions_t_pl_meta_for_key_with_override_ft)(ddb_playItem_t* it, const char* key)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_pl_find_meta_with_override_ft)(DB_playItem_t* it, const char* key)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_get_meta_with_override_ft)(ddb_playItem_t* it, const char* key, char* val, size_t size)

    ctypedef int (*_DB_functions_t_DB_functions_t_pl_meta_exists_with_override_ft)(DB_playItem_t* it, const char* key)

    ctypedef void (*_DB_functions_t_DB_functions_t_plt_item_set_selected_ft)(ddb_playlist_t* plt, ddb_playItem_t* it, int sel)

    ctypedef ddb_playlist_t* (*_DB_functions_t_DB_functions_t_plt_find_by_name_ft)(const char* name)

    ctypedef ddb_playlist_t* (*_DB_functions_t_DB_functions_t_plt_append_ft)(const char* title)

    ctypedef ddb_playItem_t* (*_DB_functions_t_DB_functions_t_plt_get_head_item_ft)(ddb_playlist_t* p, int iter)

    ctypedef ddb_playItem_t* (*_DB_functions_t_DB_functions_t_plt_get_tail_item_ft)(ddb_playlist_t* p, int iter)

    ctypedef const char* (*_DB_functions_t_DB_functions_t_plug_get_path_for_plugin_ptr_ft)(DB_plugin_s* plugin_ptr)

    ctypedef void (*_DB_functions_t_DB_functions_t_vis_spectrum_listen2_callback_ft)(void* ctx, const ddb_audio_data_t* data)

    ctypedef void (*_DB_functions_t_DB_functions_t_vis_spectrum_listen2_ft)(void* ctx, _DB_functions_t_DB_functions_t_vis_spectrum_listen2_callback_ft callback)

    ctypedef int (*_DB_functions_t_DB_functions_t_plt_insert_dir3_callback_ft)(ddb_insert_file_result_t result, const char* filename, void* user_data)

    ctypedef ddb_playItem_t* (*_DB_functions_t_DB_functions_t_plt_insert_dir3_ft)(int visibility, uint32_t flags, ddb_playlist_t* plt, ddb_playItem_t* after, const char* dirname, int* pabort, _DB_functions_t_DB_functions_t_plt_insert_dir3_callback_ft callback, void* user_data)

    ctypedef ddb_playItem_t* (*_DB_functions_t_DB_functions_t_streamer_get_playing_track_safe_ft)()

    ctypedef struct DB_functions_t:
        int vmajor
        int vminor
        _DB_functions_t_DB_functions_t_md5_ft md5
        _DB_functions_t_DB_functions_t_md5_to_str_ft md5_to_str
        _DB_functions_t_DB_functions_t_md5_init_ft md5_init
        _DB_functions_t_DB_functions_t_md5_append_ft md5_append
        _DB_functions_t_DB_functions_t_md5_finish_ft md5_finish
        _DB_functions_t_DB_functions_t_get_output_ft get_output
        _DB_functions_t_DB_functions_t_playback_get_pos_ft playback_get_pos
        _DB_functions_t_DB_functions_t_playback_set_pos_ft playback_set_pos
        _DB_functions_t_DB_functions_t_streamer_get_playing_track_ft streamer_get_playing_track
        _DB_functions_t_DB_functions_t_streamer_get_streaming_track_ft streamer_get_streaming_track
        _DB_functions_t_DB_functions_t_streamer_get_playpos_ft streamer_get_playpos
        _DB_functions_t_DB_functions_t_streamer_ok_to_read_ft streamer_ok_to_read
        _DB_functions_t_DB_functions_t_streamer_reset_ft streamer_reset
        _DB_functions_t_DB_functions_t_streamer_read_ft streamer_read
        _DB_functions_t_DB_functions_t_streamer_set_bitrate_ft streamer_set_bitrate
        _DB_functions_t_DB_functions_t_streamer_get_apx_bitrate_ft streamer_get_apx_bitrate
        _DB_functions_t_DB_functions_t_streamer_get_current_fileinfo_ft streamer_get_current_fileinfo
        _DB_functions_t_DB_functions_t_streamer_get_current_playlist_ft streamer_get_current_playlist
        _DB_functions_t_DB_functions_t_streamer_get_dsp_chain_ft streamer_get_dsp_chain
        _DB_functions_t_DB_functions_t_streamer_set_dsp_chain_ft streamer_set_dsp_chain
        _DB_functions_t_DB_functions_t_streamer_dsp_refresh_ft streamer_dsp_refresh
        _DB_functions_t_DB_functions_t_get_config_dir_ft get_config_dir
        _DB_functions_t_DB_functions_t_get_prefix_ft get_prefix
        _DB_functions_t_DB_functions_t_get_doc_dir_ft get_doc_dir
        _DB_functions_t_DB_functions_t_get_plugin_dir_ft get_plugin_dir
        _DB_functions_t_DB_functions_t_get_pixmap_dir_ft get_pixmap_dir
        _DB_functions_t_DB_functions_t_do_not_call_ft do_not_call
        _DB_functions_t_DB_functions_t_thread_start_ft thread_start
        _DB_functions_t_DB_functions_t_thread_start_low_priority_ft thread_start_low_priority
        _DB_functions_t_DB_functions_t_thread_join_ft thread_join
        _DB_functions_t_DB_functions_t_thread_detach_ft thread_detach
        _DB_functions_t_DB_functions_t_thread_exit_ft thread_exit
        _DB_functions_t_DB_functions_t_mutex_create_ft mutex_create
        _DB_functions_t_DB_functions_t_mutex_create_nonrecursive_ft mutex_create_nonrecursive
        _DB_functions_t_DB_functions_t_mutex_free_ft mutex_free
        _DB_functions_t_DB_functions_t_mutex_lock_ft mutex_lock
        _DB_functions_t_DB_functions_t_mutex_unlock_ft mutex_unlock
        _DB_functions_t_DB_functions_t_cond_create_ft cond_create
        _DB_functions_t_DB_functions_t_cond_free_ft cond_free
        _DB_functions_t_DB_functions_t_cond_wait_ft cond_wait
        _DB_functions_t_DB_functions_t_cond_signal_ft cond_signal
        _DB_functions_t_DB_functions_t_cond_broadcast_ft cond_broadcast
        _DB_functions_t_DB_functions_t_plt_ref_ft plt_ref
        _DB_functions_t_DB_functions_t_plt_unref_ft plt_unref
        _DB_functions_t_DB_functions_t_plt_get_count_ft plt_get_count
        _DB_functions_t_DB_functions_t_plt_get_head_ft plt_get_head
        _DB_functions_t_DB_functions_t_plt_get_sel_count_ft plt_get_sel_count
        _DB_functions_t_DB_functions_t_plt_add_ft plt_add
        _DB_functions_t_DB_functions_t_plt_remove_ft plt_remove
        _DB_functions_t_DB_functions_t_plt_clear_ft plt_clear
        _DB_functions_t_DB_functions_t_pl_clear_ft pl_clear
        _DB_functions_t_DB_functions_t_plt_set_curr_ft plt_set_curr
        _DB_functions_t_DB_functions_t_plt_set_curr_idx_ft plt_set_curr_idx
        _DB_functions_t_DB_functions_t_plt_get_curr_ft plt_get_curr
        _DB_functions_t_DB_functions_t_plt_get_curr_idx_ft plt_get_curr_idx
        _DB_functions_t_DB_functions_t_plt_move_ft plt_move
        _DB_functions_t_DB_functions_t_plt_load_ft plt_load
        _DB_functions_t_DB_functions_t_plt_save_ft plt_save
        _DB_functions_t_DB_functions_t_plt_get_for_idx_ft plt_get_for_idx
        _DB_functions_t_DB_functions_t_plt_get_title_ft plt_get_title
        _DB_functions_t_DB_functions_t_plt_set_title_ft plt_set_title
        _DB_functions_t_DB_functions_t_plt_modified_ft plt_modified
        _DB_functions_t_DB_functions_t_plt_get_modification_idx_ft plt_get_modification_idx
        _DB_functions_t_DB_functions_t_plt_get_item_idx_ft plt_get_item_idx
        _DB_functions_t_DB_functions_t_plt_add_meta_ft plt_add_meta
        _DB_functions_t_DB_functions_t_plt_replace_meta_ft plt_replace_meta
        _DB_functions_t_DB_functions_t_plt_append_meta_ft plt_append_meta
        _DB_functions_t_DB_functions_t_plt_set_meta_int_ft plt_set_meta_int
        _DB_functions_t_DB_functions_t_plt_set_meta_float_ft plt_set_meta_float
        _DB_functions_t_DB_functions_t_plt_find_meta_ft plt_find_meta
        _DB_functions_t_DB_functions_t_plt_get_metadata_head_ft plt_get_metadata_head
        _DB_functions_t_DB_functions_t_plt_delete_metadata_ft plt_delete_metadata
        _DB_functions_t_DB_functions_t_plt_find_meta_int_ft plt_find_meta_int
        _DB_functions_t_DB_functions_t_plt_find_meta_float_ft plt_find_meta_float
        _DB_functions_t_DB_functions_t_plt_delete_all_meta_ft plt_delete_all_meta
        _DB_functions_t_DB_functions_t_plt_insert_item_ft plt_insert_item
        _DB_functions_t_DB_functions_t_plt_insert_file_ft plt_insert_file
        _DB_functions_t_DB_functions_t_plt_insert_dir_ft plt_insert_dir
        _DB_functions_t_DB_functions_t_plt_set_item_duration_ft plt_set_item_duration
        _DB_functions_t_DB_functions_t_plt_remove_item_ft plt_remove_item
        _DB_functions_t_DB_functions_t_plt_getselcount_ft plt_getselcount
        _DB_functions_t_DB_functions_t_plt_get_totaltime_ft plt_get_totaltime
        _DB_functions_t_DB_functions_t_plt_get_item_count_ft plt_get_item_count
        _DB_functions_t_DB_functions_t_plt_delete_selected_ft plt_delete_selected
        _DB_functions_t_DB_functions_t_plt_set_cursor_ft plt_set_cursor
        _DB_functions_t_DB_functions_t_plt_get_cursor_ft plt_get_cursor
        _DB_functions_t_DB_functions_t_plt_select_all_ft plt_select_all
        _DB_functions_t_DB_functions_t_plt_crop_selected_ft plt_crop_selected
        _DB_functions_t_DB_functions_t_plt_get_first_ft plt_get_first
        _DB_functions_t_DB_functions_t_plt_get_last_ft plt_get_last
        _DB_functions_t_DB_functions_t_plt_get_item_for_idx_ft plt_get_item_for_idx
        _DB_functions_t_DB_functions_t_plt_move_items_ft plt_move_items
        _DB_functions_t_DB_functions_t_plt_copy_items_ft plt_copy_items
        _DB_functions_t_DB_functions_t_plt_search_reset_ft plt_search_reset
        _DB_functions_t_DB_functions_t_plt_search_process_ft plt_search_process
        _DB_functions_t_DB_functions_t_plt_sort_ft plt_sort
        _DB_functions_t_DB_functions_t_plt_add_file_ft plt_add_file
        _DB_functions_t_DB_functions_t_plt_add_dir_ft plt_add_dir
        _DB_functions_t_DB_functions_t_plt_insert_cue_from_buffer_ft plt_insert_cue_from_buffer
        _DB_functions_t_DB_functions_t_plt_insert_cue_ft plt_insert_cue
        _DB_functions_t_DB_functions_t_pl_lock_ft pl_lock
        _DB_functions_t_DB_functions_t_pl_unlock_ft pl_unlock
        _DB_functions_t_DB_functions_t_pl_item_alloc_ft pl_item_alloc
        _DB_functions_t_DB_functions_t_pl_item_alloc_init_ft pl_item_alloc_init
        _DB_functions_t_DB_functions_t_pl_item_ref_ft pl_item_ref
        _DB_functions_t_DB_functions_t_pl_item_unref_ft pl_item_unref
        _DB_functions_t_DB_functions_t_pl_item_copy_ft pl_item_copy
        _DB_functions_t_DB_functions_t_pl_add_files_begin_ft pl_add_files_begin
        _DB_functions_t_DB_functions_t_pl_add_files_end_ft pl_add_files_end
        _DB_functions_t_DB_functions_t_pl_get_idx_of_ft pl_get_idx_of
        _DB_functions_t_DB_functions_t_pl_get_idx_of_iter_ft pl_get_idx_of_iter
        _DB_functions_t_DB_functions_t_pl_get_for_idx_ft pl_get_for_idx
        _DB_functions_t_DB_functions_t_pl_get_for_idx_and_iter_ft pl_get_for_idx_and_iter
        _DB_functions_t_DB_functions_t_pl_get_totaltime_ft pl_get_totaltime
        _DB_functions_t_DB_functions_t_pl_getcount_ft pl_getcount
        _DB_functions_t_DB_functions_t_pl_delete_selected_ft pl_delete_selected
        _DB_functions_t_DB_functions_t_pl_set_cursor_ft pl_set_cursor
        _DB_functions_t_DB_functions_t_pl_get_cursor_ft pl_get_cursor
        _DB_functions_t_DB_functions_t_pl_crop_selected_ft pl_crop_selected
        _DB_functions_t_DB_functions_t_pl_getselcount_ft pl_getselcount
        _DB_functions_t_DB_functions_t_pl_get_first_ft pl_get_first
        _DB_functions_t_DB_functions_t_pl_get_last_ft pl_get_last
        _DB_functions_t_DB_functions_t_pl_set_selected_ft pl_set_selected
        _DB_functions_t_DB_functions_t_pl_is_selected_ft pl_is_selected
        _DB_functions_t_DB_functions_t_pl_save_current_ft pl_save_current
        _DB_functions_t_DB_functions_t_pl_save_all_ft pl_save_all
        _DB_functions_t_DB_functions_t_pl_select_all_ft pl_select_all
        _DB_functions_t_DB_functions_t_pl_get_next_ft pl_get_next
        _DB_functions_t_DB_functions_t_pl_get_prev_ft pl_get_prev
        _DB_functions_t_DB_functions_t_pl_format_title_ft pl_format_title
        _DB_functions_t_DB_functions_t_pl_format_title_escaped_ft pl_format_title_escaped
        _DB_functions_t_DB_functions_t_pl_format_time_ft pl_format_time
        _DB_functions_t_DB_functions_t_pl_get_playlist_ft pl_get_playlist
        _DB_functions_t_DB_functions_t_pl_get_metadata_head_ft pl_get_metadata_head
        _DB_functions_t_DB_functions_t_pl_delete_metadata_ft pl_delete_metadata
        _DB_functions_t_DB_functions_t_pl_add_meta_ft pl_add_meta
        _DB_functions_t_DB_functions_t_pl_append_meta_ft pl_append_meta
        _DB_functions_t_DB_functions_t_pl_set_meta_int_ft pl_set_meta_int
        _DB_functions_t_DB_functions_t_pl_set_meta_float_ft pl_set_meta_float
        _DB_functions_t_DB_functions_t_pl_delete_meta_ft pl_delete_meta
        _DB_functions_t_DB_functions_t_pl_find_meta_ft pl_find_meta
        _DB_functions_t_DB_functions_t_pl_find_meta_int_ft pl_find_meta_int
        _DB_functions_t_DB_functions_t_pl_find_meta_float_ft pl_find_meta_float
        _DB_functions_t_DB_functions_t_pl_replace_meta_ft pl_replace_meta
        _DB_functions_t_DB_functions_t_pl_delete_all_meta_ft pl_delete_all_meta
        _DB_functions_t_DB_functions_t_pl_get_item_duration_ft pl_get_item_duration
        _DB_functions_t_DB_functions_t_pl_get_item_flags_ft pl_get_item_flags
        _DB_functions_t_DB_functions_t_pl_set_item_flags_ft pl_set_item_flags
        _DB_functions_t_DB_functions_t_pl_items_copy_junk_ft pl_items_copy_junk
        _DB_functions_t_DB_functions_t_pl_set_item_replaygain_ft pl_set_item_replaygain
        _DB_functions_t_DB_functions_t_pl_get_item_replaygain_ft pl_get_item_replaygain
        _DB_functions_t_DB_functions_t_pl_playqueue_push_ft pl_playqueue_push
        _DB_functions_t_DB_functions_t_pl_playqueue_clear_ft pl_playqueue_clear
        _DB_functions_t_DB_functions_t_pl_playqueue_pop_ft pl_playqueue_pop
        _DB_functions_t_DB_functions_t_pl_playqueue_remove_ft pl_playqueue_remove
        _DB_functions_t_DB_functions_t_pl_playqueue_test_ft pl_playqueue_test
        _DB_functions_t_DB_functions_t_volume_set_db_ft volume_set_db
        _DB_functions_t_DB_functions_t_volume_get_db_ft volume_get_db
        _DB_functions_t_DB_functions_t_volume_set_amp_ft volume_set_amp
        _DB_functions_t_DB_functions_t_volume_get_amp_ft volume_get_amp
        _DB_functions_t_DB_functions_t_volume_get_min_db_ft volume_get_min_db
        _DB_functions_t_DB_functions_t_junk_id3v1_read_ft junk_id3v1_read
        _DB_functions_t_DB_functions_t_junk_id3v1_find_ft junk_id3v1_find
        _DB_functions_t_DB_functions_t_junk_id3v1_write_ft junk_id3v1_write
        _DB_functions_t_DB_functions_t_junk_id3v2_find_ft junk_id3v2_find
        _DB_functions_t_DB_functions_t_junk_id3v2_read_ft junk_id3v2_read
        _DB_functions_t_DB_functions_t_junk_id3v2_read_full_ft junk_id3v2_read_full
        _DB_functions_t_DB_functions_t_junk_id3v2_convert_24_to_23_ft junk_id3v2_convert_24_to_23
        _DB_functions_t_DB_functions_t_junk_id3v2_convert_23_to_24_ft junk_id3v2_convert_23_to_24
        _DB_functions_t_DB_functions_t_junk_id3v2_convert_22_to_24_ft junk_id3v2_convert_22_to_24
        _DB_functions_t_DB_functions_t_junk_id3v2_free_ft junk_id3v2_free
        _DB_functions_t_DB_functions_t_junk_id3v2_write_ft junk_id3v2_write
        _DB_functions_t_DB_functions_t_junk_id3v2_add_text_frame_ft junk_id3v2_add_text_frame
        _DB_functions_t_DB_functions_t_junk_id3v2_remove_frames_ft junk_id3v2_remove_frames
        _DB_functions_t_DB_functions_t_junk_apev2_read_ft junk_apev2_read
        _DB_functions_t_DB_functions_t_junk_apev2_read_mem_ft junk_apev2_read_mem
        _DB_functions_t_DB_functions_t_junk_apev2_read_full_ft junk_apev2_read_full
        _DB_functions_t_DB_functions_t_junk_apev2_read_full_mem_ft junk_apev2_read_full_mem
        _DB_functions_t_DB_functions_t_junk_apev2_find_ft junk_apev2_find
        _DB_functions_t_DB_functions_t_junk_apev2_remove_frames_ft junk_apev2_remove_frames
        _DB_functions_t_DB_functions_t_junk_apev2_add_text_frame_ft junk_apev2_add_text_frame
        _DB_functions_t_DB_functions_t_junk_apev2_free_ft junk_apev2_free
        _DB_functions_t_DB_functions_t_junk_apev2_write_ft junk_apev2_write
        _DB_functions_t_DB_functions_t_junk_get_leading_size_ft junk_get_leading_size
        _DB_functions_t_DB_functions_t_junk_get_leading_size_stdio_ft junk_get_leading_size_stdio
        _DB_functions_t_DB_functions_t_do_not_call2_ft do_not_call2
        _DB_functions_t_DB_functions_t_junk_detect_charset_ft junk_detect_charset
        _DB_functions_t_DB_functions_t_junk_recode_ft junk_recode
        _DB_functions_t_DB_functions_t_junk_iconv_ft junk_iconv
        _DB_functions_t_DB_functions_t_junk_rewrite_tags_ft junk_rewrite_tags
        _DB_functions_t_DB_functions_t_fopen_ft fopen
        _DB_functions_t_DB_functions_t_fclose_ft fclose
        _DB_functions_t_DB_functions_t_fread_ft fread
        _DB_functions_t_DB_functions_t_fseek_ft fseek
        _DB_functions_t_DB_functions_t_ftell_ft ftell
        _DB_functions_t_DB_functions_t_rewind_ft rewind
        _DB_functions_t_DB_functions_t_fgetlength_ft fgetlength
        _DB_functions_t_DB_functions_t_fget_content_type_ft fget_content_type
        _DB_functions_t_DB_functions_t_fset_track_ft fset_track
        _DB_functions_t_DB_functions_t_fabort_ft fabort
        _DB_functions_t_DB_functions_t_sendmessage_ft sendmessage
        _DB_functions_t_DB_functions_t_event_alloc_ft event_alloc
        _DB_functions_t_DB_functions_t_event_free_ft event_free
        _DB_functions_t_DB_functions_t_event_send_ft event_send
        _DB_functions_t_DB_functions_t_conf_lock_ft conf_lock
        _DB_functions_t_DB_functions_t_conf_unlock_ft conf_unlock
        _DB_functions_t_DB_functions_t_conf_get_str_fast_ft conf_get_str_fast
        _DB_functions_t_DB_functions_t_conf_get_str_ft conf_get_str
        _DB_functions_t_DB_functions_t_conf_get_float_ft conf_get_float
        _DB_functions_t_DB_functions_t_conf_get_int_ft conf_get_int
        _DB_functions_t_DB_functions_t_conf_get_int64_ft conf_get_int64
        _DB_functions_t_DB_functions_t_conf_set_str_ft conf_set_str
        _DB_functions_t_DB_functions_t_conf_set_int_ft conf_set_int
        _DB_functions_t_DB_functions_t_conf_set_int64_ft conf_set_int64
        _DB_functions_t_DB_functions_t_conf_set_float_ft conf_set_float
        _DB_functions_t_DB_functions_t_conf_find_ft conf_find
        _DB_functions_t_DB_functions_t_conf_remove_items_ft conf_remove_items
        _DB_functions_t_DB_functions_t_conf_save_ft conf_save
        _DB_functions_t_DB_functions_t_plug_get_decoder_list_ft plug_get_decoder_list
        _DB_functions_t_DB_functions_t_plug_get_vfs_list_ft plug_get_vfs_list
        _DB_functions_t_DB_functions_t_plug_get_output_list_ft plug_get_output_list
        _DB_functions_t_DB_functions_t_plug_get_dsp_list_ft plug_get_dsp_list
        _DB_functions_t_DB_functions_t_plug_get_playlist_list_ft plug_get_playlist_list
        _DB_functions_t_DB_functions_t_plug_get_list_ft plug_get_list
        _DB_functions_t_DB_functions_t_plug_get_gui_names_ft plug_get_gui_names
        _DB_functions_t_DB_functions_t_plug_get_decoder_id_ft plug_get_decoder_id
        _DB_functions_t_DB_functions_t_plug_remove_decoder_id_ft plug_remove_decoder_id
        _DB_functions_t_DB_functions_t_plug_get_for_id_ft plug_get_for_id
        _DB_functions_t_DB_functions_t_is_local_file_ft is_local_file
        _DB_functions_t_DB_functions_t_pcm_convert_ft pcm_convert
        _DB_functions_t_DB_functions_t_dsp_preset_load_ft dsp_preset_load
        _DB_functions_t_DB_functions_t_dsp_preset_save_ft dsp_preset_save
        _DB_functions_t_DB_functions_t_dsp_preset_free_ft dsp_preset_free
        _DB_functions_t_DB_functions_t_plt_alloc_ft plt_alloc
        _DB_functions_t_DB_functions_t_plt_free_ft plt_free
        _DB_functions_t_DB_functions_t_plt_set_fast_mode_ft plt_set_fast_mode
        _DB_functions_t_DB_functions_t_plt_is_fast_mode_ft plt_is_fast_mode
        _DB_functions_t_DB_functions_t_metacache_add_string_ft metacache_add_string
        _DB_functions_t_DB_functions_t_metacache_remove_string_ft metacache_remove_string
        _DB_functions_t_DB_functions_t_metacache_ref_ft metacache_ref
        _DB_functions_t_DB_functions_t_metacache_unref_ft metacache_unref
        _DB_functions_t_DB_functions_t_pl_find_meta_raw_ft pl_find_meta_raw
        _DB_functions_t_DB_functions_t_streamer_dsp_chain_save_ft streamer_dsp_chain_save
        _DB_functions_t_DB_functions_t_pl_get_meta_ft pl_get_meta
        _DB_functions_t_DB_functions_t_pl_get_meta_raw_ft pl_get_meta_raw
        _DB_functions_t_DB_functions_t_plt_get_meta_ft plt_get_meta
        _DB_functions_t_DB_functions_t_pl_meta_exists_ft pl_meta_exists
        _DB_functions_t_DB_functions_t_vis_waveform_listen_ft vis_waveform_listen
        _DB_functions_t_DB_functions_t_vis_waveform_unlisten_ft vis_waveform_unlisten
        _DB_functions_t_DB_functions_t_vis_spectrum_listen_ft vis_spectrum_listen
        _DB_functions_t_DB_functions_t_vis_spectrum_unlisten_ft vis_spectrum_unlisten
        _DB_functions_t_DB_functions_t_audio_set_mute_ft audio_set_mute
        _DB_functions_t_DB_functions_t_audio_is_mute_ft audio_is_mute
        _DB_functions_t_DB_functions_t_background_job_increment_ft background_job_increment
        _DB_functions_t_DB_functions_t_background_job_decrement_ft background_job_decrement
        _DB_functions_t_DB_functions_t_have_background_jobs_ft have_background_jobs
        _DB_functions_t_DB_functions_t_plt_get_idx_ft plt_get_idx
        _DB_functions_t_DB_functions_t_plt_save_n_ft plt_save_n
        _DB_functions_t_DB_functions_t_plt_save_config_ft plt_save_config
        _DB_functions_t_DB_functions_t_listen_file_added_ft listen_file_added
        _DB_functions_t_DB_functions_t_unlisten_file_added_ft unlisten_file_added
        _DB_functions_t_DB_functions_t_listen_file_add_beginend_ft listen_file_add_beginend
        _DB_functions_t_DB_functions_t_unlisten_file_add_beginend_ft unlisten_file_add_beginend
        _DB_functions_t_DB_functions_t_plt_load2_ft plt_load2
        _DB_functions_t_DB_functions_t_plt_add_file2_ft plt_add_file2
        _DB_functions_t_DB_functions_t_plt_add_dir2_ft plt_add_dir2
        _DB_functions_t_DB_functions_t_plt_insert_file2_ft plt_insert_file2
        _DB_functions_t_DB_functions_t_plt_insert_dir2_ft plt_insert_dir2
        _DB_functions_t_DB_functions_t_plt_add_files_begin_ft plt_add_files_begin
        _DB_functions_t_DB_functions_t_plt_add_files_end_ft plt_add_files_end
        _DB_functions_t_DB_functions_t_plt_deselect_all_ft plt_deselect_all
        _DB_functions_t_DB_functions_t_plt_set_scroll_ft plt_set_scroll
        _DB_functions_t_DB_functions_t_plt_get_scroll_ft plt_get_scroll
        _DB_functions_t_DB_functions_t_tf_compile_ft tf_compile
        _DB_functions_t_DB_functions_t_tf_free_ft tf_free
        _DB_functions_t_DB_functions_t_tf_eval_ft tf_eval
        _DB_functions_t_DB_functions_t_plt_sort_v2_ft plt_sort_v2
        _DB_functions_t_DB_functions_t_playqueue_push_ft playqueue_push
        _DB_functions_t_DB_functions_t_playqueue_pop_ft playqueue_pop
        _DB_functions_t_DB_functions_t_playqueue_remove_ft playqueue_remove
        _DB_functions_t_DB_functions_t_playqueue_clear_ft playqueue_clear
        _DB_functions_t_DB_functions_t_playqueue_test_ft playqueue_test
        _DB_functions_t_DB_functions_t_playqueue_get_count_ft playqueue_get_count
        _DB_functions_t_DB_functions_t_playqueue_get_item_ft playqueue_get_item
        _DB_functions_t_DB_functions_t_playqueue_remove_nth_ft playqueue_remove_nth
        _DB_functions_t_DB_functions_t_playqueue_insert_at_ft playqueue_insert_at
        _DB_functions_t_DB_functions_t_get_system_dir_ft get_system_dir
        _DB_functions_t_DB_functions_t_action_set_playlist_ft action_set_playlist
        _DB_functions_t_DB_functions_t_action_get_playlist_ft action_get_playlist
        _DB_functions_t_DB_functions_t_tf_import_legacy_ft tf_import_legacy
        _DB_functions_t_DB_functions_t_plt_search_process2_ft plt_search_process2
        _DB_functions_t_DB_functions_t_plt_process_cue_ft plt_process_cue
        _DB_functions_t_DB_functions_t_pl_meta_for_key_ft pl_meta_for_key
        _DB_functions_t_DB_functions_t_log_detailed_ft log_detailed
        _DB_functions_t_DB_functions_t_vlog_detailed_ft vlog_detailed
        _DB_functions_t_DB_functions_t_log_ft log
        _DB_functions_t_DB_functions_t_vlog_ft vlog
        _DB_functions_t_DB_functions_t_log_viewer_register_ft log_viewer_register
        _DB_functions_t_DB_functions_t_log_viewer_unregister_ft log_viewer_unregister
        _DB_functions_t_DB_functions_t_register_fileadd_filter_ft register_fileadd_filter
        _DB_functions_t_DB_functions_t_unregister_fileadd_filter_ft unregister_fileadd_filter
        _DB_functions_t_DB_functions_t_metacache_get_string_ft metacache_get_string
        _DB_functions_t_DB_functions_t_metacache_add_value_ft metacache_add_value
        _DB_functions_t_DB_functions_t_metacache_get_value_ft metacache_get_value
        _DB_functions_t_DB_functions_t_metacache_remove_value_ft metacache_remove_value
        _DB_functions_t_DB_functions_t_replaygain_apply_ft replaygain_apply
        _DB_functions_t_DB_functions_t_replaygain_apply_with_settings_ft replaygain_apply_with_settings
        _DB_functions_t_DB_functions_t_replaygain_init_settings_ft replaygain_init_settings
        _DB_functions_t_DB_functions_t_sort_track_array_ft sort_track_array
        _DB_functions_t_DB_functions_t_pl_item_init_ft pl_item_init
        _DB_functions_t_DB_functions_t_pl_item_get_startsample_ft pl_item_get_startsample
        _DB_functions_t_DB_functions_t_pl_item_get_endsample_ft pl_item_get_endsample
        _DB_functions_t_DB_functions_t_pl_item_set_startsample_ft pl_item_set_startsample
        _DB_functions_t_DB_functions_t_pl_item_set_endsample_ft pl_item_set_endsample
        _DB_functions_t_DB_functions_t_plt_get_selection_playback_time_ft plt_get_selection_playback_time
        _DB_functions_t_DB_functions_t_junk_get_tail_size_ft junk_get_tail_size
        _DB_functions_t_DB_functions_t_junk_get_tag_offsets_ft junk_get_tag_offsets
        _DB_functions_t_DB_functions_t_plt_is_loading_cue_ft plt_is_loading_cue
        _DB_functions_t_DB_functions_t_streamer_set_shuffle_ft streamer_set_shuffle
        _DB_functions_t_DB_functions_t_streamer_get_shuffle_ft streamer_get_shuffle
        _DB_functions_t_DB_functions_t_streamer_set_repeat_ft streamer_set_repeat
        _DB_functions_t_DB_functions_t_streamer_get_repeat_ft streamer_get_repeat
        _DB_functions_t_DB_functions_t_pl_meta_for_key_with_override_ft pl_meta_for_key_with_override
        _DB_functions_t_DB_functions_t_pl_find_meta_with_override_ft pl_find_meta_with_override
        _DB_functions_t_DB_functions_t_pl_get_meta_with_override_ft pl_get_meta_with_override
        _DB_functions_t_DB_functions_t_pl_meta_exists_with_override_ft pl_meta_exists_with_override
        _DB_functions_t_DB_functions_t_plt_item_set_selected_ft plt_item_set_selected
        _DB_functions_t_DB_functions_t_plt_find_by_name_ft plt_find_by_name
        _DB_functions_t_DB_functions_t_plt_append_ft plt_append
        _DB_functions_t_DB_functions_t_plt_get_head_item_ft plt_get_head_item
        _DB_functions_t_DB_functions_t_plt_get_tail_item_ft plt_get_tail_item
        _DB_functions_t_DB_functions_t_plug_get_path_for_plugin_ptr_ft plug_get_path_for_plugin_ptr
        _DB_functions_t_DB_functions_t_vis_spectrum_listen2_ft vis_spectrum_listen2
        _DB_functions_t_DB_functions_t_plt_insert_dir3_ft plt_insert_dir3
        _DB_functions_t_DB_functions_t_streamer_get_playing_track_safe_ft streamer_get_playing_track_safe

    cpdef enum:
        DB_ACTION_COMMON
        DB_ACTION_SINGLE_TRACK
        DB_ACTION_MULTIPLE_TRACKS
        DB_ACTION_ALLOW_MULTIPLE_TRACKS
        DB_ACTION_CAN_MULTIPLE_TRACKS
        DB_ACTION_DISABLED
        DB_ACTION_PLAYLIST
        DB_ACTION_ADD_MENU
        DB_ACTION_EXCLUDE_FROM_CTX_PLAYLIST

    cpdef enum ddb_action_context_e:
        DDB_ACTION_CTX_MAIN
        DDB_ACTION_CTX_SELECTION
        DDB_ACTION_CTX_PLAYLIST
        DDB_ACTION_CTX_NOWPLAYING
        DDB_ACTION_CTX_COUNT

    ctypedef ddb_action_context_e ddb_action_context_t

    cdef struct DB_plugin_action_s

    ctypedef int (*DB_plugin_action_callback_t)(DB_plugin_action_s* action, void* userdata)

    ctypedef int (*DB_plugin_action_callback2_t)(DB_plugin_action_s* action, ddb_action_context_t ctx)

    cdef struct DB_plugin_action_s:
        const char* title
        const char* name
        uint32_t flags
        DB_plugin_action_callback_t callback
        DB_plugin_action_s* next
        DB_plugin_action_callback2_t callback2

    ctypedef DB_plugin_action_s DB_plugin_action_t

    cpdef enum:
        DDB_PLUGIN_FLAG_LOGGING
        DDB_PLUGIN_FLAG_REPLAYGAIN
        DDB_PLUGIN_FLAG_IMPLEMENTS_DECODER2
        DDB_PLUGIN_FLAG_ASYNC_STOP

    cpdef enum:
        DDB_COMMAND_PLUGIN_ASYNC_STOP

    ctypedef int (*_ddb_response_t_ddb_response_t_ddb_response_s_append_ft)(ddb_response_s* response, char* bytes, size_t size)

    cdef struct ddb_response_s:
        size_t _size
        _ddb_response_t_ddb_response_t_ddb_response_s_append_ft append

    ctypedef ddb_response_s ddb_response_t

    ctypedef int (*_DB_plugin_t_DB_plugin_t_DB_plugin_s_command_ft)(int cmd)

    ctypedef int (*_DB_plugin_t_DB_plugin_t_DB_plugin_s_start_ft)()

    ctypedef int (*_DB_plugin_t_DB_plugin_t_DB_plugin_s_stop_ft)()

    ctypedef int (*_DB_plugin_t_DB_plugin_t_DB_plugin_s_connect_ft)()

    ctypedef int (*_DB_plugin_t_DB_plugin_t_DB_plugin_s_disconnect_ft)()

    ctypedef int (*_DB_plugin_t_DB_plugin_t_DB_plugin_s_exec_cmdline_ft)(const char* cmdline, int cmdline_size, ddb_response_t* response)

    ctypedef DB_plugin_action_t* (*_DB_plugin_t_DB_plugin_t_DB_plugin_s_get_actions_ft)(DB_playItem_t* it)

    ctypedef int (*_DB_plugin_t_DB_plugin_t_DB_plugin_s_message_ft)(uint32_t id, uintptr_t ctx, uint32_t p1, uint32_t p2)

    cdef struct DB_plugin_s:
        int32_t type
        int16_t api_vmajor
        int16_t api_vminor
        int16_t version_major
        int16_t version_minor
        uint32_t flags
        uint32_t reserved1
        uint32_t reserved2
        uint32_t reserved3
        const char* id
        const char* name
        const char* descr
        const char* copyright
        const char* website
        _DB_plugin_t_DB_plugin_t_DB_plugin_s_command_ft command
        _DB_plugin_t_DB_plugin_t_DB_plugin_s_start_ft start
        _DB_plugin_t_DB_plugin_t_DB_plugin_s_stop_ft stop
        _DB_plugin_t_DB_plugin_t_DB_plugin_s_connect_ft connect
        _DB_plugin_t_DB_plugin_t_DB_plugin_s_disconnect_ft disconnect
        _DB_plugin_t_DB_plugin_t_DB_plugin_s_exec_cmdline_ft exec_cmdline
        _DB_plugin_t_DB_plugin_t_DB_plugin_s_get_actions_ft get_actions
        _DB_plugin_t_DB_plugin_t_DB_plugin_s_message_ft message
        const char* configdialog

    ctypedef DB_plugin_s DB_plugin_t

    cpdef enum:
        DDB_SPEAKER_FRONT_LEFT
        DDB_SPEAKER_FRONT_RIGHT
        DDB_SPEAKER_FRONT_CENTER
        DDB_SPEAKER_LOW_FREQUENCY
        DDB_SPEAKER_BACK_LEFT
        DDB_SPEAKER_BACK_RIGHT
        DDB_SPEAKER_FRONT_LEFT_OF_CENTER
        DDB_SPEAKER_FRONT_RIGHT_OF_CENTER
        DDB_SPEAKER_BACK_CENTER
        DDB_SPEAKER_SIDE_LEFT
        DDB_SPEAKER_SIDE_RIGHT
        DDB_SPEAKER_TOP_CENTER
        DDB_SPEAKER_TOP_FRONT_LEFT
        DDB_SPEAKER_TOP_FRONT_CENTER
        DDB_SPEAKER_TOP_FRONT_RIGHT
        DDB_SPEAKER_TOP_BACK_LEFT
        DDB_SPEAKER_TOP_BACK_CENTER
        DDB_SPEAKER_TOP_BACK_RIGHT

    cdef struct DB_fileinfo_s:
        DB_decoder_s* plugin
        ddb_waveformat_t fmt
        float readpos
        DB_FILE* file

    ctypedef DB_fileinfo_s DB_fileinfo_t

    cpdef enum:
        DDB_DECODER_HINT_16BIT
        DDB_DECODER_HINT_NEED_BITRATE
        DDB_DECODER_HINT_CAN_LOOP
        DDB_DECODER_HINT_RAW_SIGNAL

    ctypedef DB_fileinfo_t* (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_open_ft)(uint32_t hints)

    ctypedef int (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_init_ft)(DB_fileinfo_t* info, DB_playItem_t* it)

    ctypedef void (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_free_ft)(DB_fileinfo_t* info)

    ctypedef int (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_read_ft)(DB_fileinfo_t* info, char* buffer, int nbytes)

    ctypedef int (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_seek_ft)(DB_fileinfo_t* info, float seconds)

    ctypedef int (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_seek_sample_ft)(DB_fileinfo_t* info, int sample)

    ctypedef DB_playItem_t* (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_insert_ft)(ddb_playlist_t* plt, DB_playItem_t* after, const char* fname)

    ctypedef int (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_numvoices_ft)(DB_fileinfo_t* info)

    ctypedef void (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_mutevoice_ft)(DB_fileinfo_t* info, int voice, int mute)

    ctypedef int (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_read_metadata_ft)(DB_playItem_t* it)

    ctypedef int (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_write_metadata_ft)(DB_playItem_t* it)

    ctypedef DB_fileinfo_t* (*_DB_decoder_t_DB_decoder_t_DB_decoder_s_open2_ft)(uint32_t hints, DB_playItem_t* it)

    cdef struct DB_decoder_s:
        DB_plugin_t plugin
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_open_ft open
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_init_ft init
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_free_ft free
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_read_ft read
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_seek_ft seek
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_seek_sample_ft seek_sample
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_insert_ft insert
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_numvoices_ft numvoices
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_mutevoice_ft mutevoice
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_read_metadata_ft read_metadata
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_write_metadata_ft write_metadata
        const char** exts
        const char** prefixes
        _DB_decoder_t_DB_decoder_t_DB_decoder_s_open2_ft open2

    ctypedef DB_decoder_s DB_decoder_t

    ctypedef int (*_ddb_decoder2_t_ddb_decoder2_t_ddb_decoder2_s_seek_sample64_ft)(DB_fileinfo_t* info, int64_t sample)

    cdef struct ddb_decoder2_s:
        DB_decoder_t decoder
        _ddb_decoder2_t_ddb_decoder2_t_ddb_decoder2_s_seek_sample64_ft seek_sample64
        void* padding[8]

    ctypedef ddb_decoder2_s ddb_decoder2_t

    ctypedef int (*_DB_output_t_DB_output_t_DB_output_s_init_ft)()

    ctypedef int (*_DB_output_t_DB_output_t_DB_output_s_free_ft)()

    ctypedef int (*_DB_output_t_DB_output_t_DB_output_s_setformat_ft)(ddb_waveformat_t* fmt)

    ctypedef int (*_DB_output_t_DB_output_t_DB_output_s_play_ft)()

    ctypedef int (*_DB_output_t_DB_output_t_DB_output_s_stop_ft)()

    ctypedef int (*_DB_output_t_DB_output_t_DB_output_s_pause_ft)()

    ctypedef int (*_DB_output_t_DB_output_t_DB_output_s_unpause_ft)()

    ctypedef ddb_playback_state_t (*_DB_output_t_DB_output_t_DB_output_s_state_ft)()

    ctypedef void (*_DB_output_t_DB_output_t_DB_output_s_enum_soundcards_callback_ft)(const char* name, const char* desc, void*)

    ctypedef void (*_DB_output_t_DB_output_t_DB_output_s_enum_soundcards_ft)(_DB_output_t_DB_output_t_DB_output_s_enum_soundcards_callback_ft callback, void* userdata)

    cdef struct DB_output_s:
        DB_plugin_t plugin
        _DB_output_t_DB_output_t_DB_output_s_init_ft init
        _DB_output_t_DB_output_t_DB_output_s_free_ft free
        _DB_output_t_DB_output_t_DB_output_s_setformat_ft setformat
        _DB_output_t_DB_output_t_DB_output_s_play_ft play
        _DB_output_t_DB_output_t_DB_output_s_stop_ft stop
        _DB_output_t_DB_output_t_DB_output_s_pause_ft pause
        _DB_output_t_DB_output_t_DB_output_s_unpause_ft unpause
        _DB_output_t_DB_output_t_DB_output_s_state_ft state
        _DB_output_t_DB_output_t_DB_output_s_enum_soundcards_ft enum_soundcards
        ddb_waveformat_t fmt
        int has_volume

    ctypedef DB_output_s DB_output_t

    cdef struct ddb_dsp_context_s:
        DB_dsp_s* plugin
        ddb_dsp_context_s* next
        unsigned enabled

    ctypedef ddb_dsp_context_s ddb_dsp_context_t

    ctypedef ddb_dsp_context_t* (*_DB_dsp_t_DB_dsp_t_DB_dsp_s_open_ft)()

    ctypedef void (*_DB_dsp_t_DB_dsp_t_DB_dsp_s_close_ft)(ddb_dsp_context_t* ctx)

    ctypedef int (*_DB_dsp_t_DB_dsp_t_DB_dsp_s_process_ft)(ddb_dsp_context_t* ctx, float* samples, int frames, int maxframes, ddb_waveformat_t* fmt, float* ratio)

    ctypedef void (*_DB_dsp_t_DB_dsp_t_DB_dsp_s_reset_ft)(ddb_dsp_context_t* ctx)

    ctypedef int (*_DB_dsp_t_DB_dsp_t_DB_dsp_s_num_params_ft)()

    ctypedef const char* (*_DB_dsp_t_DB_dsp_t_DB_dsp_s_get_param_name_ft)(int p)

    ctypedef void (*_DB_dsp_t_DB_dsp_t_DB_dsp_s_set_param_ft)(ddb_dsp_context_t* ctx, int p, const char* val)

    ctypedef void (*_DB_dsp_t_DB_dsp_t_DB_dsp_s_get_param_ft)(ddb_dsp_context_t* ctx, int p, char* str, int len)

    ctypedef int (*_DB_dsp_t_DB_dsp_t_DB_dsp_s_can_bypass_ft)(ddb_dsp_context_t* ctx, ddb_waveformat_t* fmt)

    cdef struct DB_dsp_s:
        DB_plugin_t plugin
        _DB_dsp_t_DB_dsp_t_DB_dsp_s_open_ft open
        _DB_dsp_t_DB_dsp_t_DB_dsp_s_close_ft close
        _DB_dsp_t_DB_dsp_t_DB_dsp_s_process_ft process
        _DB_dsp_t_DB_dsp_t_DB_dsp_s_reset_ft reset
        _DB_dsp_t_DB_dsp_t_DB_dsp_s_num_params_ft num_params
        _DB_dsp_t_DB_dsp_t_DB_dsp_s_get_param_name_ft get_param_name
        _DB_dsp_t_DB_dsp_t_DB_dsp_s_set_param_ft set_param
        _DB_dsp_t_DB_dsp_t_DB_dsp_s_get_param_ft get_param
        const char* configdialog
        _DB_dsp_t_DB_dsp_t_DB_dsp_s_can_bypass_ft can_bypass

    ctypedef DB_dsp_s DB_dsp_t

    ctypedef struct DB_misc_t:
        DB_plugin_t plugin

    ctypedef const char** (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_get_schemes_ft)()

    ctypedef int (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_is_streaming_ft)()

    ctypedef int (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_is_container_ft)(const char* fname)

    ctypedef void (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_abort_ft)(DB_FILE* stream)

    ctypedef DB_FILE* (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_open_ft)(const char* fname)

    ctypedef void (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_close_ft)(DB_FILE* f)

    ctypedef size_t (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_read_ft)(void* ptr, size_t size, size_t nmemb, DB_FILE* stream)

    ctypedef int (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_seek_ft)(DB_FILE* stream, int64_t offset, int whence)

    ctypedef int64_t (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_tell_ft)(DB_FILE* stream)

    ctypedef void (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_rewind_ft)(DB_FILE* stream)

    ctypedef int64_t (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_getlength_ft)(DB_FILE* stream)

    ctypedef const char* (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_get_content_type_ft)(DB_FILE* stream)

    ctypedef void (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_set_track_ft)(DB_FILE* f, DB_playItem_t* it)

    ctypedef int (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_scandir_selector_ft)(const dirent*)

    ctypedef int (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_scandir_cmp_ft)(const dirent**, const dirent**)

    ctypedef int (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_scandir_ft)(const char* dir, dirent*** namelist, _DB_vfs_t_DB_vfs_t_DB_vfs_s_scandir_selector_ft selector, _DB_vfs_t_DB_vfs_t_DB_vfs_s_scandir_cmp_ft cmp)

    ctypedef const char* (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_get_scheme_for_name_ft)(const char* fname)

    ctypedef uint64_t (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_get_identifier_ft)(DB_FILE* f)

    ctypedef void (*_DB_vfs_t_DB_vfs_t_DB_vfs_s_abort_with_identifier_ft)(uint64_t identifier)

    cdef struct DB_vfs_s:
        DB_plugin_t plugin
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_get_schemes_ft get_schemes
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_is_streaming_ft is_streaming
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_is_container_ft is_container
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_abort_ft abort
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_open_ft open
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_close_ft close
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_read_ft read
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_seek_ft seek
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_tell_ft tell
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_rewind_ft rewind
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_getlength_ft getlength
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_get_content_type_ft get_content_type
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_set_track_ft set_track
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_scandir_ft scandir
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_get_scheme_for_name_ft get_scheme_for_name
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_get_identifier_ft get_identifier
        _DB_vfs_t_DB_vfs_t_DB_vfs_s_abort_with_identifier_ft abort_with_identifier

    ctypedef DB_vfs_s DB_vfs_t

    ctypedef void (*_ddb_dialog_t_ddb_dialog_t_set_param_ft)(const char* key, const char* value)

    ctypedef void (*_ddb_dialog_t_ddb_dialog_t_get_param_ft)(const char* key, char* value, int len, const char* def_)

    ctypedef struct ddb_dialog_t:
        const char* title
        const char* layout
        _ddb_dialog_t_ddb_dialog_t_set_param_ft set_param
        _ddb_dialog_t_ddb_dialog_t_get_param_ft get_param
        void* parent

    cpdef enum:
        ddb_button_ok
        ddb_button_cancel
        ddb_button_close
        ddb_button_apply
        ddb_button_yes
        ddb_button_no
        ddb_button_max

    ctypedef int (*_DB_gui_t_DB_gui_t_DB_gui_s_run_dialog_callback_ft)(int button, void* ctx)

    ctypedef int (*_DB_gui_t_DB_gui_t_DB_gui_s_run_dialog_ft)(ddb_dialog_t* dlg, uint32_t buttons, _DB_gui_t_DB_gui_t_DB_gui_s_run_dialog_callback_ft callback, void* ctx)

    cdef struct DB_gui_s:
        DB_plugin_t plugin
        _DB_gui_t_DB_gui_t_DB_gui_s_run_dialog_ft run_dialog

    ctypedef DB_gui_s DB_gui_t

    ctypedef int (*_DB_playlist_t_DB_playlist_t_DB_playlist_s_load_cb_ft)(DB_playItem_t* it, void* data)

    ctypedef DB_playItem_t* (*_DB_playlist_t_DB_playlist_t_DB_playlist_s_load_ft)(ddb_playlist_t* plt, DB_playItem_t* after, const char* fname, int* pabort, _DB_playlist_t_DB_playlist_t_DB_playlist_s_load_cb_ft cb, void* user_data)

    ctypedef int (*_DB_playlist_t_DB_playlist_t_DB_playlist_s_save_ft)(ddb_playlist_t* plt, const char* fname, DB_playItem_t* first, DB_playItem_t* last)

    ctypedef DB_playItem_t* (*_DB_playlist_t_DB_playlist_t_DB_playlist_s_load2_ft)(int visibility, ddb_playlist_t* plt, DB_playItem_t* after, const char* fname, int* pabort)

    cdef struct DB_playlist_s:
        DB_plugin_t plugin
        _DB_playlist_t_DB_playlist_t_DB_playlist_s_load_ft load
        _DB_playlist_t_DB_playlist_t_DB_playlist_s_save_ft save
        const char** extensions
        _DB_playlist_t_DB_playlist_t_DB_playlist_s_load2_ft load2

    ctypedef DB_playlist_s DB_playlist_t

    ctypedef enum ddb_mediasource_event_type_t:
        DDB_MEDIASOURCE_EVENT_CONTENT_DID_CHANGE
        DDB_MEDIASOURCE_EVENT_STATE_DID_CHANGE
        DDB_MEDIASOURCE_EVENT_ENABLED_DID_CHANGE
        DDB_MEDIASOURCE_EVENT_OUT_OF_SYNC

    ctypedef enum ddb_mediasource_state_t:
        DDB_MEDIASOURCE_STATE_IDLE
        DDB_MEDIASOURCE_STATE_LOADING
        DDB_MEDIASOURCE_STATE_SCANNING
        DDB_MEDIASOURCE_STATE_INDEXING
        DDB_MEDIASOURCE_STATE_SAVING

    ctypedef void (*ddb_medialib_listener_t)(ddb_mediasource_event_type_t event, void* user_data)

    cdef struct ddb_mediasource_source_t

    cdef struct ddb_mediasource_api_s #### CUST

    ctypedef ddb_mediasource_api_s ddb_mediasource_api_t

    cdef struct ddb_medialib_item_s #### CUST

    ctypedef ddb_medialib_item_s ddb_medialib_item_t

    ctypedef ddb_mediasource_api_t* (*_DB_mediasource_t_DB_mediasource_t_get_extended_api_ft)()

    ctypedef const char* (*_DB_mediasource_t_DB_mediasource_t_source_name_ft)()

    ctypedef ddb_mediasource_source_t* (*_DB_mediasource_t_DB_mediasource_t_create_source_ft)(const char* source_path)

    ctypedef void (*_DB_mediasource_t_DB_mediasource_t_free_source_ft)(ddb_mediasource_source_t* source)

    ctypedef void (*_DB_mediasource_t_DB_mediasource_t_set_source_enabled_ft)(ddb_mediasource_source_t* source, int enabled)

    ctypedef int (*_DB_mediasource_t_DB_mediasource_t_is_source_enabled_ft)(ddb_mediasource_source_t* source)

    ctypedef void (*_DB_mediasource_t_DB_mediasource_t_refresh_ft)(ddb_mediasource_source_t* source)

    ctypedef int (*_DB_mediasource_t_DB_mediasource_t_add_listener_ft)(ddb_mediasource_source_t* source, ddb_medialib_listener_t listener, void* user_data)

    ctypedef void (*_DB_mediasource_t_DB_mediasource_t_remove_listener_ft)(ddb_mediasource_source_t* source, int listener_id)

    ctypedef ddb_medialib_item_t* (*_DB_mediasource_t_DB_mediasource_t_create_item_tree_ft)(ddb_mediasource_source_t* source, ddb_scriptable_item_t* preset, const char* filter)

    ctypedef void (*_DB_mediasource_t_DB_mediasource_t_free_item_tree_ft)(ddb_mediasource_source_t* source, ddb_medialib_item_t* list)

    ctypedef ddb_mediasource_state_t (*_DB_mediasource_t_DB_mediasource_t_scanner_state_ft)(ddb_mediasource_source_t* source)

    ctypedef ddb_scriptable_item_t* (*_DB_mediasource_t_DB_mediasource_t_get_queries_scriptable_ft)(ddb_mediasource_source_t* source)

    ctypedef ddb_medialib_item_t* (*_DB_mediasource_t_DB_mediasource_t_get_tree_item_parent_ft)(ddb_medialib_item_t* item)

    ctypedef int (*_DB_mediasource_t_DB_mediasource_t_is_tree_item_selected_ft)(ddb_mediasource_source_t* source, const ddb_medialib_item_t* item)

    ctypedef void (*_DB_mediasource_t_DB_mediasource_t_set_tree_item_selected_ft)(ddb_mediasource_source_t* source, const ddb_medialib_item_t* item, int selected)

    ctypedef int (*_DB_mediasource_t_DB_mediasource_t_is_tree_item_expanded_ft)(ddb_mediasource_source_t* source, const ddb_medialib_item_t* item)

    ctypedef void (*_DB_mediasource_t_DB_mediasource_t_set_tree_item_expanded_ft)(ddb_mediasource_source_t* source, const ddb_medialib_item_t* item, int expanded)

    ctypedef const char* (*_DB_mediasource_t_DB_mediasource_t_tree_item_get_text_ft)(const ddb_medialib_item_t* item)

    ctypedef ddb_playItem_t* (*_DB_mediasource_t_DB_mediasource_t_tree_item_get_track_ft)(const ddb_medialib_item_t* item)

    ctypedef const ddb_medialib_item_t* (*_DB_mediasource_t_DB_mediasource_t_tree_item_get_next_ft)(const ddb_medialib_item_t* item)

    ctypedef const ddb_medialib_item_t* (*_DB_mediasource_t_DB_mediasource_t_tree_item_get_children_ft)(const ddb_medialib_item_t* item)

    ctypedef int (*_DB_mediasource_t_DB_mediasource_t_tree_item_get_children_count_ft)(const ddb_medialib_item_t* item)

    ctypedef struct DB_mediasource_t:
        DB_plugin_t plugin
        _DB_mediasource_t_DB_mediasource_t_get_extended_api_ft get_extended_api
        _DB_mediasource_t_DB_mediasource_t_source_name_ft source_name
        _DB_mediasource_t_DB_mediasource_t_create_source_ft create_source
        _DB_mediasource_t_DB_mediasource_t_free_source_ft free_source
        _DB_mediasource_t_DB_mediasource_t_set_source_enabled_ft set_source_enabled
        _DB_mediasource_t_DB_mediasource_t_is_source_enabled_ft is_source_enabled
        _DB_mediasource_t_DB_mediasource_t_refresh_ft refresh
        _DB_mediasource_t_DB_mediasource_t_add_listener_ft add_listener
        _DB_mediasource_t_DB_mediasource_t_remove_listener_ft remove_listener
        _DB_mediasource_t_DB_mediasource_t_create_item_tree_ft create_item_tree
        _DB_mediasource_t_DB_mediasource_t_free_item_tree_ft free_item_tree
        _DB_mediasource_t_DB_mediasource_t_scanner_state_ft scanner_state
        _DB_mediasource_t_DB_mediasource_t_get_queries_scriptable_ft get_queries_scriptable
        _DB_mediasource_t_DB_mediasource_t_get_tree_item_parent_ft get_tree_item_parent
        _DB_mediasource_t_DB_mediasource_t_is_tree_item_selected_ft is_tree_item_selected
        _DB_mediasource_t_DB_mediasource_t_set_tree_item_selected_ft set_tree_item_selected
        _DB_mediasource_t_DB_mediasource_t_is_tree_item_expanded_ft is_tree_item_expanded
        _DB_mediasource_t_DB_mediasource_t_set_tree_item_expanded_ft set_tree_item_expanded
        _DB_mediasource_t_DB_mediasource_t_tree_item_get_text_ft tree_item_get_text
        _DB_mediasource_t_DB_mediasource_t_tree_item_get_track_ft tree_item_get_track
        _DB_mediasource_t_DB_mediasource_t_tree_item_get_next_ft tree_item_get_next
        _DB_mediasource_t_DB_mediasource_t_tree_item_get_children_ft tree_item_get_children
        _DB_mediasource_t_DB_mediasource_t_tree_item_get_children_count_ft tree_item_get_children_count

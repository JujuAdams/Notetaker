function __notetaker_import_binary()
{
    if (NOTETAKER_VERBOSE) __notetaker_trace("Importing binary data from \"", NOTETAKER_COMPILED_FILE_NAME, "\"");
    
    if (!file_exists(NOTETAKER_COMPILED_FILE_NAME))
    {
        __notetaker_error("\"", NOTETAKER_COMPILED_FILE_NAME, "\" not found\nPlease recompile Notetaker");
    }
    else
    {
        var _buffer_compressed = buffer_load(NOTETAKER_COMPILED_FILE_NAME);
        if (_buffer_compressed < 0)
        {
            __notetaker_error("Could not load \"", NOTETAKER_COMPILED_FILE_NAME, "\"");
        }
        else
        {
            var _buffer = buffer_decompress(_buffer_compressed);
            if (_buffer < 0)
            {
                __notetaker_error("Could not decompress \"", NOTETAKER_COMPILED_FILE_NAME, "\"");
            }
            else
            {
                var _header = buffer_read(_buffer, buffer_string);
                if (_header != "Notetaker")
                {
                    __notetaker_error("\"", NOTETAKER_COMPILED_FILE_NAME, "\" could not be unpacked");
                }
                else
                {
                    var _version = buffer_read(_buffer, buffer_string);
                    switch(_version)
                    {
                        case "0.0.0":
                            if (NOTETAKER_VERBOSE) __notetaker_trace("Parsing binary file, version found was ", _version);
                            
                            var _count = buffer_read(_buffer, buffer_u32)
                            repeat(_count)
                            {
                                var _note_name = buffer_read(_buffer, buffer_string);
                                var _note_size = buffer_read(_buffer, buffer_u64);
                                var _note_buffer = buffer_create(_buffer, buffer_grow, _note_size);
                                buffer_copy(_buffer, buffer_tell(_buffer), _note_size, _note_buffer, 0);
                                buffer_seek(_buffer, buffer_seek_relative, _note_size);
                                
                                if (NOTETAKER_VERBOSE) __notetaker_trace("Found \"", _note_name, "\" (buffer size = ", _note_size, ")");
                                
                                with(new __notetaker_class_note())
                                {
                                    global.notetaker_dictionary[? _note_name] = self;
                                    name = _note_name;
                                    buffer = _note_buffer;
                                }
                            }
                        break;
                    }
                }
                
                buffer_delete(_buffer_compressed);
            }
            
            buffer_delete(_buffer);
        }
        
        __notetaker_execute_callbacks();
    }
}
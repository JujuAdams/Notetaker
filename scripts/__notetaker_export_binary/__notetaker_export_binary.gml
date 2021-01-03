function __notetaker_export_binary()
{
    if (NOTETAKER_VERBOSE) __notetaker_trace("Compiling elements");
    
    var _array = notetaker_get_array();
    
    var _buffer = buffer_create(1024, buffer_grow, 1);
    buffer_write(_buffer, buffer_string, "Notetaker");
    buffer_write(_buffer, buffer_string, __NOTETAKER_VERSION);
    buffer_write(_buffer, buffer_u32, array_length(_array));
    
    var _i = 0;
    repeat(array_length(_array))
    {
        with(_array[_i])
        {
            buffer_write(_buffer, buffer_string, name);
            buffer_write(_buffer, buffer_u64, buffer_get_size(buffer));
            
            buffer_resize(_buffer, buffer_tell(_buffer) + buffer_get_size(buffer));
            buffer_copy(buffer, 0, buffer_get_size(buffer), _buffer, buffer_tell(_buffer));
            buffer_seek(_buffer, buffer_seek_relative, buffer_get_size(buffer));
        }
        
        ++_i;
    }
    
    var _buffer_compressed = buffer_compress(_buffer, 0, buffer_get_size(_buffer));
    
    var _path = global.__notetaker_project_directory + "datafiles\\" + NOTETAKER_COMPILED_FILE_NAME;
    if (NOTETAKER_VERBOSE) __notetaker_trace("Exporting binary data to \"", _path, "\"");
    buffer_save(_buffer_compressed, _path);
    
    buffer_delete(_buffer);
    buffer_delete(_buffer_compressed);
}
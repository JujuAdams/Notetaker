function __notetaker_import_notes()
{
    if (NOTETAKER_VERBOSE) __notetaker_trace("Loading notes from .yyp");
    
    if (!file_exists(NOTETAKER_PROJECT_PATH))
    {
        __notetaker_error("Project file not found at \"", NOTETAKER_PROJECT_PATH, "\"\n\nCheck the path, and make sure to turn on \"Disable file system sandbox\" in Game Options");
    }
    else
    {
        var _buffer = buffer_load(NOTETAKER_PROJECT_PATH);
        var _json_string = buffer_read(_buffer, buffer_string);
        var _json = json_parse(_json_string);
        
        var _resources_array = _json[$ "resources"];
        if (_resources_array != undefined)
        {
            var _i = 0;
            repeat(array_length(_resources_array))
            {
                var _resource_struct = _resources_array[_i].id;
                var _path = filename_change_ext(_resource_struct.path, ".txt");
                var _name = _resource_struct.name;
                
                if ((string_copy(_path, 1, 6) == "notes/") && !ds_map_exists(global.notetaker_dictionary, _name))
                {
                    with(new __notetaker_class_note())
                    {
                        global.notetaker_dictionary[? _name] = self;
                        
                        name = _name;
                        path = global.__notetaker_project_directory + _path;
                    }
                }
                
                ++_i;
            }
        }
        
        buffer_delete(_buffer);
        
        if (NOTETAKER_VERBOSE) __notetaker_trace("Checking all notes for changes");
        
        var _changed = false;
        
        var _array = notetaker_get_array();
        var _i = 0;
        repeat(array_length(_array))
        {
            if (_array[_i].update()) _changed = true;
            ++_i;
        }
        
        if (NOTETAKER_DEV_COMPILE_ON_UPDATE) __notetaker_export_binary();
        
        if (_changed) __notetaker_execute_callbacks();
    }
}
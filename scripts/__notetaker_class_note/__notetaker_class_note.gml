function __notetaker_class_note() constructor
{
    name   = undefined;
    path   = undefined;
    hash   = undefined;
    buffer = undefined;
    
    static update = function()
    {
        var _changed = false;
        
        var _new_hash = md5_file(path);
        if (NOTETAKER_VERBOSE) __notetaker_trace("Loading \"", path, "\", hash = ", _new_hash, " vs. old hash = ", hash);
        
        if (_new_hash != hash)
        {
            if (NOTETAKER_VERBOSE) __notetaker_trace("\"", path, "\" changed, reloading");
            
            hash = _new_hash;
            flush();
            buffer = buffer_load(path);
            
            _changed = true;
        }
        else
        {
            if (NOTETAKER_VERBOSE) __notetaker_trace("\"", path, "\" not changed");
        }
        
        return _changed;
    }
    
    static flush = function()
    {
        if (buffer != undefined)
        {
            buffer_delete(buffer);
            buffer = undefined;
        }
    }
}
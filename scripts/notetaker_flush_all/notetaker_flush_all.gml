function notetaker_flush_all()
{
    var _array = notetaker_get_array();
    var _i = 0;
    repeat(array_length(_array))
    {
        _array[_i].flush();
        ++_i;
    }
    
    ds_map_clear(global.notetaker_dictionary);
}
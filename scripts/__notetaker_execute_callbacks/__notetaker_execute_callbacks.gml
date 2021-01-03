function __notetaker_execute_callbacks()
{
    if (is_numeric(NOTETAKER_LOAD_FUNCTION) || is_method(NOTETAKER_LOAD_FUNCTION))
    {
        var _array = notetaker_get_array();
        var _i = 0;
        repeat(array_length(_array))
        {
            with(_array[_i]) NOTETAKER_LOAD_FUNCTION();
            ++_i;
        }
    }
}
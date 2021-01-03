function notetaker_tick()
{
    if (!global.__notetaker_release_mode)
    {
        var _focus = window_has_focus();
        if (global.__notetaker_in_focus != _focus)
        {
            global.__notetaker_in_focus = _focus;
            if (_focus) __notetaker_import_notes();
        }
    }
}
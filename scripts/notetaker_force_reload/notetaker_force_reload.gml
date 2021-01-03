function notetaker_force_reload()
{
    if (!global.__notetaker_release_mode)
    {
        __notetaker_import_notes();
    }
}
function notetaker_force_compile()
{
    if (!global.__notetaker_release_mode)
    {
        __notetaker_export_binary();
    }
}
__notetaker_init();

function __notetaker_init()
{
    if (variable_global_exists("__notetaker_in_focus")) exit;
    
    __notetaker_trace("Welcome to Notetaker by @jujuadams! This is version ", __NOTETAKER_VERSION, ", ", __NOTETAKER_DATE);
    
    global.notetaker_dictionary          = ds_map_create();
    global.__notetaker_release_mode      = NOTETAKER_RELEASE_MODE;
    global.__notetaker_in_focus          = true;
    global.__notetaker_project_directory = filename_dir(NOTETAKER_PROJECT_PATH) + "\\";
    
    //Run some idiot-checking code when release mode is set to <false>
    //This prevents potential issues if people forget to set the release mode...
    if (!global.__notetaker_release_mode)
    {
        global.__notetaker_release_mode = true;
        
        if (code_is_compiled() && (parameter_count() == 1))
        {
            var _path = filename_dir(parameter_string(0));
            
            var _last_folder = _path;
            do
            {
                var _pos = string_pos("\\", _last_folder);
                if (_pos > 0) _last_folder = string_delete(_last_folder, 1, _pos);
            }
            until (_pos <= 0);
            
            var _last_four = string_copy(_last_folder, string_length(_last_folder) - 3, 4);
            var _filename = filename_change_ext(filename_name(parameter_string(0)), "");
            
            if ((_last_four == "_YYC")
            &&  (string_length(_last_folder) - string_length(_filename) == 13))
            {
                global.__notetaker_release_mode = false;
            }
        }
        else
        {
            if ((parameter_count() == 3)
            &&  (filename_name(parameter_string(0)) == "Runner.exe")
            &&  (parameter_string(1) == "-game")
            &&  (filename_ext(parameter_string(2)) == ".win"))
            {
                global.__notetaker_release_mode = false;
            }
        }
        
        if (NOTETAKER_VERBOSE && global.__notetaker_release_mode) __notetaker_trace("Forcing release mode on");
    }
    
    //Import from our compiled binary if we're in release mode, otherwise load from the notes files
    if (global.__notetaker_release_mode)
    {
        __notetaker_import_binary();
    }
    else
    {
        __notetaker_import_notes();
    }
}




#region

#macro __NOTETAKER_VERSION  "0.0.0"
#macro __NOTETAKER_DATE     "2020-01-03"
#macro __NOTETAKER_EXPECTED_FRAME_TIME  (0.95*game_get_speed(gamespeed_microseconds)/1000) //Uses to prevent the autotype from advancing if a draw call is made multiple times a frame to the same text element



function __notetaker_trace()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_debug_message("Notetaker: " + _string);
}

function __notetaker_error()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_error("Notetaker:\n\n" + _string + "\n ", true);
}

#endregion
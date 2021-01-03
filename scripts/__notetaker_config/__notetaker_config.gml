//Controls how Notetaker loads UI definitions and whether to allow the use of development functions
//Set this macro to <true> when building the game for public release
//To enable development features, set this macro to <false>
#macro NOTETAKER_RELEASE_MODE  false

//The path that leads to your project's main .yyp file
//This allows Notetaker to read the Notes files found in your project
//Don't forget to escape \ characters!
#macro NOTETAKER_PROJECT_PATH  "A:\\GitHub repos\\Mine\\Notetaker\\notetaker.yyp"

//The name of the file in Included Files that contains the compiled Notetaker UI descriptions
//This file is used when running the game outside the IDE (i.e. for production builds)
#macro NOTETAKER_COMPILED_FILE_NAME  "notetaker.bin"

//Whether to compile your Notetaker UI descriptions whenever Notetaker updates from your Notes files
//Compilation will happen whenever notetaker_dev_update() is called, or when Notetaker automatically updates from Notes files (see NOTETAKER_DEV_UPDATE_FREQ above)
//This is obviously a little slow, but it ensures that your compiled Notetaker file is always up to date
//If you turn this off, you'll need to run notetaker_dev_compile() yourself
#macro NOTETAKER_DEV_COMPILE_ON_UPDATE  true

//
#macro NOTETAKER_LOAD_FUNCTION  undefined

//
#macro NOTETAKER_VERBOSE  true
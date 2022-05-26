
// Project: MazeCrawler 
// Created: 2022-05-19

// show all errors
SetErrorMode(2)

#include "MazeGrid.agc"
#include "Util.agc"

// set window properties
SetWindowTitle( "MazeCrawler" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
//SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetVSync(1)
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

MazeGrid[0, 0].CellType = 4

//ClearMazeGrid(MazeGrid)



do
    Print( ScreenFPS() )
    Print(MazeGrid[0, 0].CellType)
    Print(ReturnTrue())
    Sync()
loop

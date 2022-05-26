SetErrorMode(2)

#include "Util.agc"

type MazeGridCell
    CellType as integer
    Passable as integer
    StepTimer as float
endtype
    

//the last index on the array, they start at 0
#constant MAZE_SIZE_LAST_INDEX 24
#constant MAZE_SIZE 25

MazeGrid as MazeGridCell[MAZE_SIZE_LAST_INDEX, MAZE_SIZE_LAST_INDEX]


function ClearMazeGrid(MazeGrid ref as MazeGridCell[][])
    EmptyMazeGridCell as MazeGridCell
    for x = 0 to MAZE_SIZE_LAST_INDEX
        for y = 0 to MAZE_SIZE_LAST_INDEX
            MazeGrid[x, y] = EmptyMazeGridCell
        next y
            
    next x
        
endfunction

function GenerateRandomMazeGrid(MazeGrid ref as MazeGridCell[][])
    
endfunction
    
    





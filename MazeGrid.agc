SetErrorMode(2)

#include "Util.agc"

type Monster
    health as float
endtype
    

type MazeGridCell
    PosX as integer
    PosY as integer
    CellType as integer
    Passable as integer
    StepTimer as float
endtype

#constant CELL_TYPE_FLOOR = 0
#constant CELL_TYPE_WALL = 1
    

//the last index on the array, they start at 0
#constant MAZE_SIZE_LAST_INDEX 24
#constant MAZE_SIZE 25

global GameMazeGrid as MazeGridCell[MAZE_SIZE_LAST_INDEX, MAZE_SIZE_LAST_INDEX]


function ClearMazeGrid(MazeGrid ref as MazeGridCell[][])
    EmptyMazeGridCell as MazeGridCell
    for x = 0 to MAZE_SIZE_LAST_INDEX
        for y = 0 to MAZE_SIZE_LAST_INDEX
            MazeGrid[x, y] = EmptyMazeGridCell
        next y
            
    next x
        
endfunction

function InBounds(CellX as integer, CellY as integer, MazeGrid ref as MazeGridCell[][])
    IsInBounds as integer
    IsInBounds = (CellX > 0) and (CellY > 0) and (CellX < MAZE_SIZE_LAST_INDEX) and (CellY < MAZE_SIZE_LAST_INDEX)
endfunction IsInBounds
    

function GenerateCells(MazeGrid ref as MazeGridCell[][])
    NumPassableCells = 0
    x as integer
    y as integer
    for x = 0 to MAZE_SIZE_LAST_INDEX
        for y = 0 to MAZE_SIZE_LAST_INDEX
            if Random(0, 100) < 30 or (Not InBounds(x, y, MazeGrid))
                MazeGrid[x, y].Passable = 0
                MazeGrid[x, y].CellType = CELL_TYPE_WALL
            else
                MazeGrid[x, y].Passable = 1
                MazeGrid[x, y].CellType = CELL_TYPE_FLOOR
                Inc NumPassableCells
                    
            endif    
        next y
            
    next x
endfunction NumPassableCells


function GetRandomPassableCell(RandomPassableCell ref as MazeGridCell, MazeGrid ref as MazeGridCell[][])
    FoundOne as integer = 0
    
    x as integer, y as integer
    x = Random(0, MAZE_SIZE_LAST_INDEX)
    y = Random(0, MAZE_SIZE_LAST_INDEX)
    
    RandomPassableCell = MazeGrid[x, y]
    
    FoundOne = RandomPassableCell.Passable
endfunction FoundOne

function GetCell(x as integer, y as integer, Cell ref as MazeGridCell)
    FoundTile as integer = 0
    if (x < 0 or x > MAZE_SIZE_LAST_INDEX) or (y < 0 or y < MAZE_SIZE_LAST_INDEX)
        exitfunction 0
    endif
    
    Cell = GameMazeGrid[x, y]
    FoundTile = 1
        
endfunction FoundTile

function GetCellNeighbor(Cell ref as MazeGridCell, Dx as integer, Dy as integer,
    CellNeighbor ref as MazeGridCell)
    
    GetCell(Cell.PosX + Dx, Cell.PosY + Dy, CellNeighbor)
endfunction
    
function GetCellAdjacentNeighbors(Cell ref as MazeGridCell,
    AdjacentNeighbors ref as MazeGridCell[])
    
    CellNeighbor as MazeGridCell
    AdjacentNeighbors.length = 3
    
    GetCellNeighbor(Cell, 0, -1, AdjacentNeighbors[0])
    GetCellNeighbor(Cell, 0, 1, AdjacentNeighbors[1])
    GetCellNeighbor(Cell, -1, 0, AdjacentNeighbors[2])
    GetCellNeighbor(Cell, 1, 0, AdjacentNeighbors[3])
    
endfunction
    

function GetCellAdjacentPassableNeighbors(Cell ref as MazeGridCell,
    AdjacentPassableNeighbors as MazeGridCell[])
    
    AdjacentNeighbors as MazeGridCell[]
    GetCellAdjacentNeighbors(Cell, AdjacentNeighbors)
    
    i as integer
    for i = 0 to AdjacentNeighbors.length
        if AdjacentNeighbors[i].Passable
            AdjacentPassableNeighbors.insert(AdjacentNeighbors[i])
        endif
            
    next i
        
    
endfunction


function GetCellConnectedCells(Cell as MazeGridCell,
    ConnectedCells ref as MazeGridCell[],
    MazeGrid ref as MazeGridCell[][])
    
    ConnectedCells.insert(Cell)
    CellsToCheck as MazeGridCell[]
    CellsToCheck.insert(Cell)
    while CellsToCheck.length > -1
        CurrentCell as MazeGridCell
        CurrentCell = CellsToCheck[0]
        CellsToCheck.remove()
        PassableNeighbors as MazeGridCell[]
        GetCellAdjacentPassableNeighbors(CurrentCell, PassableNeighbors)
        for i = 0 to ConnectedCells.length
            for j = 0 to PassableNeighbors.length
                if PassableNeighbors[j]. = ConnectedCells[i] then
                    PassableNeighbors.remove(j)
                    
            next j
                
        next i
    endwhile
    
endfunction


function GenerateMap(MazeGrid ref as MazeGridCell[][])
    GeneratedWithSuccess as integer = 0
    PassableTiles as integer
    PassableTiles = GenerateCells(MazeGrid)
    
    RandomPassableCell as MazeGridCell
    MaxTries as integer = 1000
    
    while MaxTries
        if GetRandomPassableCell(RandomPassableCell, MazeGrid)
            exit
        endif
            
        dec MaxTries
    endwhile
    
    if MaxTries = 0
        GeneratedWithSuccess = 0
        exitfunction GeneratedWithSuccess
    endif
    
    ConnectedCells as MazeGridCell[]
    GetCellConnectedCells(RandomPassableCell, ConnectedCells, MazeGrid)
        
    
    
endfunction GeneratedWithSuccess


function GenerateLevel(MazeGrid ref as MazeGridCell[][])
    ClearMazeGrid(MazeGrid)
    GenerateMap(MazeGrid)
    
endfunction
    
    





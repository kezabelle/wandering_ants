local COLUMNS = 300
local ROWS = 300
local LEFT, UP, DOWN, RIGHT = 1, 2, 3, 4
local EMPTY, BLACK, WHITE = -1, 0, 255
-- cover non-randomness on Win32/OSX
math.randomseed(os.time())
local direction, startx, starty = math.random(4), math.random(COLUMNS), math.random(ROWS)

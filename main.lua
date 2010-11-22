local COLUMNS = 300
local ROWS = 300
local LEFT, UP, DOWN, RIGHT = 1, 2, 3, 4
local EMPTY, BLACK, WHITE = -1, 0, 255
-- cover non-randomness on Win32/OSX
math.randomseed(os.time())
local direction, startx, starty = math.random(4), math.random(COLUMNS), math.random(ROWS)
local grid, increment = {}, 0
for i=0, ROWS do
    grid[i] = {}
    for j=0, COLUMNS do
        grid[i][j] = EMPTY
    end
end
function love.load()
    love.graphics.setCaption("Langton's Ant")
	love.graphics.setMode(COLUMNS*2, ROWS*2, false, false, 0)
end
function love.update(dt)
    -- if the direction is over the max value (4/RIGHT), reset it to 1/LEFT
    -- alternatively, if its under the min (1/LEFT), set it to 4/RIGHT
    if direction > RIGHT then
        direction = LEFT
    elseif direction < LEFT then
        direction = RIGHT
    end
end
function love.draw()
    increment = increment+1
end

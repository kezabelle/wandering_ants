local COLUMNS = 300
local ROWS = 300
local LEFT, UP, DOWN, RIGHT = 1, 2, 3, 4
local EMPTY, BLACK, WHITE = -1, 0, 255
-- cover non-randomness on Win32/OSX
math.randomseed(os.time())
local direction, startx, starty, increment = math.random(4), math.random(COLUMNS), math.random(ROWS), 0
function love.load()
    love.graphics.setCaption("Langton's Ant")
	love.graphics.setMode(COLUMNS*2, ROWS*2, false, false, 0)
	canvas = love.image.newImageData(COLUMNS, ROWS)
	-- paint everything in the canvas black
	canvas:mapPixel(function ()
	    return 0, 0, 0, 100
    end)
end
function love.update(dt)
    -- if the direction is over the max value (4/RIGHT), reset it to 1/LEFT
    -- alternatively, if its under the min (1/LEFT), set it to 4/RIGHT
    if direction > RIGHT then
        direction = LEFT
    elseif direction < LEFT then
        direction = RIGHT
    end

    -- change direction
    if direction == LEFT then
        starty = starty-1
    elseif direction == RIGHT then
        startx = startx-1
    elseif direction == DOWN then
        starty = starty+1
    elseif direction == UP then
        startx = startx+1
    end

end
function love.draw()
    increment = increment+1
end

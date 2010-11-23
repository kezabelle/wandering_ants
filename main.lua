local COLUMNS = 300
local ROWS = 300
local LEFT, UP, DOWN, RIGHT = 1, 2, 3, 4
local EMPTY, BLACK, WHITE = -1, 0, 255
-- cover non-randomness on Win32/OSX
math.randomseed(os.time())
local direction, startx, starty, increment = math.random(4), math.random(COLUMNS), math.random(ROWS), 0
local canvas, rendered

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
    rendered = nil
    local r,_,_,_ = canvas:getPixel(startx, starty)

    -- if black (0), flip to white, otherwise flip to black
    if r == BLACK then
        canvas:setPixel(startx, starty, WHITE, WHITE, WHITE, 255)
        direction = direction+1
    else
        canvas:setPixel(startx, starty, BLACK, BLACK, BLACK, 255)
        direction = direction-1
    end

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

    -- handle edges of the world
    if startx > COLUMNS or startx < 0 then
        math.randomseed(os.time())
        startx =  math.random(COLUMNS)
        direction = math.random(4)
    end
    if starty > ROWS or starty < 0 then
        math.randomseed(os.time())
        starty = math.random(ROWS)
        direction = math.random(4)
    end

    rendered = love.graphics.newImage(canvas)
    rendered:setFilter('linear', 'linear')
end

function love.draw()
    increment = increment+1
    love.graphics.scale(2, 2)
    love.graphics.print('Iteration: '..increment, 20, 20)
    love.graphics.draw(rendered, 0, 0)
end

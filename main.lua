local COLUMNS = 50
local ROWS = 50
local SCALE = 10
local LEFT, UP, DOWN, RIGHT = 1, 2, 3, 4
local EMPTY, BLACK, WHITE = -1, 0, 255
-- cover non-randomness on Win32/OSX
math.randomseed(os.time())
local direction, startx, starty, increment = math.random(4), math.random(COLUMNS), math.random(ROWS), 0
local canvas, rendered

function love.load()
    love.graphics.setCaption("Langton's Ant")
	love.graphics.setMode(COLUMNS*SCALE, ROWS*SCALE, false, true, 0)
	canvas = love.image.newImageData(COLUMNS, ROWS)
	-- paint everything in the canvas black
	canvas:mapPixel(function ()
	    return 0, 0, 0, 100
    end)
end

function love.update(dt)
    rendered = nil
    local r,g,b,_ = canvas:getPixel(startx, starty)
    local rgb = r+g+b
    local newrgb = math.random(1, 254)
    canvas:setPixel(startx, starty, newrgb, newrgb, newrgb, 255)
    -- 600> is 'white', 165< is 'black', change direction!
    if rgb >= 600 then
        direction = direction+1
    elseif rgb <= 165 then
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
        startx =  math.random(COLUMNS)
        direction = math.random(RIGHT)
    end
    if starty > ROWS or starty < 0 then
        starty = math.random(ROWS)
        direction = math.random(RIGHT)
    end

    rendered = love.graphics.newImage(canvas)
    rendered:setFilter('linear', 'linear')
end

function love.draw()
    increment = increment+1
    love.graphics.scale(SCALE, SCALE)
    love.graphics.setColor(WHITE, WHITE, WHITE, 255)
    -- love.graphics.print('Iteration: '..increment, 20, 20)
    love.graphics.draw(rendered, 0, 0)
    love.graphics.setColor(WHITE, 0, 0, 255)
    love.graphics.rectangle('fill', startx, starty, 1, 1)
end

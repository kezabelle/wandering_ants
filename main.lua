-- bound defaults
local COLUMNS, ROWS, SCALE = 50, 50, 10
local LEFT, UP, DOWN, RIGHT = 1, 2, 3, 4
local EMPTY, BLACK, WHITE = -1, 0, 255
local keys = {1, 2, 3, 4, 5, 6, 7, 8, 9}
-- unbound on startup
local ants, direction, startx, starty, canvas, rendered


function love.load()
    love.graphics.setCaption("Langton's Ant")
	love.graphics.setMode(COLUMNS*SCALE, ROWS*SCALE, false, true, 0)
	love.mouse.setVisible(false)
	canvas = love.image.newImageData(COLUMNS, ROWS)
	reset()
	create_ants(1)
end

function reset()
    -- paint everything in the canvas black
    canvas:mapPixel(function ()
	    return 0, 0, 0, 100
    end)
    rendered = nil
end

function create_ants(count)
    ants = {}
    for i=1, count do
        -- cover non-randomness on Win32/OSX
        math.randomseed(i+count)
        ants[i] = {
            direction = math.random(RIGHT),
            x_position = math.random(COLUMNS),
            y_position = math.random(ROWS)
        }
    end
end

function love.keypressed(k, uni)
    -- did we press 1-9?
    local numkey = tonumber(k)
    if keys[numkey] then
        reset()
        create_ants(numkey)
    end
end

function love.update(dt)
    for _,ant in ipairs(ants) do
        local r,g,b,_ = canvas:getPixel(ant['x_position'], ant['y_position'])
        local rgb = r+g+b
        local newrgb = math.random(1, 254)
        canvas:setPixel(ant['x_position'], ant['y_position'], newrgb, newrgb, newrgb, 255)

        -- 600> is 'white', 165< is 'black', change direction!
        if rgb >= 600 then
            ant['direction'] = ant['direction']+1
        elseif rgb <= 165 then
            ant['direction'] = ant['direction']-1
        end

        -- if the direction is over the max value (4/RIGHT), reset it to 1/LEFT
        -- alternatively, if its under the min (1/LEFT), set it to 4/RIGHT
        if ant['direction'] > RIGHT then
            ant['direction'] = LEFT
        elseif ant['direction'] < LEFT then
            ant['direction'] = RIGHT
        end

        -- change direction
        if ant['direction'] == LEFT then
            ant['y_position'] = ant['y_position']-1
        elseif ant['direction'] == RIGHT then
            ant['x_position'] = ant['x_position']-1
        elseif ant['direction'] == DOWN then
            ant['y_position'] = ant['y_position']+1
        elseif ant['direction'] == UP then
            ant['x_position'] = ant['x_position']+1
        end

        -- handle edges of the world
        if ant['x_position'] > COLUMNS or ant['x_position'] < 0 then
            ant['x_position'] =  math.random(COLUMNS)
            direction = math.random(RIGHT)
        end
        if ant['y_position'] > ROWS or ant['y_position'] < 0 then
            ant['y_position'] = math.random(ROWS)
            direction = math.random(RIGHT)
        end
    end
    
    rendered = love.graphics.newImage(canvas)
    rendered:setFilter('nearest', 'nearest')
end

function love.draw()
    love.graphics.scale(SCALE, SCALE)
    love.graphics.setColor(WHITE, WHITE, WHITE, 255)
    love.graphics.draw(rendered, 0, 0)
    love.graphics.setColor(WHITE, 0, 0, 255)
    for _,ant in ipairs(ants) do
        love.graphics.rectangle('fill', ant['x_position'], ant['y_position'], 1, 1)
    end
end

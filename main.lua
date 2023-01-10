require 'tiles'
require 'buttons'

TILE_WIDTH = 960
TILE_HEIGHT = 640

local currentTileID = 3

function love.load()
    love.window.setFullscreen(true)

    scrollFont = love.graphics.newFont(64)
    controlFont = love.graphics.newFont(32)

    tiles = TileHelper:getTiles()
    scrollButtons = ButtonHelper:getScrolls()
    controlButtons = ButtonHelper:getControls()
end

function love.update(dt)
    currentTile = tiles[currentTileID]
    tileImage = love.graphics.newImage(currentTile.image)
end

function love.draw()
    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()

    -- load tile
    local tx = (ww * 0.5) - (TILE_WIDTH * 0.5)
    local ty = (wh * 0.5) - (TILE_HEIGHT * 0.5)
    love.graphics.setColor(255,255,255,1) -- don't know why this is necessary but here we are...
    love.graphics.draw(tileImage, tx, ty)

    for i, button in ipairs(controlButtons) do
        local bx = ww - button.width
        local by = 0

        button.draw(bx, by)
        checkButtonClick(bx, by, button)
    end

    -- get edge positions
    local tileTop = ty
    local tileBottom = ty + TILE_HEIGHT
    local tileMidY = ty + (TILE_HEIGHT * 0.5)
    local tileLeft = tx
    local tileRight = tx + TILE_WIDTH
    local tileMidX = tx + (TILE_WIDTH * 0.5)
    for i, button in ipairs(scrollButtons) do
        local bx, by = 0,0
        if button.id == "north" and currentTile.canMoveNorth then
            bx = tileMidX - (button.width * 0.5)
            by = tileTop - button.height
        elseif button.id == "south" and currentTile.canMoveSouth then
            bx = tileMidX - (button.width * 0.5)
            by = tileBottom
        elseif button.id == "east" and currentTile.canMoveEast then
            bx = tileRight
            by = tileMidY - (button.height * 0.5)
        elseif button.id == "west" and currentTile.canMoveWest then
            bx = tileLeft - button.width
            by = tileMidY - (button.height * 0.5)
        end

        if bx ~= 0 then
            button.draw(bx, by)
            checkButtonClick(bx, by, button)
        end
    end
end

function checkButtonClick(bx, by, button)
    button.last = button.now
    local mx, my = love.mouse.getPosition()

    local hover = mx > bx and mx < (bx + button.width) and 
                  my > by and my < (by + button.height)

    button.now = love.mouse.isDown(1)
    if button.now and not button.last and hover then
        button.fn()
    end
end

function moveTiles(target)
    if target == "north" then
        currentTileID = currentTile.northTile
    elseif target == "south" then
        currentTileID = currentTile.southTile
    elseif target == "east" then
        currentTileID = currentTile.eastTile
    elseif target == "west" then
        currentTileID = currentTile.westTile
    end
end
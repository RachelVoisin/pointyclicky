require 'tiles'
require 'buttons'
require 'state'

TILE_WIDTH = 960
TILE_HEIGHT = 640
TILES = nil
CURRENT_TILE = nil

function love.load()
    love.window.setFullscreen(true)
    love.graphics.setBackgroundColor(love.math.colorFromBytes(33, 30, 32))
    TILES = TileHelper:getTiles()
    scrollButtons = ButtonHelper:getScrolls()
    controlButtons = ButtonHelper:getControls()
    loadTile(1)
end

function love.update(dt)  
    -- check for escape and quit
    -- add arrow key movement
end

function love.draw()
    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()

    -- tile position
    local tx = (ww * 0.5) - (TILE_WIDTH * 0.5)
    local ty = (wh * 0.5) - (TILE_HEIGHT * 0.5)
    love.graphics.setColor(1,1,1) -- dont change color until after all images are drawn

    TileHelper:drawTile(tx, ty)
    ButtonHelper:drawControls(ww)
    ButtonHelper:drawScrolls(tx, ty)
end

function moveTiles(target)
    if target == "north" then
        loadTile(CURRENT_TILE.northTile)
    elseif target == "south" then
        loadTile(CURRENT_TILE.southTile)
    elseif target == "east" then
        loadTile(CURRENT_TILE.eastTile)
    elseif target == "west" then
        loadTile(CURRENT_TILE.westTile)
    end
end

function loadTile(id)
    CURRENT_TILE = TILES[id]
end
-- move to Image Helper ?
local function getImageScale(object)
    local currentWidth, currentHeight = object.image:getDimensions()
    object.scale = (object.width / currentWidth)
    object.height = currentHeight * object.scale
    return object
end

local function inflateButton(button)
    button.now = false
    button.last = false

    return button
end

-- local function inflateTextButton(button, margin, font)
--     button.textW = font:getWidth(button.text)
--     button.textH = font:getHeight(button.text)

--     button.width = button.textW + margin
--     button.height = button.textH + margin

--     button.draw = function(bx, by)
--         -- draw box
--         love.graphics.setColor(0.4,0.4,0.5,1)
--         love.graphics.rectangle(
--             "fill",
--             bx,
--             by,
--             button.width, 
--             button.height
--         )

--         -- print text
--         love.graphics.setColor(0,0,0,1)
--         love.graphics.print(
--             button.text,
--             font,
--             bx + (button.width * 0.5) - (button.textW * 0.5),
--             by + (button.height * 0.5) - (button.textH * 0.5)
--         ) 

--     end

--     return inflateButton(button)
-- end

local function inflateImageButton(button)
    button = getImageScale(button)

    button.draw = function(bx, by, image, scale)
        love.graphics.draw(image, bx, by, 0, scale, scale)
    end

    return inflateButton(button)
end

local function inflateScrollButton(button)
    button.width = 60
    button = inflateImageButton(button)
    button.fn = function()
        moveTiles(button.id)
    end

    return button
end

ButtonHelper = {}

function ButtonHelper:getScrolls()
    local scrollButtons = {}
    table.insert(scrollButtons, inflateScrollButton({
        id = "north",
        image = love.graphics.newImage("assets/images/buttons/arrow-up.png")
    }))
    table.insert(scrollButtons, inflateScrollButton({
        id = "south",
        image = love.graphics.newImage("assets/images/buttons/arrow-down.png")
    }))
    table.insert(scrollButtons, inflateScrollButton({
        id = "east",
        image = love.graphics.newImage("assets/images/buttons/arrow-right.png")
    }))
    table.insert(scrollButtons, inflateScrollButton({
        id = "west",
        image = love.graphics.newImage("assets/images/buttons/arrow-left.png")
    }))
    return scrollButtons
end

function ButtonHelper:getControls()
    local controlButtons = {}
    table.insert(controlButtons, inflateImageButton({
        id = "exit",
        image = love.graphics.newImage("assets/images/buttons/close.png"),
        width = 40,
        fn = function()
            love.event.quit(0)
        end
    }))
    return controlButtons
end

function ButtonHelper:drawControls(ww)
    for i, button in ipairs(controlButtons) do
        local bx = ww - button.width
        local by = 0

        button.draw(bx, by, button.image, button.scale)
        checkButtonClick(bx, by, button)
    end
end

function ButtonHelper:drawScrolls(tx, ty)
    -- get edge positions
    local tileTop = ty
    local tileBottom = ty + TILE_HEIGHT
    local tileMidY = ty + (TILE_HEIGHT * 0.5)
    local tileLeft = tx
    local tileRight = tx + TILE_WIDTH
    local tileMidX = tx + (TILE_WIDTH * 0.5)
    for i, button in ipairs(scrollButtons) do
        local bx, by = 0,0
        if button.id == "north" and CURRENT_TILE.canMoveNorth then
            bx = tileMidX - (button.width * 0.5)
            by = tileTop - button.height
        elseif button.id == "south" and CURRENT_TILE.canMoveSouth then
            bx = tileMidX - (button.width * 0.5)
            by = tileBottom
        elseif button.id == "east" and CURRENT_TILE.canMoveEast then
            bx = tileRight
            by = tileMidY - (button.height * 0.5)
        elseif button.id == "west" and CURRENT_TILE.canMoveWest then
            bx = tileLeft - button.width
            by = tileMidY - (button.height * 0.5)
        end

        if bx ~= 0 then
            button.draw(bx, by, button.image, button.scale)
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
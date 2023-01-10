local function inflateButton(button, margin, font)
    button.now = false
    button.last = false

    button.textW = font:getWidth(button.text)
    button.textH = font:getHeight(button.text)

    button.width = button.textW + margin
    button.height = button.textH + margin

    button.draw = function(bx, by)
        -- draw box
        love.graphics.setColor(0.4,0.4,0.5,1)
        love.graphics.rectangle(
            "fill",
            bx,
            by,
            button.width, 
            button.height
        )

        -- print text
        love.graphics.setColor(0,0,0,1)
        love.graphics.print(
            button.text,
            font,
            bx + (button.width * 0.5) - (button.textW * 0.5),
            by + (button.height * 0.5) - (button.textH * 0.5)
        ) 

    end

    return button
end

local function inflateScrollButton(button)
    local margin = 32
    button = inflateButton(button, margin, scrollFont)

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
        text = "^"
    }))
    table.insert(scrollButtons, inflateScrollButton({
        id = "south",
        text = "v"
    }))
    table.insert(scrollButtons, inflateScrollButton({
        id = "east",
        text = ">",
    }))
    table.insert(scrollButtons, inflateScrollButton({
        id = "west",
        text = "<",
    }))
    return scrollButtons
end

function ButtonHelper:getControls()
    local controlButtons = {}
    local margin = 16
    table.insert(controlButtons, inflateButton({
        id = "exit",
        text = "x",
        fn = function()
            love.event.quit(0)
        end
    }, margin, controlFont))
    return controlButtons
end
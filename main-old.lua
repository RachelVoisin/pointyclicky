BUTTON_HEIGHT = 64

local function newButton(text, fn)
    return {
        text = text,
        fn = fn,
        now = false,
        last = false
    }
end

local buttons = {}
local font = nil

function love.load()
    font = love.graphics.newFont(
        32
    )

    table.insert(buttons, newButton(
        "Start Game",
        function()
            print("starting")
        end
    ))
    table.insert(buttons, newButton(
        "Load Game",
        function()
            print("loading")
        end
    ))
    table.insert(buttons, newButton(
        "Settings",
        function()
            print("wow")
        end
    ))
    table.insert(buttons, newButton(
        "Exit",
        function()
            love.event.quit(0)
        end
    ))
end

function love.update(dt)
end

function love.draw()
    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()
    local margin = 16
    local button_width = ww * (1/3)
    local total_height = (BUTTON_HEIGHT + margin) * #buttons
    local cursor_y = 0

    for i, button in ipairs(buttons) do
        button.last = button.now

        local bx = (ww * 0.5) - (button_width * 0.5)
        local by = (wh * 0.5) - (total_height * 0.5) + cursor_y

        local color = {0.4,0.4,0.5,1}

        local mx, my = love.mouse.getPosition()
        local hover = mx > bx and mx < (bx + button_width) and 
                      my > by and my < (by + BUTTON_HEIGHT)
        if hover then
            color = {0.8,0.8,0.9,1}
        end

        button.now = love.mouse.isDown(1)
        -- making sure that function doesn't fire more than once per click
        if button.now and not button.last and hover then
            button.fn()
        end

        love.graphics.setColor(unpack(color))
        love.graphics.rectangle(
            "fill",
            bx,
            by,
            button_width, 
            BUTTON_HEIGHT
        )

        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)

        love.graphics.setColor(0,0,0,1)
        love.graphics.print(
            button.text, --text
            font,
            (ww * 0.5) - (textW * 0.5),
            by + (BUTTON_HEIGHT * 0.5) - (textH * 0.5)
        )

        cursor_y = cursor_y + BUTTON_HEIGHT + margin
    end
end
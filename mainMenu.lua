MainMenu = {}
MainMenu.__index = MainMenu

local paddingStart = 50
local buttonPadding = 10
local numberOfButtons = 2
local buttonWidth = 200
local buttonHeight = 50

local waitTime = 0
local isWaiting = false

local buttonActions = {
    function (menu)
        print("New Game")
        love.audio.play(menu.selectStartSound)

    end,
    function () love.quit() end
}

function isCoordInRect(x, y, rectX, rectY, widthX, widthY)
    return  x > rectX
        and y > rectY
        and x < rectX + widthX
        and y < rectY + widthY
end

function MainMenu.new()
    local menu = {}
    setmetatable(menu, MainMenu)
    menu.buttons = {}
    menu.isButtonPressed = false
    menu.buttonPressedID = 1

    for i=1, numberOfButtons do
        table.insert(menu.buttons, {})
        menu.buttons[i].normalImg = love.graphics.newImage("Assets/button" .. i .. "normal.png")
        menu.buttons[i].pressedImg = love.graphics.newImage("Assets/button" .. i .. "pressed.png")
        menu.buttons[i].action = buttonActions[i]
    end

    menu.selectStartSound = love.audio.newSource("Assets/Sounds/selectstart.wav"
        , static)
    menu.menuBackground = love.graphics.newImage("Assets/titlescreen.png")
    return menu
end


function MainMenu:draw(dt)
    currentDrawPosition = paddingStart
    for i=1, #buttons do
        local drawingImg = nil;
        if menu.isButtonPressed and menu.buttonPressedID == i then
            drawingImg = menu.buttons[i].pressedImg
        else
            drawingImg = menu.buttons[i].normalImg
        end
        menu.buttons[i].xPos = (SCREEN_WIDTH - buttonWidth) / 2
        menu.buttons[i].yPos = currentDrawPosition
        drawingImg.draw(self.buttonImage,
            menu.buttons[i].xPos,
            menu.buttons[i].yPos)
    end
end

function MainMenu:mousepressed(x, y, button, istouch)
    for i=1, #buttons do
        if button == 1 and isCoordInRect(x, y,
            buttons[i].xPos,
            buttons[i].yPos,
            buttonWidth,
            buttonHeight) then
            self.isButtonPressed = true
            self.buttonPressedID = i
            return;
        end
    end
end

function MainMenu:mousereleased(x, y, button, istouch)
    if self.isButtonPressed then
        self.buttons[self.buttonPressedID].action(self)
        love.audio.play()
    end
end

function MainMenu:update(dt)
end

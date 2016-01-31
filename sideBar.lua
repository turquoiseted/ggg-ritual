SideBar = {}
SideBar.__index = SideBar

local sun_time = 10*60
local sun_periods = 9;
local sun_period_time = sun_time / sun_periods
local sunPadding = 5
local sunPositionSize = 150
local panelWidth = sunPositionSize
local screenHeight = 63
local tasksPaddingTop = 50
local tasksPaddingLeft = 18
local tasksPaddingRight = 24
local tasksTextWidth = panelWidth - tasksPaddingRight - tasksPaddingLeft
local tasksSpacing = 15

function SideBar.new()
    local sideBar = {}
    setmetatable(sideBar, SideBar)
    --sideBar.sun_animation = Animation.newFromFile("Animations/sun.lua")
    sideBar.sunBackgroundPanel = love.graphics.newImage("Assets/_UI/woodpanel150.png")
    sideBar.scroll = love.graphics.newImage("Assets/_UI/scroll.png")
    sideBar.tasks = {"Go kill a dragon!"}
    --sideBar:update_time(0)
    return sideBar
end

function SideBar:draw()
    --self.sun_animation.currentFrameIndex = self.sun_animations[math.floor(world.secondsElapsedInDay / sun_period_time)]
    love.graphics.draw(self.sunBackgroundPanel, world.camera_x + 0, world.camera_y + 0)
    love.graphics.draw(self.scroll, world.camera_x + 0, world.camera_y + sunPositionSize)

    currentDrawPosition = sunPositionSize + tasksPaddingTop
    local font = love.graphics.newFont(10)
    local prevR, prevG, prevB, prevA = love.graphics.getColor()
    love.graphics.setColor(0, 0, 0) --Black
    for i=1,#self.tasks do
        love.graphics.printf(self.tasks[i], world.camera_x + tasksPaddingLeft,
            world.camera_y + currentDrawPosition,
            tasksTextWidth)
        local _, lines = font:getWrap(self.tasks[i], tasksTextWidth)
        currentDrawPosition = currentDrawPosition + tasksSpacing +
            lines * font:getHeight()
    end
    love.graphics.setColor(prevR, prevG, prevB, prevA)
    --self.sun_animation:draw(sunPadding, sunPadding)
end

function SideBar:addNewTask(taskText)
    table.insert(self.tasks, taskText)
end

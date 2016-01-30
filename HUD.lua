HUD = {}
HUD.__index = HUD

local sun_time = 10*60
local sun_periods = 9;
local sun_period_time = sun_time / sun_periods
local padding = 5
local sunSize = 150

function HUD.new()
    local hud = {}
    setmetatable(hud, HUD)
    hud.sun_animation = Animation.newFromFile("Animations/sun.lua")
    hud.sunBackgroundPanel = love.graphics.newImage("Assets/woodpanel150.png")
    hud.scroll = love.graphics.newImage("Assets/scroll.png")
    --hud:update_time(0)
    return p
end

function HUD:draw()
    print("Drawing HUD")
    p.sun_animation.currentFrameIndex = self.sun_animations[math.floor(world.secondsElapsedInDay / sun_period_time)]
    love.graphics.draw(self.sunBackgroundPanel, 0, 0)
    love.graphics.draw(self.scroll, 0, sunSize)
    self.sun_animation:draw(padding, padding)
end

Player = {}
Player.__index = Player

function Player.new()
    local p = {}
    p.x = 10
    p.y = 10
    p.vx = 0
    p.vy = 0
    p.inventory = {}
    p.health = 10
    p.strength = 10
    p.speed_stat = 10
    p.const_speed_multiplier = 20
    p.width = 20
    p.height = 20
    p.animation_down = Animation.newFromFile("Animations/player_down.lua")
    p.animation_up   = Animation.newFromFile("Animations/player_up.lua")
    p.animation_left = Animation.newFromFile("Animations/player_left.lua")
    p.animation_right = Animation.newFromFile("Animations/player_right.lua")
    p.current_animation = p.animation_down
    setmetatable(p, Player)

    return p
end

function Player:draw()
    self.current_animation:draw(self.x, self.y)
end

function Player:update(dt)
    self.current_animation:update(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
end

function Player:move(direction)
    print("Player move called with direction: " .. direction)

    c = self.const_speed_multiplier
    if direction == "left" then
        self.vx = -self.speed_stat * c
        self.current_animation = self.animation_left
    elseif direction == "right" then
        self.vx = self.speed_stat * c
        self.current_animation = self.animation_right
    elseif direction == "down" then
        self.vy = self.speed_stat * c
        self.current_animation = self.animation_down
    elseif direction == "up" then
        self.vy = -self.speed_stat * c
        self.current_animation = self.animation_up
    end
end

function Player:idle()
    self.vx = 0
    self.vy = 0
end

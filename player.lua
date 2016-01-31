Player = {}
setmetatable(Player, GameObject)
Player.__index = Player

function Player.new()
    local p = GameObject.new()
    setmetatable(p, Player)

    p._collidable = true
    p._width = 32
    p._height = 32
    p.x = 150*32
    p.y = 20*32
    p.vx = 0
    p.vy = 0
    p.inventory_size = 5
    p.inventory = {[1]={}, [2]={}, [3]={}, [4]={}, [5]={}}

    p.health = 10
    p.strength = 10
    p.speed_stat = 10
    p.width = 20
    p.height = 20
    p.animation_down = Animation.newFromFile("Animations/player_down.lua")
    p.animation_up   = Animation.newFromFile("Animations/player_up.lua")
    p.animation_left = Animation.newFromFile("Animations/player_left.lua")
    p.animation_right = Animation.newFromFile("Animations/player_right.lua")
    p.current_animation = p.animation_down
    p.attacking = false

    return p
end

function Player:draw()
    self.current_animation:draw(self.x, self.y)
end

function Player:update(dt)
    self.current_animation:update(dt)
end

function Player:move(direction)
    print("Player move called with direction: " .. direction)

    self.current_animation:play()
    c = ENTITY_SPEED_MULTIPLIER
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
    self.current_animation:pause()
end

function Player:add_inventory_item(item, count)
end

function Player:attack()
    self.attacking = true
end

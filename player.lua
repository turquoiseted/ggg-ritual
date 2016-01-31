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
    p.inventory = nil

    p.health = 10
    p.strength = 10
    p.speed_stat = 10
    p.width = 20
    p.height = 20
    p.animation_down_idle = Animation.newFromFile("Animations/player/player_down.lua")
    p.animation_up_idle   = Animation.newFromFile("Animations/player/player_up.lua")
    p.animation_left_idle = Animation.newFromFile("Animations/player/player_left.lua")
    p.animation_right_idle = Animation.newFromFile("Animations/player/player_right.lua")
    p.animation_down_attack = nil
    p.animation_up_attack = nil
    p.animation_left_attack = nil
    p.animation_right_attack = nil
    p.animation_hurt = nil
    p.animation_dying = nil
    p.current_animation = p.animation_down_idle

    p.ai_state = "idle"   --can be idle, walking, hitting, hurt, jumping or dying
    p.direction = "down"  --can be up, down, left or right

    p.sounds = {}
    p.sounds["walking"] = nil
    p.sounds["hitting"] = nil
    p.sounds["hurt"] = nil
    p.sounds["jumping"] = nil
    p.sounds["dying"] = nil

    return p
end

function Player:draw()
    self.current_animation:draw(self.x, self.y)
end

function Player:update(dt)
    self.current_animation:update(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt

    self:update_AI()
end


function Player:update_AI()
    if self.ai_state == "idle" then
    elseif self.ai_state == "walking" then
    elseif self.ai_state == "hitting" then
    elseif self.ai_state == "hurt" then
    elseif self.ai_state == "jumping" then
    elseif self.ai_state == "dying" then
    end
end

function Player:set_ai(state)
    self.animation:reset()
    self.animation.playing = true
    prev_state = self.ai_state
    self.ai_state = state
    if state == "idle" or state == "walking" or state == "jumping" then
        if self.direction == "up" then self.animation = self.animation_up_idle
	elseif self.direction == "down" then self.animation = self.animation_down_idle
	elseif self.direction == "left" then self.animation = self.animation_left_idle
	elseif self.direction == "right" then self.animation = self.animation_right_idle
	end
	if state == "idle" then self.animation.playing = false end
    elseif state == "hitting" then
	self.frames_waiting = 30  -- wait for 30 frames to hit player
	if self.direction == "up" then self.animation = self.animation_up_attack
	elseif self.direction == "down" then self.animation = self.animation_down_attack
	elseif self.direction == "left" then self.animation = self.animation_left_attack
	elseif self.direction == "right" then self.animation = self.animation_right_attack
	end
    elseif state == "hurt" then
	self.animation = self.animation_hurt
    elseif state == "dying" then
	 self.animation = self.animation_dying
    else
         self.ai_state = prev_state
	 print("Invalid state: from ", self.ai_state, " to ", state)
    end
end

function Player:move(direction)
    print("Player move called with direction: " .. direction)

    self.current_animation:play()
    c = ENTITY_SPEED_MULTIPLIER
    if direction == "left" then
        self.vx = -self.speed_stat * c
        self.current_animation = self.animation_left_idle
    elseif direction == "right" then
        self.vx = self.speed_stat * c
        self.current_animation = self.animation_right_idle
    elseif direction == "down" then
        self.vy = self.speed_stat * c
        self.current_animation = self.animation_down_idle
    elseif direction == "up" then
        self.vy = -self.speed_stat * c
        self.current_animation = self.animation_up_idle
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

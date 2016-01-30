Enemy = {}
setmetatable(Enemy, GameObject)
Enemy.__index = Enemy

function Enemy.new()
    local e = GameObject.new()
    setmetatable(e, Enemy)

    e.x = 0
    e.y = 0
    e.vx = 0
    e.vy = 0
    e.hp_state = 2
    e.speed_stat = 7
    e.ai_state = "idle"
    e.animation_idle = nil
    e.animation_chasing = nil
    e.animation_hitting = nil
    e.animation_nearby = nil
    e.animation_hurt = nil
    e.animation_dying = nil
    e.animation = nil
    e.frames_waited = -1  -- used for waiting to perform actions

    return e
end

function Enemy:update(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt

    -- Calculate distance to player
    dx = self.x - player.x
    dy = self.y - player.y
    dist = math.sqrt(math.pow(dx, 2) + math.pow(dy, 2))

    if dist <= self:get_pursuit_range() then
        self:pursue_player()
    else
        self.vx = 0
        self.vy = 0
    end

    if self.animation then
        self.animation:update(dt)
    end

    if self.frames_waiting > 0 then
	    self.frames_waiting = self.frames_waiting - 1
    end
end

function Enemy:draw()
    if self.sprite then
        love.graphics.draw(self.sprite, self.x, self.y)
    else
        print("No sprite found for enemy! Drawing rectangle instead.")
        love.graphics.rectangle("fill", self.x, self.y, 10, 10)
    end
end

function Enemy:update_AI()

    -- Calculate distance to player
    dx = self.x - player.x
    dy = self.y - player.y
    dist_to_player = math.sqrt(math.pow(dx, 2) + math.pow(dy, 2))

    if self.ai_state == "idle" then
         -- check if player is within range
	 if dist_to_player <= self:get_pursuit_range() then
		 self.ai_state = "chasing"
	 end
    elseif self.ai_state == "chasing" then
	 -- check if nearby player, set state to 'nearby' if so
	 if dist_to_player <= self:get_nearby_range() then
		 self.ai_state = "nearby"
	 -- check if far from player, set state to 'idle' if so		 
	 elseif dist_to_player > self:get_pursuit_range()+10 then
		 self.ai_state = "idle"
	 end
    elseif self.ai_state == "nearby" then
	 -- wait for certain number of frames, if this is achieved then attack
         if self.frames_waited == -1 then
		 self.frames_waited = 30
         elseif self.frames_waited == 0 then
		 self.ai_state = "hitting"
	 -- if player hits enemy now, will go to 'hurt' (ADD COLLISION DETECTION)
         elseif player.ai_state == "hitting" then
		 self.hp_stat = self.hp_stat - 1
		 self.ai_state = "hurt"
	 -- if player moves certain dist away from enemy, then becomes 'chasing'		 
	 elseif dist_to_player > self:get_nearby_range() then
		 self.ai_state = "chasing"
	 end
    elseif self.ai_state == "hitting" then
	 -- if animation has finished
         -- if player is colliding with enemy, will set them to hurt state
    elseif self.ai_state == "hurt" then
	 -- wait for hurt animation to finish, then restore ai state
    elseif self.ai_state == "dying" then
	 -- wait for dying animation to finish, then destroy self
	 self.dead = true
    end
end

function Enemy:set_AI(state)
    prev_state = self.ai_state
    self.ai_state = state
    if state == "idle" then
         self.animation = self.animation_idle
    elseif state == "chasing" then
	 self.animation = self.animation_chasing
    elseif state == "nearby" then
	 self.animation = self.animation_nearby
    elseif state == "hitting" then
	 self.animation = self.animation_hitting
    elseif state == "hurt" then
	 self.animation = self.animation_hurt
    elseif state == "dying" then
	 self.animation = self.animation_dying
    else
         self.ai_state = prev_state
	 print("Invalid state: from ", self.ai_state, " to ", state)
    end
end

function Enemy:get_pursuit_range()
    return 200
end

function Enemy:get_nearby_range()
    return 50
end

function Enemy:pursue_player()
    print("Pursuing player!")
    -- Calculate direction to move
    dx = player.x - self.x
    dy = player.y - self.y

    direction = math.atan2(dy, dx)
    speed = self.speed_stat * ENTITY_SPEED_MULTIPLIER

    self.vx = speed * math.cos(direction)
    self.vy = speed * math.sin(direction)
end

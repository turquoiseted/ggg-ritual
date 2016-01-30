Enemy = {}
Enemy.__index = Enemy

function Enemy.new()
    e = {}
    setmetatable(e, Enemy)

    e.x = 0
    e.y = 0
    e.vx = 0
    e.vy = 0
    e.speed_stat = 7

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
end

function Enemy:draw()
    if self.sprite then
        love.graphics.draw(self.sprite, self.x, self.y)
    else
        print("No sprite found for enemy! Drawing rectangle instead.")
        love.graphics.rectangle("fill", self.x, self.y, 10, 10)
    end
end

function Enemy:get_pursuit_range()
    return 200
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

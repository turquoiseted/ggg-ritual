Elder = {}
Elder.__index = Elder

function Elder.new()
    e = {}
    setmetatable(e, Elder)

    e.x = 10
    e.y = 10
    e.sprite = love.graphics.newImage("Assets/elder_base.png")

    return e
end

function Elder:update(dt)
end

function Elder:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

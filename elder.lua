Elder = {}
Elder.__index = Elder

function Elder.new()
    e = {}
    setmetatable(e, Elder)

    e.x = 200
    e.y = 200
    e.sprite = love.graphics.newImage("Assets/elder_base.png")
    e.has_overhead_text = true
    e.overhead_text = "G'day milord"

    return e
end

function Elder:update(dt)
end

function Elder:draw()
    love.graphics.draw(self.sprite, self.x, self.y)

    if self.has_overhead_text then
        text_width = love.graphics.getFont():getWidth(self.overhead_text)
        text_height = love.graphics.getFont():getHeight(self.overhead_text)
        love.graphics.printf(self.overhead_text, self.x - text_width/2, self.y - 3 - text_height, 100, "center")
    end
end

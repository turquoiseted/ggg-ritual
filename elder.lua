Elder = {}
setmetatable(Elder, GameObject)
Elder.__index = Elder

function Elder.new()
    local e = GameObject.new()
    setmetatable(e, Elder)

    e.x = 200
    e.y = 200
    e.sprite = love.graphics.newImage("Assets/elder_base.png")
    e.speech = nil

    return e
end

function Elder:update(dt)
    if self.speech and self.speech._dead then
        self.speech = nil
    end
end

function Elder:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

function Elder:speak(text, duration)
    self.speech = Speech.new(self, text, duration)
    world:add_game_object(self.speech)
end

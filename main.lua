require "lib.lovemachine.Animation.Animation"

require "player"

player = nil
function love.load()
    player = Player.new()
end

function love.update(dt)
    local idle = true
    if love.keyboard.isDown("left") then
        player:move("left")
        idle = false
    elseif love.keyboard.isDown("right") then
        player:move("right")
        idle = false
    end

    if love.keyboard.isDown("up") then
        player:move("up")
        idle = false
    elseif love.keyboard.isDown("down") then
        player:move("down")
        idle = false
    end

    if idle == true then
        player:idle()
    end

    player:update(dt)
end


function love.draw(dt)
    player:draw()
end

function love.keypressed(key, scancode, isrepeat)
end

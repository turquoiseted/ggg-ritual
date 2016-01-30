require "lib.lm.Animation.Animation"

require "player"
require "elder"
require "HUD"
require "enemy"
require "nymph"

ENTITY_SPEED_MULTIPLIER = 20 -- multiplied by an entity's speed_stat to get it's real speed in pixels

player = nil
elder = nil
world = {}
world.objects = {}
GUI_objects = {}

function love.load()
    world.secondsElapsedInDay = 0
    player = Player.new()
    elder = Elder.new()
    hud = HUD.new()

    table.insert(GUI_objects, hud)
    table.insert(world.objects, player)
    table.insert(world.objects, elder)
    local nymph = Nymph.new()
    nymph.x = 300
    nymph.y = 300
    table.insert(world.objects, nymph)
end

function love.update(dt)
    world.secondsElapsedInDay = world.secondsElapsedInDay + dt

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

    for i=1, #world.objects do
        world.objects[i]:update(dt)
    end
end

function love.draw(dt)
    for i=1, #world.objects do
        world.objects[i]:draw()
    end
    for i=1, #GUI_objects do
        GUI_objects[i]:draw()
    end
end

function love.keypressed(key, scancode, isrepeat)
end

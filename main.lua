require "lib.lm.Animation.Animation"

require "maploader"
require "gameobject"
require "speech"
require "player"
require "elder"
require "HUD"
require "enemy"
require "nymph"
require "mainMenu"

ENTITY_SPEED_MULTIPLIER = 20 -- multiplied by an entity's speed_stat to get it's real speed in pixels
SCREEN_WIDTH = 790

player = nil
elder = nil
hud = nil
world = {}
mainMenu = {}
world.objects = {}
world.map = nil
world.secondsElapsedInDay = 0
GUI = {}
GUI.objects = {}
world.next_object_id = 0


function world:add_game_object(g)
    -- Called when a new GameObject is created
    g._id = self.next_object_id
    self.next_object_id = self.next_object_id + 1
    table.insert(self.objects, g)
end

function world:remove_game_object(id)
    print("Removing game object with id: " .. id)
    for i=1, #world.objects do
        obj = world.objects[i]

        if obj._id == id then
            table.remove(world.objects, i)
            break
        end
    end
end

function love.load()
    player = Player.new()
    elder = Elder.new()
    hud = HUD.new()
    --Delete later
    mainMenu = MainMenu.new()

    world.map = Map.new("Assets/map.lua")

    table.insert(GUI.objects, hud)
    world:add_game_object(player)
    world:add_game_object(elder)

    table.insert(GUI.objects, hud)
    table.insert(world.objects, player)
    table.insert(world.objects, elder)

    local nymph = Nymph.new()
    nymph.x = 300
    nymph.y = 300
    world:add_game_object(nymph)

    elder:speak("Hello there!", 2)
end

function love.update(dt)
    mainMenu:update(dt)
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

    if love.keyboard.isDown("d") then
        --debug
    end

    if idle == true then
        player:idle()
    end

    for i=1, #world.objects do
        local obj = world.objects[i]
        obj:update(dt)
        if obj._dead then
            world:remove_game_object(obj._id)
        end
    end
end

function love.draw(dt)
    mainMenu.draw(dt)
    world.map:draw()
    for i=1, #world.objects do
        world.objects[i]:draw()
    end
    for i=1, #GUI.objects do
        GUI.objects[i]:draw()
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" then
        player:attack()
    end
end

function love.mousepressed(x, y, button, istouch)
    mainMenu.mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
    mainMenu.mousereleased(x, y, button, istouch)
end

ForestDemon = {}
setmetatable(ForestDemon, Enemy)
ForestDemon.__index = ForestDemon

function ForestDemon.new()
    local f = ForestDemon.new()
    setmetatable(f, ForestDemon)

    f.x = 0
    f.y = 0
    f.vx = 0
    f.vy = 0
    f.hp_stat = 2
    f.damage_stat = 1
    f.speed_stat = 5
    f.ai_state = "idle"
    f.animation_idle = Animation.newFromFile("Animations/enemy/forest_demon/enemy_idle.lua")
    f.animation_chasing = Animation.newFromFile("Animations/enemy/forest_demon/enemy_walking.lua")
    f.animation_hitting = Animation.newFromFile("Animations/enemy/forest_demon/enemy_hitting.lua")
    f.animation_nearby = Animation.newFromFile("Animations/enemy/forest_demon/enemy_nearby.lua")
    f.animation_hurt = Animation.newFromFile("Animations/enemy/forest_demon/enemy_hurt.lua")
    f.animation_dying = Animation.newFromFile("Animations/enemy/forest_demon/enemy_dying.lua")
    f.animation = f.animation_idle

    f.sounds = {}
    f.sounds["walking"] = love.audio.newSource("Assets/Sounds/enemy/forest_demon/walking.wav")
    f.sounds["hitting"] = love.audio.newSource("Assets/Sounds/enemy/forest_demon/hitting.wav")
    f.sounds["hurt"] = love.audio.newSource("Assets/Sounds/enemy/forest_demon/hurt.wav")
    f.sounds["dying"] = love.audio.newSource("Assets/Sounds/enemy/forest_demon/dying.wav")

    f.sounds["walking"]:setLooping(true)

    f.frames_waiting = -1  -- used for waiting to perform actions

    return f
end

function ForestDemon:get_pursuit_range()
    return 400
end

function ForestDemon:get_nearby_range()
    return 25
end


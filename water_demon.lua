WaterDemon = {}
setmetatable(WaterDemon, Enemy)
WaterDemon.__index = WaterDemon

function WaterDemon.new()
    local f = WaterDemon.new()
    setmetatable(f, WaterDemon)

    f.x = 0
    f.y = 0
    f.vx = 0
    f.vy = 0
    f.hp_stat = 2
    f.damage_stat = 2
    f.speed_stat = 4
    f.ai_state = "idle"
    f.animation_idle = Animation.newFromFile("Animations/enemy/water_demon/enemy_idle.lua")
    f.animation_chasing = Animation.newFromFile("Animations/enemy/water_demon/enemy_walking.lua")
    f.animation_hitting = Animation.newFromFile("Animations/enemy/water_demon/enemy_hitting.lua")
    f.animation_nearby = Animation.newFromFile("Animations/enemy/water_demon/enemy_nearby.lua")
    f.animation_hurt = Animation.newFromFile("Animations/enemy/water_demon/enemy_hurt.lua")
    f.animation_dying = Animation.newFromFile("Animations/enemy/water_demon/enemy_dying.lua")
    f.animation = f.animation_idle

    f.sounds = {}
    f.sounds["walking"] = love.audio.newSource("Assets/Sounds/enemy/water_demon/walking.wav")
    f.sounds["hitting"] = love.audio.newSource("Assets/Sounds/enemy/water_demon/hitting.wav")
    f.sounds["hurt"] = love.audio.newSource("Assets/Sounds/enemy/water_demon/hurt.wav")
    f.sounds["dying"] = love.audio.newSource("Assets/Sounds/enemy/water_demon/dying.wav")

    f.sounds["walking"]:setLooping(true)

    f.frames_waiting = -1  -- used for waiting to perform actions

    return f
end

function WaterDemon:get_pursuit_range()
    return 400
end

function WaterDemon:get_nearby_range()
    return 25
end


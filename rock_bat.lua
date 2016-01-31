RockBat = {}
setmetatable(RockBat, Enemy)
RockBat.__index = RockBat

function RockBat.new()
    local f = RockBat.new()
    setmetatable(f, RockBat)

    f.x = 0
    f.y = 0
    f.vx = 0
    f.vy = 0
    f.hp_stat = 4
    f.damage_stat = 2
    f.speed_stat = 4
    f.ai_state = "idle"
    f.animation_idle = Animation.newFromFile("Animations/enemy/rock_bat/enemy_idle.lua")
    f.animation_chasing = Animation.newFromFile("Animations/enemy/rock_bat/enemy_walking.lua")
    f.animation_hitting = Animation.newFromFile("Animations/enemy/rock_bat/enemy_hitting.lua")
    f.animation_nearby = Animation.newFromFile("Animations/enemy/rock_bat/enemy_nearby.lua")
    f.animation_hurt = Animation.newFromFile("Animations/enemy/rock_bat/enemy_hurt.lua")
    f.animation_dying = Animation.newFromFile("Animations/enemy/rock_bat/enemy_dying.lua")
    f.animation = f.animation_idle

    f.sounds = {}
    f.sounds["walking"] = love.audio.newSource("Assets/Sounds/enemy/rock_bat/walking.wav")
    f.sounds["hitting"] = love.audio.newSource("Assets/Sounds/enemy/rock_bat/hitting.wav")
    f.sounds["hurt"] = love.audio.newSource("Assets/Sounds/enemy/rock_bat/hurt.wav")
    f.sounds["dying"] = love.audio.newSource("Assets/Sounds/enemy/rock_bat/dying.wav")

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


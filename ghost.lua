Ghost = {}
setmetatable(Ghost, Enemy)
Ghost.__index = Ghost

function Ghost.new()
    local f = Ghost.new()
    setmetatable(f, Ghost)

    f.x = 0
    f.y = 0
    f.vx = 0
    f.vy = 0
    f.hp_stat = 3
    f.damage_stat = 2
    f.speed_stat = 8
    f.ai_state = "idle"
    f.animation_idle = Animation.newFromFile("Animations/enemy/ghost/enemy_idle.lua")
    f.animation_chasing = Animation.newFromFile("Animations/enemy/ghost/enemy_walking.lua")
    f.animation_hitting = Animation.newFromFile("Animations/enemy/ghost/enemy_hitting.lua")
    f.animation_nearby = Animation.newFromFile("Animations/enemy/ghost/enemy_nearby.lua")
    f.animation_hurt = Animation.newFromFile("Animations/enemy/ghost/enemy_hurt.lua")
    f.animation_dying = Animation.newFromFile("Animations/enemy/ghost/enemy_dying.lua")
    f.animation = f.animation_idle

    f.sounds = {}
    f.sounds["walking"] = love.audio.newSource("Assets/Sounds/enemy/ghost/walking.wav")
    f.sounds["hitting"] = love.audio.newSource("Assets/Sounds/enemy/ghost/hitting.wav")
    f.sounds["hurt"] = love.audio.newSource("Assets/Sounds/enemy/ghost/hurt.wav")
    f.sounds["dying"] = love.audio.newSource("Assets/Sounds/enemy/ghost/dying.wav")

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


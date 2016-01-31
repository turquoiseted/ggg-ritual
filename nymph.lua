Nymph = {}
setmetatable(Nymph, Enemy)
Nymph.__index = Nymph

function Nymph.new()
    local n = Enemy.new()
    setmetatable(n, Nymph)

    n._collidable = true
    n._width = 32
    n._height = 32
    n.sprite = love.graphics.newImage("Assets/_NPCS/Nymph/nymph_dead_static.png")

    return n
end

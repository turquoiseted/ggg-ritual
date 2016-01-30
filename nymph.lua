Nymph = {}
setmetatable(Nymph, Enemy)
Nymph.__index = Nymph

function Nymph.new()
    local n = Enemy.new()
    setmetatable(n, Nymph)

    n.sprite = love.graphics.newImage("Assets/nymph_static.png")

    return n
end

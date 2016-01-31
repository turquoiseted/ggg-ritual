GameObject = {}
GameObject.__index = GameObject

function GameObject.new()
    g = {}
    setmetatable(g, GameObject)

    g.x = 0
    g.y = 0
    g.vx = 0
    g.vy = 0
    g._id = nil -- set when world.add_game_object is called
    g._dead = false -- if true then will be removed by the game on update
    g._collidable = false
    g._width = 0 -- neccessary for collisions
    g._height = 0

    return g
end

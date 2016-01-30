GameObject = {}
GameObject.__index = GameObject

function GameObject.new()
    g = {}
    setmetatable(g, GameObject)

    g.x = 0
    g.y = 0
    g._id = nil -- set when world.add_game_object is called
    g._dead = false -- if true then will be removed by the game on update

    return g
end

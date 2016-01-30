GameObject = {}
GameObject.__index = GameObject

function GameObject.new()
    g = {}
    setmetatable(g, GameObject)

    g._id = nil -- set when world.add_game_object is called

    return g
end

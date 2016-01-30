Speech = {}
setmetatable(Speech, GameObject)
Speech.__index = Speech

function Speech.new(owner, text, duration)
    local s = GameObject.new()
    setmetatable(s, Speech)

    s.owner = owner
    s.text = text
    s.duration

    return s
end

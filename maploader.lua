Map = {}
Map.__index = Map

function Map.new(path)
    map = {}
    setmetatable(map, Map)

    local tiled_raw_data = loadfile(path)()
    map.tile_id_to_sprite = {}
    map.layers = {}
    map.width_in_tiles = tiled_raw_data.width
    map.height_in_tiles = tiled_raw_data.height
    map.tile_width = tiled_raw_data.tilewidth
    map.tile_height = tiled_raw_data.tileheight

    -- Populate tile_id_to_sprite
    for i=1, #tiled_raw_data.tilesets do
        local tileset = tiled_raw_data.tilesets[i]
        local tile_id = tileset.firstgid 

        if love.filesystem.exists(tileset.image) then
            local sprite = love.graphics.newImage(tileset.image)
            map.tile_id_to_sprite[tile_id] = sprite
        else
            print("Could not find tile asset for " .. tileset.name .. " (id " .. tile_id .. ")")
            map.tile_id_to_sprite[tile_id] = nil
        end
    end

    -- Populate layers
    for i=1, #tiled_raw_data.layers do
        local raw_layer = tiled_raw_data.layers[i]
        local layer = {}
        layer.name = raw_layer.name
        layer.visible = raw_layer.visible
        layer.opacity = raw_layer.opacity
        layer.data = raw_layer.data

        map.layers[i] = layer
    end

    return map
end

function Map:draw()
    for i=1, 1 do
        local layer = map.layers[i]
        
        for j=1, #layer.data do
            local tile_id = layer.data[j]
            local row = math.floor(j/self.width_in_tiles)
            local col = j % self.width_in_tiles 

            local sprite = self.tile_id_to_sprite[tile_id]
            if sprite == nil then
                --print("Map:draw no sprite with tile_id " .. tile_id)
                love.graphics.rectangle("fill", col*self.tile_width, row*self.tile_height, self.tile_width, self.tile_height)
            else
                love.graphics.draw(sprite, col*self.tile_width, row*self.tile_height)
            end
        end
    end
end

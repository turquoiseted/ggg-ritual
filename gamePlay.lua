GamePlay = {}
GamePlay.__index = GamePlay

GamePlay.tasksByDay = {{
        {"Enter the Forest", {
            {123, 28},
            {123, 29},
            {123, 30},
            {123, 31}
        }},
        {"Find the Wood Nymphs’ home", {
            {30, 38},
            {31, 38},
            {32, 38},
            {33, 38},
            {34, 38},
            {35, 38}
        }},
        {"Find a way to heal the blacksmith", {
          -- kill the nymf or touch --
           {30, 23},
           {31, 23},
           {32, 23},
           {33, 23},
           {34, 23}
        }},
        {"Return to your Elder", {
          {149, 18},
          {150, 18}
        }}
    },
    {
        {"Find the bandits at the lakeside", 0, 0},
        -- collide bandit --
        {"Clear the lakeside of bandits", 0, 0},
        -- or --
        {"Defeat the Lake King", 0, 0},
        {"Return to the bandit leader", 0, 0},

        {"Bring the ring to your Elder", {
            {149, 18},
            {150, 18}
        }}
    },{
        {"Enter the Mines", {
            {168, 69},
            {169, 69}
        }},
        {"Find the Three Witches", 0, 0},
        -- collide witches --
        {"Defeat the Three Witches", 0, 0},
        -- kill witches --
        {"Take the staff back to your Elder", {
            {149, 18},
            {150, 18}
        }}
    }
}


local secondsInDay = 5*60

function GamePlay.new()
    gamePlay = {}
    setmetatable(gamePlay, GamePlay)

    gamePlay.secondsElapsedInDay = 0
    gamePlay.day = 1

    return gamePlay
end

function GamePlay:getTaskTextAtIndex(i)
    return GamePlay.tasksByDay[self.day][i][1]
end

function GamePlay:getNumberOfTasks()
    return #GamePlay.tasksByDay[self.day]
end

function GamePlay:getTilesForTask(taskI)
    return GamePlay.tasksByDay[self.day][taskI][2]
end

function GamePlay:death()
    print("Death")
end

function GamePlay:win()
    print("You win")
end

function GamePlay:completeDay()
    --Play end day animation
    if self.day == #GamePlay.tasksByDay then
        self:win()
        return
    end
    self.day = self.day + 1
    self.secondsElapsedInDay = 0
end

function GamePlay:completeTask(taskI)
    --Play animation then
    table.remove(GamePlay.tasksByDay[self.day], taskI)
    if #GamePlay.tasksByDay[self.day] == 0 then
        self:completeDay()
    end
end

function GamePlay:update(dt)
    sX, sY = world.map:convertScreenToTile(player.x, player.y)
    sX = math.ceil(sX)
    sY = math.ceil(sY)
    for taskI=1,self:getNumberOfTasks() do
        local tilesPos = self:getTilesForTask(taskI)
        for i=1,#tilesPos do
            if sX == tilesPos[i][1] and sY == tilesPos[i][2] then
                self:completeTask(taskI)
            end
        end
    end

    gamePlay.secondsElapsedInDay = gamePlay.secondsElapsedInDay + dt
    if gamePlay.secondsElapsedInDay >  secondsInDay then
        self:death()
    end
end

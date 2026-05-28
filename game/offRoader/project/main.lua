-- https://sheepolution.com/learn/book/3
-- 12/5 love.physics can't attach chain shape well. Working on non physics implementation of checkCollision().

function love.load()
    -- fetch required files
    Object = require "classic"
    require "player"
    require "ogre"
    require "projectile"
    require "meteor"
    require "missile"
    require "missilePickup"
    require "explosion"
    require "health"
    -- initialize background
    background = love.graphics.newImage("background.jpeg")
    bgHeight = background:getHeight()
    bgWidth = background:getWidth()
    -- initialize spawning variables
    spawns = 0
    meteorCounter = 0
    -- table indicies start at 1 in Lua
    difficulty = 1
    score = 0
    -- when to increase difficulty
    scoreThresholds = {5, 15, 25, 50}
    -- how many enemies to spawn in per second, by difficulty tier
    dTiers = {1, 1.3, 1.5, 2}
    -- initialize player
    player = Player()
    -- initialize object lists
    projectileList = {}
    ogreList = {}
    meteorList = {}
    missileList = {}
    explosionList = {}
    pickupList = {}
    healthList = {}
    -- Store screen size
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    -- initialize resources
    missiles = 1
    health = 3
end

-- Check if mouse pressed
function love.mousepressed(x, y, button)
    -- execute this function in player.lua
    player:mousePressed(x, y, button)
end

-- Check if a key is pressed
function love.keypressed(key)
    -- execute this function in player.lua
    player:keyPressed(key)
end

function love.update(dt)
    -- dt meaning: https://love2d.org/wiki/dt
    -- spawn in ogres, more often as score increases
    if score >= scoreThresholds[difficulty]  and difficulty < 4 then
        difficulty = difficulty + 1
    end

    -- add to spawning variable
    spawns = spawns + dt
    if spawns >= 1/dTiers[difficulty] then
        -- spawn an ogre
        table.insert(ogreList, Ogre())
        -- reset counter
        spawns = 0
    end

    -- spawn in meteors, more often as score increases
    meteorCounter = meteorCounter + dt
    if meteorCounter >= 5/dTiers[difficulty] then
        -- spawn in meteors
        table.insert(meteorList, Meteor())
        -- reset counter
        meteorCounter = 0
    end

    -- update player
    player:update(dt)

    -- update all projectiles
    for i,v in ipairs(projectileList) do
        v:update(dt)
        -- execute this function from projectile.lua
        v:checkCollision(ogreList)
        -- if it is dead remove it
        if v.dead then
            table.remove(projectileList, i)
        end
    end

    -- update each ogre
    for i,v in ipairs(ogreList) do
        v:update(dt, player)
        -- execute this function from ogre.lua
        v:checkCollision(player)
        -- if the ogre is dead
        if v.dead then
            -- add small chance for ogres to drop a missile pickup
            if math.random(20) == 20 then
                table.insert(pickupList, MissilePickup(v.x, v.y))
            end
            -- add very small chance for ogres to drop health pickup on death
            if math.random (40) == 40 then
                table.insert(healthList, Health(v.x, v.y))
            end
            -- remove ogre
            table.remove(ogreList, i)
            -- update score
            score = score + 1
        end
    end

    -- update each meteor
    for i,v in ipairs(meteorList) do
        v:update(dt)
        -- execute this function in meteor.lua
        v:checkCollision(player)
        -- if its dead (at edge of screen)
        if v.dead then
            -- remove meteor
            table.remove(meteorList, i)
        end
    end

    -- update each active missile
    for i,v in ipairs(missileList) do
        v:update(dt)
        if v.dead then
            table.remove(missileList, i)
        end
    end
    -- update each explosion
    for i,v in ipairs(explosionList) do
        v:update(dt)
        v:checkCollision(ogreList)
        if v.dead then
            table.remove(explosionList, i)
        end
    end
    -- update each missile pickup
    for i,v in ipairs(pickupList) do
        v:update(dt)
        -- check if its close enough to the player
        v:checkCollision(player)
        -- remove picked up missile
        if v.dead then
            table.remove(pickupList, i)
        end
    end
    -- update each health pickup
    for i,v in ipairs(healthList) do
        v:update(dt)
        -- check if its close to the player
        v:checkCollision(player)
        -- remove collected health pickups
        if v.dead then
            table.remove(healthList, i)
        end
    end
    -- kill player if they have no health
    if health < 1 then
        player.dead = true
    end
    -- restart game if the player is dead
    if player.dead then
        love.load()
    end
end

function love.draw()
    -- draw the background
    love.graphics.draw(background, width/2, height/2, 0, width/bgWidth, height/bgHeight, bgWidth/2, bgHeight/2 )
    -- draw the player
    player:draw()
    -- draw each object
    for i,v in ipairs(projectileList) do
        v:draw()
    end
    for i,v in ipairs(meteorList) do
        v:draw()
    end
    for i,v in ipairs(missileList) do
        v:draw()
    end
    for i,v in ipairs(explosionList) do
        v:draw()
    end
    for i,v in ipairs(pickupList) do
        v:draw()
    end
    for i,v in ipairs(healthList) do
        v:draw()
    end
    for i,v in ipairs(ogreList) do
        v:draw()
    end
    -- string and int concatenation: https://www.lua.org/pil/3.4.html
    -- display the score
    love.graphics.print("Score: " .. score, width/2, 30)
    -- display the missiles in the player's inventory
    love.graphics.print("Missiles: " .. missiles, 3 * width/4, 30)
    -- display how many lives the player has
    love.graphics.print("Lives: " .. health, width/4, 30)

end
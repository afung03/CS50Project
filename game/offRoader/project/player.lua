-- mon, dec 6 fix blind spots on arctan movement function.

Player = Object:extend()
-- 12/5 all objects are too big see what sheepolution says
function Player:new()
    self.image = love.graphics.newImage("player.png")
    -- initialize variables
    -- spawn point
    self.x = 150
    self.y = 150
    self.direction = 0
    -- speed
    self.speed = 150
    self.halfHeight = self.image:getHeight()/2
    self.halfWidth = self.image:getWidth()/2
    self.dead = false
end

-- shoot a projectile
function Player:mousePressed(x, y, button)
    -- if left click
    if button == 1 then
        -- shoot
        table.insert(projectileList, Projectile(self.x, self.y, self.direction))
    end
    -- if right click
    if button == 2 and missiles > 0 then
        -- launch missiile
        table.insert(missileList, Missile(self.x, self.y, self.direction, love.mouse.getX()))
        -- decrease missiles in player inventory
        missiles = missiles - 1
    end
end

-- if key pressed
function Player:keyPressed(key)
    -- if it was spacebar
    if key == "space" and missiles > 0 then
        -- launch missile
        table.insert(missileList, Missile(self.x, self.y, self.direction, love.mouse.getX()))
        -- decrease missiles in player inventory
        missiles = missiles - 1
    end
end


function Player:update(dt)
    -- movement w,a,s,d
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end

    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
    elseif love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
    end

    -- prevent going out of bounds
    local xBoundary = love.graphics.getWidth()

    local yBoundary = love.graphics.getHeight()

    if self.x < 0 then
        self.x = 0
    elseif self.x > xBoundary then
        self.x = xBoundary
    end

    if self.y < 0 then
        self.y = 0
    elseif self.y > yBoundary then
        self.y = yBoundary
    end

    -- edit rotation to be in direction of mouse https://www.tutorialspoint.com/lua/lua_math_library.htm
    v = {}
    v[0] = (love.mouse.getX() - self.x)
    v[1] = (love.mouse.getY() - self.y)
    --v[0] = v[0]/math.sqrt(v[0] * v[0] + v[1] * v[1])
    --v[1] = v[1]/math.sqrt(v[0] * v[0] + v[1] * v[1])
    self.direction = math.atan2(v[1], v[0])
end

function Player:draw()
    -- dra player using direction
    love.graphics.draw(self.image, self.x, self.y, self.direction, 0.05, 0.05, self.halfWidth, self.halfHeight )
end
Ogre = Object:extend()

function Ogre:new()
    self.image = love.graphics.newImage("ogre.png")
    -- set random starter coords on edge
    -- generate 1 or 2 at random
    coinFlip = math.random(2)
    bCoinFlip = math.random(2)
    -- use results to set starter coords for ogre
    if coinFlip == 2 then
        self.x = math.random() * width
        if bCoinFlip == 2 then
            self.y = 0
        else 
            self.y = height
        end
    else
        self.y = math.random() * height
        if bCoinFlip == 2 then
            self.x = width
        else 
            self.x = 0
        end
    end
    -- initialize variables
    self.direction = 0
    self.speed = 100
    self.halfHeight = self.image:getHeight()/2
    self.halfWidth = self.image:getWidth()/2
    self.dead = false
end

function Ogre:checkCollision(obj)
    -- check 
    if math.sqrt((self.x - obj.x)^2 + (self.y - obj.y)^2) - self.halfHeight/30 - obj.halfWidth/30 <= 0 then
        -- decrease lives on collision
        health = health - 1
        -- decrease score to cancel out the increase from this ogre's death
        score = score - 1
        -- remove ogre
        self.dead = true
    end
end

function Ogre:update(dt, obj)
    -- calculate distance from player
    xDist = obj.x - self.x
    yDist = obj.y - self.y

    -- move towards player at constant speed 
    self.x = self.x + xDist/math.sqrt(xDist * xDist + yDist * yDist) * self.speed * dt
    self.y = self.y + yDist/math.sqrt(xDist * xDist + yDist * yDist) * self.speed * dt

    -- face towards the player
    self.direction = math.atan2(yDist, xDist)
end

-- draw ogre facing the player
function Ogre:draw()
    love.graphics.draw(self.image, self.x, self.y, self.direction, 0.05, 0.05, self.halfWidth, self.halfHeight)
end
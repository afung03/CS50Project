Meteor = Object:extend()

function Meteor:new()
    -- initialize image
    self.image = love.graphics.newImage("meteor.png")
    -- set random starter coords on edge
    -- generate 1 thru 4 at random
    rand = math.random(4)
    -- start top
    if rand == 1 then
        self.x = math.random() * width
        self.y = 0 
        self.direction = 0
    elseif rand == 2 then
    -- start left
        self.x = 0
        self.y = math.random() * height
        self.direction = math.pi * 1.5
    -- start bottom
    elseif rand == 3 then
        self.x = math.random() * width
        self.y = height
        self.direction = math.pi
    -- start right
    else
        self.x = width
        self.y = math.random() * height
        self.direction = math.pi / 2
    end
    -- initialize variables
    self.speed = 200
    self.halfWidth = self.image:getWidth()/2
    self.halfHeight = self.image:getHeight()/2
end

-- Found math Lua library at http://lua-users.org/wiki/MathLibraryTutorial
-- update meteor
function Meteor:update(dt)
    -- update x and y coords based on direction
    self.x = self.x - math.sin(self.direction) * dt * self.speed
    self.y = self.y + math.cos(self.direction) * dt * self.speed
end

-- draw meteor
function Meteor:draw()
    love.graphics.draw(self.image, self.x, self.y, self.direction, 0.1, 0.1, self.halfWidth, self.halfHeight)
end

function Meteor:checkCollision(obj)
    -- use pythagorean theorem to check distance
    if math.sqrt((self.x - obj.x)^2 + (self.y - obj.y)^2) - self.halfHeight/15 - obj.halfWidth/30 <= 0 then
        -- kill player on collision
        obj.dead = true
    end
end

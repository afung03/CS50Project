Missile = Object:extend()

function Missile:new(x,y,v,d)
    -- set image
    self.image = love.graphics.newImage("armed_missile.png")
    -- initialize variables
    self.speed = 500
    self.halfWidth = self.image:getWidth()/2
    self.halfHeight = self.image:getHeight()/2
    self.x = x
    self.y = y
    self.direction = v
    self.destination = d
    self.dead = false
end

-- Found math Lua library at http://lua-users.org/wiki/MathLibraryTutorial
function Missile:update(dt)
    -- change x and y abased on direction with constant speed
    self.x = self.x + math.cos(self.direction) * dt * self.speed
    self.y = self.y + math.sin(self.direction) * dt * self.speed
    -- check if its close enough to its destination
    -- there is some margin of error to make sure it fires no matter what the destination is
    if self.x <= self.destination + 5 and self.x >= self.destination - 5 then
        -- mark missile for deletion
        self.dead = true
        -- create explosion
        table.insert(explosionList, Explosion(self.x, self.y))
    end
end

-- draw the missle based on direction
function Missile:draw()
    love.graphics.draw(self.image, self.x, self.y, self.direction  + math.pi / 2, 0.1, 0.1, self.halfWidth, self.halfHeight)
end
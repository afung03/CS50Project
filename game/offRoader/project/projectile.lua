Projectile = Object:extend()

function Projectile:new(x,y,v)
    -- set image
    self.image = love.graphics.newImage("projectile.png")
    -- initialize variables
    self.x = x
    self.y = y
    self.direction = v
    self.speed = 700
    self.width = self.image:getWidth()
    self.width = self.image:getHeight()
    self.dead = false
    self.halfHeight = self.image:getHeight()/2
    self.halfWidth = self.image:getWidth()/2
end

function Projectile:update(dt)
    -- move at constant speed in given direction
    self.x = self.x + math.cos(self.direction) * self.speed * dt
    self.y = self.y + math.sin(self.direction) * self.speed * dt
end

function Projectile:draw()
    -- draw projectile using given direction
    love.graphics.draw(self.image, self.x, self.y, self.direction, 0.05, 0.05, self.halfWidth, self.halfHeight)
end

function Projectile:checkCollision(ogres)
    -- iterate over each ogre
    for i,v in ipairs(ogres) do
        -- approximates collision distance using circular hitboxes
        if math.sqrt((self.x - v.x)^2 + (self.y - v.y)^2) - self.halfHeight/20 - v.halfWidth/20 <= 0 then
            -- remove bullet and ogre on collision
            self.dead = true
            v.dead = true
        end
        -- delete projectile if it goes out of bounds
        if self.x > love.graphics.getWidth() or self.x < 0 or self.y < 0 or self.y > love.graphics.getHeight() then
            self.dead = true
        end
    end
end
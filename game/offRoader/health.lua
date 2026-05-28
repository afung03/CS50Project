Health = Object:extend()

function Health:new(x,y)
    -- set image
    self.image = love.graphics.newImage("health.png")
    -- initialize variables
    self.halfWidth = self.image:getWidth()/2
    self.halfHeight = self.image:getHeight()/2
    self.x = x
    self.y = y
    self.dead = false
end

-- empty function does nothing but maintains structure of love2d
function Health:update(dt)
end

-- draw health packy
function Health:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.05, 0.05, self.halfWidth, self.halfHeight)
end

function Health:checkCollision(obj)
    if math.sqrt((self.x - obj.x)^2 + (self.y - obj.y)^2) - self.halfHeight/30 - obj.halfWidth/30 <= 0 then
        -- pick up missile if player gets near
        if health < 3 then
            -- increase health
            health = health + 1
            -- mark this pickup for removal
            self.dead = true
        end
    end
end
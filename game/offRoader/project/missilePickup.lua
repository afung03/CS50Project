MissilePickup = Object:extend()

function MissilePickup:new(x,y)
    -- set image
    self.image = love.graphics.newImage("missile.png")
    -- initialize variables
    self.halfWidth = self.image:getWidth()/2
    self.halfHeight = self.image:getHeight()/2
    self.x = x
    self.y = y
    self.dead = false
end

-- Found math Lua library at http://lua-users.org/wiki/MathLibraryTutorial
-- empty function to preserve structure of Love2d code
function MissilePickup:update(dt)
end

-- draw missile pickup
function MissilePickup:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.05, 0.05, self.halfWidth, self.halfHeight)
end

function MissilePickup:checkCollision(obj)
    -- use pythagorean theorem to check if its close enough to the player
    if math.sqrt((self.x - obj.x)^2 + (self.y - obj.y)^2) - self.halfHeight/30 - obj.halfWidth/30 <= 0 then
        -- pickup missile if player gets near
        missiles = missiles + 1
        -- mark pickup for removal
        self.dead = true
    end
end
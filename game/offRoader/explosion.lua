Explosion = Object:extend()

function Explosion:new(x,y,v,d)
    -- set image
    self.image = love.graphics.newImage("explosion.png")
    -- intialize variables
    self.speed = 500
    self.halfWidth = self.image:getWidth()/2
    self.halfHeight = self.image:getHeight()/2
    self.x = x
    self.y = y
    self.direction = v
    self.destinyation = d
    self.dead = false
    -- set scaling variable
    self.scale = 0
end

-- Found math Lua library at http://lua-users.org/wiki/MathLibraryTutorial
function Explosion:update(dt)
    -- increase scale
    self.scale = self.scale + 0.01
    -- if the explosion is big enough, remove it
    if self.scale > 0.2 then
        self.dead = true
    end
end

function Explosion:draw()
    -- draw explosion, based on scale
    love.graphics.draw(self.image, self.x, self.y, self.direction, self.scale, self.scale, self.halfWidth, self.halfHeight)
end

function Explosion:checkCollision(ogres)
    -- iterate over list of ogres
    for i,v in ipairs(ogres) do
        -- approximates collision distance using circular hitboxes
        if math.sqrt((self.x - v.x)^2 + (self.y - v.y)^2) - self.halfHeight * self.scale - v.halfWidth/20 <= 0 then
            -- remove ogres caught in blast
            v.dead = true
        end
    end
end

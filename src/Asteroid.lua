--[[
    you can't have an asteroid clone without any asteroids!
    I got the image from pngwing.com
]]

Asteroid = Class{}

function Asteroid:init(x,y, angle, rotation, radius, stage)
    self.image = love.graphics.newImage('src/asteroid.png')
    self.x = x
    self.y = y
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.angle = angle
    self.rotation = rotation
    self.orientation = 1
    self.radius = radius
    self.stage = stage
    self.speed = ASpeed + love.math.random(-10, 10)
end

function Asteroid:update(dt)
    --movement
   self.x = (self.x + math.cos(self.angle) * self.speed * dt) % VIRTUAL_WIDTH
   self.y = (self.y + math.sin(self.angle) * self.speed *dt) % VIRTUAL_HEIGHT
   --rotation
   self.orientation = self.orientation + self.rotation * dt
    --collisions with ship
end

--now we need to break up asteroids that get shot
function Asteroid:broke(asteroid)
    a1 = Asteroid()
    a1.angle = love.math.random() * (2 * math.pi)
    a1.x = asteroid.x
    a1.y = asteroid.y
    a1.rotation = love.math.random(-2, 2)
    a1.stage = asteroid.stage + 1
    a1.radius = ARadius / a1.stage
    return a1
end


--collision detection
function Asteroid:collides(target)
    return (self.x - target.x)^2 + (self.y - target.y)^2 <= (self.radius + target.radius)^2
end

function Asteroid:render()
    love.graphics.draw(self.image, self.x, self.y, self.orientation,
    1 / self.stage, 1 / self.stage, self.width / 2 - 1, self.height / 2 - 1)
    --love.graphics.circle('fill', self.x, self.y, 1)
end

--[[
    now lets have some bullets for the space ship.
    i need to create them at the ships nose and have them travel away from the ship 
    along the angle the ship is currently facing
]]--

Bullet = Class{}

function Bullet:init(x, y, angle)
    self.x = y
    self.y = x
    self.dx = 0
    self.dy = 0
    self.angle = angle
    self.time = 1
    --radius for collision detection
    self.radius = 0.5
end


function Bullet:update(dt)
    self.x = (self.x + math.cos(self.angle) * BULLET_SPEED * dt) % VIRTUAL_WIDTH
    self.y = (self.y + math.sin(self.angle) * BULLET_SPEED * dt) % VIRTUAL_HEIGHT
    self.time = self.time - dt

end


function Bullet:render()
    love.graphics.circle('fill', self.x, self.y, 2)
   
end
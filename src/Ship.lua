-- Lets see if i can make a little space ship!

Ship = Class{}

function Ship:init()

    self.image = love.graphics.newImage('src/ship.png')
    --just print in the center for now
    self.x = VIRTUAL_WIDTH / 2
    self.y = VIRTUAL_HEIGHT / 2

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    --its gonna need to move
    self.dx = 0
    self.dy = 0

    --the ship is facing this direction
    self.angle = 0

    --radius for collision detection
    self.radius = 10
end

function Ship:update(dt)
    --turn right
    if love.keyboard.isDown('right') then
        self.angle = self.angle + TURN_SPEED * dt
        shipInPlay = true
    end

    --turn left
    if love.keyboard.isDown('left') then
        self.angle = self.angle - TURN_SPEED * dt
        shipInPlay = true
    end

    --make sure the math doesnt get screwy
    self.angle = self.angle % (2*math.pi)

    --thrust!
    if love.keyboard.isDown('up') then
        self.dx = self.dx + math.cos(self.angle) * THRUST * dt
        self.dy = self.dy + math.sin(self.angle) * THRUST * dt
        gSounds['thrust']:play()
        shipInPlay = true
    end
    self.x = (self.x + self.dx * dt) % VIRTUAL_WIDTH
    self.y = (self.y + self.dy * dt) % VIRTUAL_HEIGHT

end

function Ship:render()
--here is the ship
    love.graphics.draw(self.image, self.x, self.y, self.angle, 1, 1, self.width / 2, self.height / 2)
    --love.graphics.circle('fill', self.x, self.y, 1)
    
    --and here is the nose
    love.graphics.setColor(1, 1, 1, 255)
    love.graphics.circle('fill',
    self.x + math.cos(self.angle) * SHIP_LENGTH,
    self.y + math.sin(self.angle) * SHIP_LENGTH,
    1)

end

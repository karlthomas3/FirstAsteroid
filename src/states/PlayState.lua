--[[
    Now for the play state where (hopefully) all the fun happens
]]--

PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.ship = Ship()
    self.bullets = {}
    self.asteroids = {}
    self.timer = FIRE_RATE
    self.level = params.level
    self.lives = params.lives
    self.score = params.score
    --a counter for earning new lives
    self.nextLife = params.nextLife
    shipInPlay = false
    --Populate the starting asteroids
    for a = 1, self.level do
        a = Asteroid()
        a.angle = love.math.random() * (2 * math.pi)
        a.x = self.ship.x + math.cos(a.angle) * 400
        a.y = self.ship.y + math.sin(a.angle) * 400
        a.rotation = love.math.random(-2, 2)
        a.stage = 1
        a.radius = ARadius / a.stage
        table.insert(self.asteroids, a)
    end
end


function PlayState:update(dt)
    if gamePaused == false then
        --keep the ship updated
        self.ship:update(dt)

        --fire the cannons!
        self.timer = self.timer + dt
        if love.keyboard.isDown('space') then
            if self.timer >= FIRE_RATE then
                --each bullet starts at the ships nose
                b = Bullet()
                b.x = self.ship.x + math.cos(self.ship.angle) * SHIP_LENGTH
                b.y = self.ship.y + math.sin(self.ship.angle) * SHIP_LENGTH
                b.angle = self.ship.angle
                --add them to the table
                table.insert(self.bullets, b)
                self.timer = 0
                gSounds['bullet']:play()
            end
        end

        --keep the bullet table updated
        for bulletIndex, bullet in ipairs(self.bullets) do
            bullet:update(dt)
            if bullet.time <= 0 then
                table.remove(self.bullets, bulletIndex)
            end
        end

        --keep the asteroid table updated
        for asteroidIndex, asteroid in ipairs(self.asteroids) do
            asteroid:update(dt)

            --check the bullet table
            for bulletIndex, bullet in ipairs(self.bullets) do

                --if the asteroid hits a bullet
                if asteroid:collides(bullet) then
                    table.remove(self.bullets, bulletIndex)

                    --update the score and nextlife counter
                    self.score = self.score + 10 * asteroid.stage
                    self.nextLife = self.nextLife + 10 * asteroid.stage
                    
                    --if the score enough for a new life
                    if self.nextLife >= 1000 then
                        self.lives = self.lives + 1
                        self.nextLife = 0
                        gSounds['newLife']:play()
                    end

                    --as long as the asteroid is less than stage 4
                    if asteroid.stage < 5 then
                        --create two new random asteroids of the next stage
                        table.insert(self.asteroids, asteroid:broke(asteroid))
                        table.insert(self.asteroids, asteroid:broke(asteroid))
                        --and remove the old asteroid
                        table.remove(self.asteroids, asteroidIndex)
                    elseif asteroid.stage == 5 then
                        table.remove(self.asteroids, asteroidIndex)
                        gSounds['break']:play()

                        --check for remaining asteroids
                        if self:endCheck() then
                            gStateMachine:change('countdown', {
                                level = self.level + 1,
                                score = self.score,
                                lives = self.lives,
                                nextLife = self.nextLife
                            })
                        end
                    end
                end
            end
            --ship collision check
            if asteroid:collides(self.ship) == true then
                if shipInPlay == true then
                    gSounds['crash']:play()
                    --if lives remain, subtract one and reset location
                    if self.lives > 0 then
                        self.lives = self.lives - 1
                        self.ship.x = VIRTUAL_WIDTH / 2
                        self.ship.y = VIRTUAL_HEIGHT / 2
                        self.ship.dx = 0
                        self.ship.dy = 0
                        shipInPlay = false
                    else
                        --if not, game over
                        gSounds['over']:play()
                        gStateMachine:change('gameover', {
                            score = self.score
                            })
                    end
                end
            end
        end

    end
end

function PlayState:render()
    --make the screen wrap around
    for y = -1, 1 do
        for x = -1, 1 do
            love.graphics.origin()
            love.graphics.translate(x * VIRTUAL_WIDTH, y * VIRTUAL_HEIGHT)
            
            --display lives
            local liveSize = love.graphics.newFont(10)
            love.graphics.setFont(liveSize)
            love.graphics.printf('Lives: ' .. tostring(self.lives), 5, 5, VIRTUAL_WIDTH / 2, 'left')
            
            --display points
            love.graphics.printf('Score: ' .. tostring(self.score), 5, 5, VIRTUAL_WIDTH, 'center')
            --the ship
            self.ship:render()

            --render the bullets
            for bulletIndex, bullet in ipairs(self.bullets) do
                bullet:render()   
            end

            --render the asteroids
            for asteroidIndex, asteroid in ipairs(self.asteroids) do
                asteroid:render()
            end

            -- show 'PAUSED' WHEN PAUSED
            if gamePaused == true then
                love.graphics.setColor(1, 1, 1, 255)
                love.graphics.printf('PAUSED', 0, 120, VIRTUAL_WIDTH, 'center')
            end
        end
    end
end

function PlayState:endCheck()
    for k, asteroid in pairs(self.asteroids) do
        if asteroid then
            return false
        end
    end
    return true
end
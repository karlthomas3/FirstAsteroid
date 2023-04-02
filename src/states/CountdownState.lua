--[[
    countdown between title and start so the player isn't blindsided by rocks 
    hurtling at them through space
]]-- 

CountdownState = Class{__includes = BaseState}


function CountdownState:enter(params)
    self.count = 3
    self.timer = 0
    self.lives = params.lives
    self.score = params.score
    self.level = params.level
    self.nextLife = params.nextLife
end


function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > 1 then
        self.timer = 0
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change('play', {
                lives = self.lives,
                score = self.score,
                level = self.level,
                nextLife = self.nextLife
            })
        end
    end
end

function CountdownState:render()
    love.graphics.setFont(COUNT_SIZE)
    love.graphics.printf(tostring(self.count), 0, 120, VIRTUAL_WIDTH, 'center')
end
--[[
    A basic title screen state    
]]--

TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)
    --lets move to a countdown when they press the spacebar
    if love.keyboard.isDown('return') then
        gStateMachine:change('countdown', {
            lives = 3,
            score = 0,
            level = 1,
            nextLife = 0
        })
    end
end

function TitleScreenState:render()
    --love.graphics.setColor(1, 1, 1, 255)
    love.graphics.setFont(TEXT_SIZE)
    love.graphics.printf('Welcome to my ASTEROIDS clone', 0, 60, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Escape = quit, p to pause, arrow keys for left/right/thrust', 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('arrow keys for left/right & thrust, spacebar to shoot', 0, 120, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(COUNT_SIZE)
    love.graphics.printf('Press Enter', 0, 150, VIRTUAL_WIDTH, 'center')
end
--[[
    A game over state    
]]--

GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.score = params.score
end
function GameOverState:update(dt)
    --lets move to a countdown when they press the spacebar
    if love.keyboard.isDown('space') then
        gStateMachine:change('title')
    end
end

function GameOverState:render()
    love.graphics.setColor(1, 0, 0, 255)
    love.graphics.setFont(COUNT_SIZE)
    love.graphics.printf('Game Over', 0, 60, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 255)
    love.graphics.setFont(TEXT_SIZE)
    love.graphics.printf('I hope you liked it =)', 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Hit space to go back to title screen', 0, 150, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('You Scored: ' .. tostring(self.score), 0, 5, VIRTUAL_WIDTH, 'center')
end
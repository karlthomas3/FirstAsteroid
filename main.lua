--[[
My own little version of asteroid as i try to learn how to make a game in lua.

Inspiration and help from some tutorials @ https://simplegametutorials.github.io/love ,
https://love2d.org/wiki/Main_Page, and https://sheepolution.com/learn, as well as the first couple lectures
in cs50g which is were i found the class library used here. My compliments to Matthias Richter for hump. What a great resource!
]]--

require 'src/Dependencies'
--bacground from pngtree.com
local space = love.graphics.newImage('src/space.png')

function love.load()
    --make sure its not blurry
   love.graphics.setDefaultFilter('nearest', 'nearest')

   --give the window a title
   love.window.setTitle('MyFirstAsteroid?')

   --need rng for the asteroids
   math.randomseed(os.time())

   --set up the screen
   Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, { vsync = true, fullscreen = false, resizable = true})

   -- my first state machine
   gStateMachine = StateMachine {
    ['title'] = function() return TitleScreenState() end,
    ['countdown'] = function() return CountdownState() end,
    ['play'] = function() return PlayState() end,
    ['gameover'] = function() return GameOverState() end
   }
   gStateMachine:change('title')

   --sounds
   gSounds = {
    ['bullet'] = love.audio.newSource('src/sounds/bullet.wav', 'static'),
    ['newLife'] = love.audio.newSource('src/sounds/newLife.wav', 'static'),
    ['break'] = love.audio.newSource('src/sounds/break.wav', 'static'),
    ['thrust'] = love.audio.newSource('src/sounds/thrust.wav', 'static'),
    ['over'] = love.audio.newSource('src/sounds/gameOver.wav', 'static'),
    ['crash'] = love.audio.newSource('src/sounds/crash.wav', 'static')
   }

    love.keyboard.keysPressed = {}

    --initialized pause 
    gamePaused = false

    --timer for cannon
    timer = FIRE_RATE

end

function love.resize(w, h)
    Push:resize(w, h)
end

-- lets have an easy quit button
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    
    if key == 'escape' then
        love.event.quit()
    end
-- and a pause too
    if key == 'p' then
        if gamePaused == false then
            gamePaused = true
        else
            gamePaused = false
        end
    end
--[[
    --lets try to put in some bullets now
    if key == 'space' then
        if gamePaused == false then
            --each bullet starts at the ships nose
            b = Bullet()
            b.x = ship.x + math.cos(ship.angle) * SHIP_LENGTH
            b.y = ship.y + math.sin(ship.angle) * SHIP_LENGTH
            b.angle = ship.angle
            --add them to the table
            table.insert(bullets, b)
        end
    end
]]--
end

--keep track of which keys have been pressed
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    gStateMachine:update(dt)
end

function love.draw()
    --push for screen resizing
    Push:start()
    
    love.graphics.draw(space, 0, 0, 0, 0.5, 0.5)
    gStateMachine:render()

    Push:finish()
    --displayFPS()
end
--[[
function displayFPS()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 0, 0)
end
]]--
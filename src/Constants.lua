--[[
    All my constant variables in one handy place so i can change them without having to search
    or risk forgetting one
]]-- 

--actual window size
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 550--512
VIRTUAL_HEIGHT = 300--288

--for the ship
SHIP_LENGTH = 18
TURN_SPEED = 5
THRUST = 100

--for the bullets
BULLET_SPEED = 500
FIRE_RATE = 0.3

--for asteroids
ASpeed = 20
ARadius = 48

--font sizes
TEXT_SIZE = love.graphics.newFont(14)
ESC_SIZE  = love.graphics.newFont(10)
COUNT_SIZE = love.graphics.newFont(30)
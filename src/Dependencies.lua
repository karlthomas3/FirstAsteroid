--[[
    I'll go ahead and list all my dependencies here
]]--


-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

-- https://github.com/Ulydev/push
Push = require 'lib/push'

-- this way any constant variables can all go into one place
require 'src/Constants'

-- heres our ship
require 'src/Ship'

-- the ship has to shoot things
require 'src/Bullet'

require 'src/Asteroid'

--lets get our state machine in here
require 'src/StateMachine'

--and all our states
require 'src/states/BaseState'
require 'src/states/TitleScreenState'
require 'src/states/CountdownState'
require 'src/states/PlayState'
require 'src/states/GameOverState'

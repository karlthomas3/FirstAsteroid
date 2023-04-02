--[[
   I got the concept of a base state from Colton Ogden in the first couple CS50g lectures.  
   Basically it keeps me from having to define a bunch of empty functions in every state i write.

    While I wont bother typing it in every single .lua, 
    Colten Ogden gets credit for all my state machine work since
    I'm learning the concept on the fly almost exclusivly from his lectures
    and by studying the source code he provided for the problem sets in CS50g.

]]--

BaseState = Class{}

function BaseState:init() end
function BaseState:enter() end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:render() end
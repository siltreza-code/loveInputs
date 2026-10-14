-- This example showcases basic 2d movement using the input module.
Inputs = require "loveInputs"
Inputs.debug = true

local player = {x=200, y=200, speed=175}

function love.load()
    
end

function love.update(dt)
    if Inputs:keyDown("w") then player.y = player.y - (player.speed * dt) end
    if Inputs:keyDown("s") then player.y = player.y + (player.speed * dt) end
    if Inputs:keyDown("a") then player.x = player.x - (player.speed * dt) end
    if Inputs:keyDown("d") then player.x = player.x + (player.speed * dt) end
end

function love.draw()
    love.graphics.rectangle("fill",player.x,player.y,20,20)
end

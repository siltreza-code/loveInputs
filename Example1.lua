-- In this example, it displays if W, A, S, D are being held, and also if LMB or RMB are down.
Inputs = require "loveInputs"
Inputs.debug = true

local font = love.graphics.newFont(28)
function love.load()
    
end

function love.update(dt)
    
end

function love.draw()
    love.graphics.setFont(font)
    love.graphics.print(string.format("LMB: %s", Inputs:mouseDown("l")), 10, 20)
    love.graphics.print(string.format("RMB: %s", Inputs:mouseDown("r")), 10, 60)

    love.graphics.print(string.format("W: %s", Inputs:keyDown("w")), 10, 120)
    love.graphics.print(string.format("A: %s", Inputs:keyDown("a")), 10, 160)
    love.graphics.print(string.format("S: %s", Inputs:keyDown("s")), 10, 200)
    love.graphics.print(string.format("D: %s", Inputs:keyDown("d")), 10, 240)
end

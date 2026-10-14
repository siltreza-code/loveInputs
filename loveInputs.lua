local m = {
    keyboard = {
        down = {},
        pressed = {},
        released = {}
    },
    mouse = {
        down = {},
        pressed = {},
        released = {},
        scroll = {0, 0},
        position = {0, 0}
    },
    listeners = {
        keyboard = {
            down = {},
            pressed = {},
            released = {}
        },
        mouse = {
            down = {},
            pressed = {},
            released = {},
            scroll = {},
            position = {}
        }
    },
    debug = false
}
local random = require("utils.random")

-- keyboard
function love.keypressed(key, scancode, isrepeat)
    m.keyboard.down[key] = true

    for idx, cb in pairs(m.listeners.keyboard.down) do
        cb(key, scancode)
    end

    if not isrepeat then
        m.keyboard.pressed[key] = true

        for idx, cb in pairs(m.listeners.keyboard.pressed) do
            cb(key, scancode)
        end

        if m.debug then
            print(string.format("Key %s pressed", key))
        end
    end
end

function love.keyreleased(key, scancode)
    m.keyboard.down[key] = false

    m.keyboard.released[key] = true
    for idx, cb in pairs(m.listeners.keyboard.released) do
        cb(key, scancode)
    end

    if m.debug then
        print(string.format("Key %s released", key))
    end
end

-- mouse
local mouseButtons = {"l", "r", "m", "x1", "x2"}
function love.mousepressed(x, y, button)
    button = mouseButtons[button]

    m.mouse.down[button] = true
    for idx, cb in pairs(m.listeners.mouse.down) do
        cb(x, y, button)
    end

    m.mouse.pressed[button] = true
    for idx, cb in pairs(m.listeners.mouse.pressed) do
        cb(x, y, button)
    end

    if m.debug then
        print(string.format("Mouse %s pressed", button))
    end
end

function love.mousereleased(x, y, button)
    button = mouseButtons[button]

    m.mouse.down[button] = false
    
    m.mouse.released[button] = true
    for idx, cb in pairs(m.listeners.mouse.released) do
        cb(x, y, button)
    end

    if m.debug then
        print(string.format("Mouse %s released", button))
    end
end

function love.mousemoved(x, y, dx, dy)
    m.mouse.position = {x, y}
    for idx, cb in pairs(m.listeners.mouse.position) do
        cb(dx, dy)
    end
end

function love.wheelmoved(x, y)
    m.mouse.scroll = {x, y}
    for idx, cb in pairs(m.listeners.mouse.scroll) do
        cb(x, y)
    end
end

-- call this at the end of update code
function m:update()
    -- keyboard
    for idx, val in pairs(self.keyboard.pressed) do
        self.keyboard.pressed[idx] = false
    end
    for idx, val in pairs(self.keyboard.released) do
        self.keyboard.released[idx] = false
    end

    -- mouse
    for idx, val in pairs(self.mouse.pressed) do
        self.mouse.pressed[idx] = false
    end
    for idx, val in pairs(self.mouse.released) do
        self.mouse.released[idx] = false
    end
    self.mouse.scroll = {0, 0}
end

-- listeners
local function addListener(list, cb)
    local newUUID = random:genUUID4()
    list[newUUID] = cb

    local funcs = {}
    function funcs:remove()
        list[newUUID] = nil
    end
    return funcs, newUUID
end

function m:onKeyDown(cb) return addListener(self.listeners.keyboard.down, cb) end
function m:onKeyPress(cb) return addListener(self.listeners.keyboard.pressed, cb) end
function m:onKeyRelease(cb) return addListener(self.listeners.keyboard.released, cb) end

function m:onMouseMove(cb) return addListener(self.listeners.mouse.position, cb) end
function m:onMouseScroll(cb) return addListener(self.listeners.mouse.scroll, cb) end
function m:onMouseDown(cb) return addListener(self.listeners.mouse.down, cb) end
function m:onMousePress(cb) return addListener(self.listeners.mouse.pressed, cb) end
function m:onMouseRelease(cb) return addListener(self.listeners.mouse.released, cb) end

-- returns
function m:keyDown(key) return self.keyboard.down[key] == true end
function m:keyPressed(key) return self.keyboard.pressed[key] == true end
function m:keyReleased(key) return self.keyboard.released[key] == true end

function m:mouseDown(btn) return self.mouse.down[btn] == true end
function m:mousePressed(btn) return self.mouse.pressed[btn] == true end
function m:mouseReleased(btn) return self.mouse.released[btn] == true end
function m:mousePosition() return self.mouse.position end
function m:mouseWheel() return self.mouse.scroll end

return m
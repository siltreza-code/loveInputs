# loveInputs

A lightweight input-handling library for [LÖVE2D](https://love2d.org/). Provides a simple interface for detecting keyboard and mouse input, tracking input states, and registering input listeners.

## Features

- Detect keyboard key presses, releases, and held states.
- Detect mouse button presses, releases, and held states.
- Retrieve mouse position and scroll-wheel input.
- Register callbacks for keyboard and mouse events.
- Remove registered listeners when they're no longer needed.
- Simple, easy-to-use API.

## Requirements

- **LÖVE 11.5** — other versions have not been tested.
- **`random.lua`** — a required dependency included in this repository.

## Installation

1. Download [`loveInputs.lua`](loveInputs.lua) and [`random.lua`](random.lua) from this repository.
2. Place both files in your LÖVE2D project.
3. Import the library wherever you need it.

**As a local variable:**

```lua
local loveInputs = require("loveInputs")
```

**As a global variable:**

```lua
LoveInputs = require("loveInputs")
```

The examples below use a global variable named `Inputs`, but you can choose whichever name you prefer.

## Quick Start

The following examples demonstrate how to use `loveInputs` in a LÖVE2D project.

### Example 1: Checking Input States

[`Example1.lua`](Example1.lua)

This example displays whether the left and right mouse buttons and the W, A, S, and D keys are currently held down.

```lua
Inputs = require("loveInputs")
Inputs.debug = true

local font = love.graphics.newFont(28)

function love.draw()
    love.graphics.setFont(font)

    love.graphics.print(
        string.format("LMB: %s", Inputs:mouseDown("l")),
        10, 20
    )

    love.graphics.print(
        string.format("RMB: %s", Inputs:mouseDown("r")),
        10, 60
    )

    love.graphics.print(
        string.format("W: %s", Inputs:keyDown("w")),
        10, 120
    )

    love.graphics.print(
        string.format("A: %s", Inputs:keyDown("a")),
        10, 160
    )

    love.graphics.print(
        string.format("S: %s", Inputs:keyDown("s")),
        10, 200
    )

    love.graphics.print(
        string.format("D: %s", Inputs:keyDown("d")),
        10, 240
    )
end
```

### Example 2: Basic 2D Movement

[`Example2.lua`](Example2.lua)

This example demonstrates how to use keyboard input to move a player around a 2D space.

```lua
Inputs = require("loveInputs")
Inputs.debug = true

local player = {
    x = 200,
    y = 200,
    speed = 175
}

function love.update(dt)
    if Inputs:keyDown("w") then
        player.y = player.y - player.speed * dt
    end

    if Inputs:keyDown("s") then
        player.y = player.y + player.speed * dt
    end

    if Inputs:keyDown("a") then
        player.x = player.x - player.speed * dt
    end

    if Inputs:keyDown("d") then
        player.x = player.x + player.speed * dt
    end
end

function love.draw()
    love.graphics.rectangle(
        "fill",
        player.x, player.y,
        20, 20
    )
end
```

## API Reference

The following functions are available through the `loveInputs` module.

### Keyboard

| Function | Description |
|---|---|
| `keyDown(key)` | Returns whether a key is currently held down. |
| `keyPressed(key)` | Returns whether a key was pressed during the current frame. |
| `keyReleased(key)` | Returns whether a key was released during the current frame. |

**Example:**

```lua
if loveInputs:keyPressed("space") then
    print("Space was pressed!")
end

if loveInputs:keyDown("w") then
    print("W is being held down.")
end
```

### Mouse

| Function | Description |
|---|---|
| `mouseDown(button)` | Returns whether a mouse button is currently held down. |
| `mousePressed(button)` | Returns whether a mouse button was pressed during the current frame. |
| `mouseReleased(button)` | Returns whether a mouse button was released during the current frame. |
| `mousePosition()` | Returns the current mouse position. |
| `mouseWheel()` | Returns the mouse scroll-wheel values. |

Mouse button arguments:

- `"l"` — Left mouse button.
- `"r"` — Right mouse button.
- `"m"` — Middle mouse button.

**Examples:**

```lua
if loveInputs:mousePressed("l") then
    print("Left mouse button clicked!")
end

local x, y = loveInputs:mousePosition()
local wheelX, wheelY = loveInputs:mouseWheel()
```

### Listeners

Listeners allow you to register callback functions that respond to input events.

| Function | Description |
|---|---|
| `onKeyDown(cb)` | Registers a keyboard key-down callback. |
| `onKeyPress(cb)` | Registers a keyboard key-press callback. |
| `onKeyRelease(cb)` | Registers a keyboard key-release callback. |
| `onMouseMove(cb)` | Registers a mouse-movement callback. |
| `onMouseScroll(cb)` | Registers a mouse-scroll callback. |
| `onMouseDown(cb)` | Registers a mouse-button-down callback. |
| `onMousePress(cb)` | Registers a mouse-button-press callback. |
| `onMouseRelease(cb)` | Registers a mouse-button-release callback. |

Replace `cb` with your callback function.

**Example:**

```lua
local listener = loveInputs:onKeyPress(function(key)
    print("Key pressed:", key)
end)
```

The callback arguments depend on the event and the library's implementation.

#### Removing Listeners

Each listener returns a listener object with a `remove()` method, allowing you to unregister it when it's no longer needed.

```lua
listener:remove()
```

This is useful when an input listener should only be active for a specific part of your game, such as a menu or gameplay state.

## License

This project is licensed under the [MIT License](LICENSE).

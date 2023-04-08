import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "blocks"
import "die"

local pd <const> = playdate
local gfx <const> = pd.graphics

dieA = Die(70, 160)
dieB = Die(180, 160)

local function initialize()
end

local function addRolls(a, b)
    local value1 = a.value
    local value2 = b.value
    local total
    
    total = value1 + value2
    print("roll total:" .. total)
    return total
end

function playdate.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
    if dieA.enabled == false then 
        addRolls(dieA, dieB)
        dieA.enabled = true
        dieB.enabled = true
    end
end

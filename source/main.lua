import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "blocks"
import "die"
import "scoring"

local pd <const> = playdate
local gfx <const> = pd.graphics

dieA = Die(70, 180)
dieB = Die(180, 180)
generateBlocks(30, 50, 9)

local function initialize()
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
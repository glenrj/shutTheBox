import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "blocks"
import "die"

local pd <const> = playdate
local gfx <const> = pd.graphics

Die(70, 140)
Die(200, 140)

local function initialize()
end

function playdate.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end
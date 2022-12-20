import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "numbers"

local pd <const> = playdate
local gfx <const> = pd.graphics

local function initialize()
end

function playdate.update()
    updateNumbers()
    gfx.sprite.update()
    pd.timer.updateTimers()
end

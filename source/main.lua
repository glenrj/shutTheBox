import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "blocks"

local pd <const> = playdate
local gfx <const> = pd.graphics

local function initialize()
end

function playdate.update()
    updateBlocks()
    gfx.sprite.update()
    pd.timer.updateTimers()
end

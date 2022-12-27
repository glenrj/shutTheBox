import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "blocks"
import "die"

local pd <const> = playdate
local gfx <const> = pd.graphics

Die(70, 160)
-- Die(180, 160)

local function initialize()
end

function playdate.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
    Die:update()
end
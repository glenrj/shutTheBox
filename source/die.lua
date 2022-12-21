local pd <const> = playdate
local gfx <const> = pd.graphics

class('Die').extends(gfx.sprite)

function Die:init(x, y)
    local width = 120
    local height = 120
    local dieImage = gfx.image.new(width, height)
    gfx.pushContext(dieImage)
        gfx.drawRoundRect(0, 0, width, height, 4)
    gfx.popContext()
    self:setImage(dieImage)

    self:moveTo(x, y)
    self:add()
end

function Die:update()
end
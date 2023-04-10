-- import "CoreLibs/object"
import "CoreLibs/graphics"
-- import "CoreLibs/sprites"
-- import "CoreLibs/timer"
-- import "CoreLibs/ui"
-- import "CoreLibs/crank"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Block').extends(gfx.sprite)

function Block:init(x, y, w, h, num)
    self.value = num
    self.selected = false
    self.available = true
    
    self:drawBlock(w, h, num)
    self:moveTo(x, y)
    self:add()
end

function Block:drawBlock(w, h, num)
    local blockImage = gfx.image.new(w, h)
    gfx.pushContext(blockImage)
        gfx.drawRoundRect(0, 0, w, h, 4)
        gfx.drawTextAligned(num, w/2, h/2, kTextAlignment.center)
    gfx.popContext()
    self:setImage(blockImage)

    print("block " .. num .. " drawn.")
end

function generateBlocks(x, y, blocks)
    local totalWidth =  360
    local blockWidth = (totalWidth / blocks)
    local blockHeight = 80

    for i = 0, blocks - 1, 1 do
        local blockX = x + (i * blockWidth) + (i * 2)
        local blockNum = i + 1
        Block(blockX, y, blockWidth, blockHeight, blockNum)
    end
end
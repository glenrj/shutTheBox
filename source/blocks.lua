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
    self.num = num
    
    self:drawBlock(w, h, num)
    self:moveTo(x, y)
    self:add()
end

function Block:drawBlock(w, h, num)
    local blockImage = gfx.image.new(w, h)
    gfx.pushContext(blockImage)
        if blockStatus[num] == "available" then
            gfx.drawRoundRect(0, 0, w, h, 4)
            gfx.drawTextAligned(num, w/2, h/2, kTextAlignment.center)
            prevBlockStatus[num] = "available"
        elseif blockStatus[num] == "unavailable" then
            gfx.fillRoundRect(0, 0, w, h, 4)
            gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
            gfx.drawTextAligned(num, w/2, h/2, kTextAlignment.center)
            gfx.setImageDrawMode(gfx.kDrawModeCopy)
            prevBlockStatus[num] = "unavailable"
        elseif blockStatus[num] == "used" then
            gfx.fillRoundRect(0, 0, w, h, 4)
            prevBlockStatus[num] = "used"
        end
    gfx.popContext()
    self:setImage(blockImage)
end

function generateBlocks(x, y, blocks)
    local totalWidth =  360
    blockWidth = (totalWidth / blocks)
    blockHeight = 80
    blockY = y
    startingBlockX = x
    blockStatus, prevBlockStatus = {}, {}

    for i = 0, blocks - 1, 1 do
        local blockX = x + (i * blockWidth) + (i * 2)
        local blockNum = i + 1
        blockStatus[blockNum], prevBlockStatus[blockNum] = "available", "available"
        Block(blockX, y, blockWidth, blockHeight, blockNum)
    end
end

function Block:update()
    for i = 1, #blockStatus, 1 do
        if blockStatus[i] ~= prevBlockStatus[i] then
            print("block ".. i .." is now " ..blockStatus[i])
            if self.num == i then
                self:drawBlock(blockWidth, blockHeight, i)
            end
       end
    end
end
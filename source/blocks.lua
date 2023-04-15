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
end

function Block:drawUnavailableBlock(w, h, num)
    local blockImage = gfx.image.new(w, h)
    gfx.pushContext(blockImage)
        gfx.fillRoundRect(0, 0, w, h, 4)
        -- gfx.setDrawMode(kDrawModeFillWhite)
        gfx.drawTextAligned(num, w/2, h/2, kTextAlignment.center)
        -- gfx.setDrawMode(kDrawModeCopy)
    gfx.popContext()
    self:setImage(blockImage)
end

function generateBlocks(x, y, blocks)
    local totalWidth =  360
    blockWidth = (totalWidth / blocks)
    blockHeight = 80
    blockStatus = {}
    prevBlockStatus = {}

    for i = 0, blocks - 1, 1 do
        local blockX = x + (i * blockWidth) + (i * 2)
        local blockNum = i + 1
        blockStatus[blockNum] = "available"
        prevBlockStatus[blockNum] = "available"
        Block(blockX, y, blockWidth, blockHeight, blockNum)
    end
end

function Block:update()
    for i = 1, #blockStatus, 1 do
        if prevBlockStatus[i] ~= blockStatus[i] then
            print("blockStatus ".. i .." = " ..blockStatus[i])
            if blockStatus[i] == "available" then
                self:drawBlock(blockWidth, blockHeight, i)
            elseif blockStatus[i] == "unavailable" then
                self:drawUnavailableBlock(blockWidth, blockHeight, i)
                prevBlockStatus[i] = "unavailable"
            end
        end
        --if its selected add navigational controls & draw style
        --if its unavailable draw that style
        --if it's available draw that style
        --if its pending draw that style
    end
end
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"
import "CoreLibs/crank"
-- import "CoreLibs/nineslice"

local pd <const> = playdate
local gfx <const> = pd.graphics

local gridview = pd.ui.gridview.new(32, 48)

local blocks = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}

gridview:setNumberOfRows(1)
gridview:setNumberOfColumns(#blocks)
gridview:setCellPadding(2, 2, 2, 2)

-- gridview.backgroundImage = gfx.nineSlice.new("images/gridBackground", 7, 7, 18, 18)
-- gridview:setContentInset(5, 5, 5, 5)

local gridViewSprite = gfx.sprite.new()
gridViewSprite:setCenter(0, 0)
gridViewSprite:moveTo(32, 8)
gridViewSprite:add()

function gridview:drawCell(section, row, column, selected, x, y, width, height)
    if selected then
        gfx.fillRoundRect(x, y, width, height, 4)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    else
        gfx.drawRoundRect(x, y, width, height, 4)
        gfx.setImageDrawMode(gfx.kDrawModeCopy)
    end
    local fontHeight = gfx.getSystemFont():getHeight()
    gfx.drawTextInRect(blocks[column], x, y + (height/2) - fontHeight/2 + 2, width, height, nil, nil, kTextAlignment.center)
end

function updateBlocks()
    if pd.buttonJustPressed(pd.kButtonLeft) then
        gridview:selectPreviousColumn(true)
    elseif pd.buttonJustPressed(pd.kButtonRight) then
        gridview:selectNextColumn(true)
    end

    local crankTicks = pd.getCrankTicks(2)
    if crankTicks == 1 then
        gridview:selectNextColumn(true)
    elseif crankTicks == -1 then
        gridview:selectPreviousColumn(true)
    end

    if gridview.needsDisplay then
        local gridviewImage = gfx.image.new(336, 64)
        gfx.pushContext(gridviewImage)
            gridview:drawInRect(0, 0, 336, 64)
        gfx.popContext()
        gridViewSprite:setImage(gridviewImage)
    end

    gfx.sprite.update()
end

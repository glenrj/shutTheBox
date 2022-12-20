import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"
import "CoreLibs/crank"
import "CoreLibs/nineslice"

local pd <const> = playdate
local gfx <const> = pd.graphics

local gridview = pd.ui.gridview.new(0, 32)

local numbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}

gridview:setNumberOfColumns(#numbers)
gridview:setCellPadding(2, 2, 2, 2)

gridview.backgroundImage = gfx.nineSlice.new("images/gridBackground", 7, 7, 18, 18)
gridview:setContentInset(5, 5, 5, 5)

local gridViewSprite = gfx.sprite.new()
gridViewSprite:setCenter(0, 0)
gridViewSprite:moveTo(100, 70)
gridViewSprite:add()

function gridview:drawCell(section, row, column, selected, x, y, width, height)
    if selected then
        gfx.fillRoundRect(x, y, width, height, 4)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    else
        gfx.setImageDrawMode(gfx.kDrawModeCopy)
    end
    local fontHeight = gfx.getSystemFont():getHeight()
    gfx.drawTextInRect(numbers[columns], x, y + (height/2) - fontHeight/2 + 2, width, height, nil, nil, kTextAlignment.center)
end

function pd.update()
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
        local gridviewImage = gfx.image.new(200, 100)
        gfx.pushContext(gridviewImage)
            gridview:drawInRect(0, 0, 200, 100)
        gfx.popContext()
        gridViewSprite:setImage(gridviewImage)
    end

    gfx.sprite.update()
    pd.timer.updateTimers()
end

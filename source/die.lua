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

    self.value = 1
end

function Die:roll()
    local roll = math.random(6)
    self.value = roll
    print(self.value)
end

function Die:update()
    if pd.buttonJustPressed(pd.kButtonA) then
        Die:roll()
        print("click")
    end
end
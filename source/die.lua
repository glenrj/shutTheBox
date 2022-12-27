local pd <const> = playdate
local gfx <const> = pd.graphics

class('Die').extends(gfx.sprite)

function Die:init(x, y)
    local width = 100
    local height = 100
    
    dieImage = gfx.image.new(width, height)
    self.value = 1
    
    gfx.pushContext(dieImage)
        gfx.drawRoundRect(0, 0, width, height, 4)
    gfx.popContext()
    self:setImage(dieImage)
    
    backgroundImage = gfx.image.new("images/pip-" .. self.value)
    assert(backgroundImage)

    gfx.sprite.setBackgroundDrawingCallback(
        function(x, y, width, height)
            gfx.pushContext(dieImage)
                    backgroundImage:draw(0, 0)
            gfx.popContext()
        end
    )
    
    self:moveTo(x, y)
    self:add()
end

function Die:roll()
    local roll = math.random(6)
    self.value = roll
    -- print(self.value)

    backgroundImage = gfx.image.new("images/pip-" .. self.value)
    self.redrawBackground()
end

function Die:update()
    if pd.buttonJustPressed(pd.kButtonA) then
        self:roll()
    end
end
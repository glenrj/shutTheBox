local pd <const> = playdate
local gfx <const> = pd.graphics

class('Die').extends(gfx.sprite)

function Die:init(x, y)
    self.value = 1
    self.enabled = true
    self:drawDie(self.value)
    
    self:moveTo(x, y)
    self:add()
end

function Die:roll()
    local roll = math.random(6)
    self.value = roll
    self:drawDie(self.value)
    self.enabled = false
end

function Die:drawDie(value)
    local width = 100
    local height = 100
    local dieImage = gfx.image.new(width, height)
    gfx.pushContext(dieImage)
      gfx.drawRoundRect(0, 0, width, height, 4)
      local backgroundImage = gfx.image.new("images/pip-" .. value)
      backgroundImage:draw(0, 0)
    gfx.popContext()
    self:setImage(dieImage)
end

function Die:update()
    if self.enabled then
        if pd.buttonJustPressed(pd.kButtonA) then
            self:roll()
            --testing block status listener
            blockStatus[4] = "unavailable"
        end
    end
end
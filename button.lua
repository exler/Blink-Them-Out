local class = require 'libs/middleclass'

Button = class('Button')

function Button:initialize(x, y, w, h, text, onPress, id)
    -- constants
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.text = text
    self.onPress = onPress

    -- variables
    self.mouseHover = false
    self.alpha = 0
end

function Button:update(dt)
    -- determine whether mouse is hovering over button
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()

    self.mouseHover = mouseX > self.x and mouseX < self.x + self.w and mouseY > self.y and mouseY < self.y + self.h

    if self.mouseHover then
        self.alpha = self.alpha + 255 * 9 * dt
    else
        self.alpha = self.alpha - 255 * 9 * dt
    end

    if self.alpha < 0 then
        self.alpha = 0
    elseif self.alpha > 255 then
        self.alpha = 255
    end

    -- button pressed
    if self.mouseHover and love.mouse.isDown(1) then
        self.onPress()
    end
end

function Button:draw()
    if not self.mouseOver then
        setColor(self.colorid, 2, self.alpha)
        love.graphics.roundrectangle("fill", self.x - 8, self.y, self.w + 14, self.h + 1, 8)
        love.graphics.setColor(whiteColor.r, whiteColor.g, whiteColor.b)
        love.graphics.print(self.text, self.x, self.y)
    else
        setColor(self.colorid, 2, self.alpha)
        love.graphics.roundrectangle("fill", self.x - 8, self.y, self.w + 14, self.h + 1, 8)
        love.graphics.setColor(blackColor.r, blackColor.g, blackColor.b)
        love.graphics.print(self.text, self.x, self.y)
    end
end

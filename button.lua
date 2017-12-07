local class = require "libs/middleclass"

Button = class("Button")

function Button:initialize(x, y, w, h, text, onPress)
    -- constants
    self.x = x - w / 2
    self.y = y - h / 2
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
    love.graphics.setColor(237, 207, 33, self.alpha)
    love.graphics.rectangle("fill", self.x - 8, self.y, self.w + 14, self.h + 1, 8)
    if not self.mouseHover then
        love.graphics.setColor(whiteColor.r, whiteColor.g, whiteColor.b)
        love.graphics.print(self.text, self.x, self.y)
    else
        love.graphics.setColor(blackColor.r, blackColor.g, blackColor.b)
        love.graphics.print(self.text, self.x, self.y)
    end

    -- reset color
    love.graphics.setColor(whiteColor.r, whiteColor.g, whiteColor.b)
end

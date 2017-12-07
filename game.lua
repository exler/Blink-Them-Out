local class = require 'libs/middleclass'
local stateful = require 'libs/stateful'

-- game class
Game = class('Game')
Game:include(stateful)

function Game:initialize(state)
    self.blinked = false
    self.won = false

    self:gotoState(state)

    self.scores = {0, 0}
end

-- start state
Start = Game:addState('Start')

function Start:enteredState()
    self.playButton = Button:new(centerX - 15, centerY - 15, 50, 37, 'Play', function() game:gotoState('Play') end, 1)
    self.quitButton = Button:new(centerX - 15, centerY + 50, 50, 37, 'Quit', function() love.event.quit() end, 2)
end

function Start:update(dt)
    self.playButton:update(dt)
    self.quitButton:update(dt)
end

function Start:draw()
    love.graphics.draw(backgroundImg, 0, 0)
    love.graphics.draw(ryzareLogo, 12, 12)
    
    self.playButton:draw()
    self.quitButton:draw()
end
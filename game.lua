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
    love.graphics.draw(ryzareLogo, windowWidth - ryzareLogo:getWidth() - 12, windowHeight - ryzareLogo:getHeight() - 12)

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(titleImg, windowWidth/2 - titleImg:getWidth()/2, 200)
    love.graphics.setColor(237, 207, 33, 255)
    love.graphics.draw(titleImg, windowWidth/2 - titleImg:getWidth()/2 + 3 , 203)
    
    self.playButton:draw()
    self.quitButton:draw()
end

function Start:exitedState()
end

-- play state
Play = Game:addState('Play')

function Play:enteredState()
end


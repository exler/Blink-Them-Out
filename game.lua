local class = require 'libs/middleclass'
local stateful = require 'libs/stateful'

-- game class
Game = class('Game')
Game:include(stateful)

function Game:initialize(state)
    self.blinked = false
    self.won = false

    self:gotoState(state)

    self.scoreLeft = 0
    self.scoreRight = 0
end

-- start state
Start = Game:addState('Start')

function Start:enteredState()
    self.playButton = Button:new(centerX - 15, centerY - 15, 50, 37, 'Play', function() game:gotoState('Play') end)
    self.helpButton = Button:new(centerX - 15, centerY + 50, 50, 37, 'Help', function() game:gotoState('Help') end)
    self.quitButton = Button:new(centerX - 15, centerY + 115, 50, 37, 'Quit', function() love.event.quit() end)
end

function Start:update(dt)
    self.playButton:update(dt)
    self.helpButton:update(dt)
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
    self.helpButton:draw()
    self.quitButton:draw()
end

function Start:exitedState()
end

-- help state
Help = Game:addState('Help')

function Help:enteredState()
    self.backButton = Button:new(centerX - 15, centerY + 200, 50, 37, 'Back', function() game:gotoState('Start') end)
end

function Help:update(dt)
    self.backButton:update(dt)
end

function Help:draw()
    love.graphics.draw(backgroundImg, 0, 0)

    -- draw controls
    love.graphics.rectangle('line', 70, centerY, 120, 50, 2)
    love.graphics.rectangle('line', windowWidth - 190, centerY, 120, 50, 2)
    love.graphics.print('L CTRL', 80, centerY + 15)
    love.graphics.print('R CTRL', windowWidth - 180, centerY + 15)

    -- help info
    love.graphics.print('Blink when you see a monster', centerX - 220, centerY)
    love.graphics.print('Watch out for the cute creatures', centerX - 220, centerY + 50)
    love.graphics.draw(scaryImgs[4], centerX + 140, centerY - 32, 0, 0.2, 0.2)
    love.graphics.draw(sweetImgs[2], centerX + 180, centerY + 16, 0, 0.2, 0.2)

    self.backButton:draw()
end

-- play state
Play = Game:addState('Play')

function Play:enteredState()
    self.roundBeginTimer = 3
    self.timeToTie = 2

    -- shuffle twice each for better results!
    shuffle(scaryImgs)
    shuffle(sweetImgs)
    shuffle(scaryImgs)
    shuffle(sweetImgs)
end

function Play:update(dt)
end

function Play:draw()
    love.graphics.draw(backgroundImg, 0, 0)

    -- print scores
    love.graphics.print('Score: ' .. self.scoreLeft, 8, 6)
    love.graphics.print('Score: ' .. self.scoreRight, windowWidth - 104, 6)
end

function Play:exitedState()
end
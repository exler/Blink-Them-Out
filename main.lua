Class = require 'lib/middleclass'

-- global variables
leftPlayer = {x = 104, y = 135, img = nil}
leftPlayerScore = 0
leftPlayerWin = false
leftEarlyPress = false

rightPlayer = {x = 224, y = 135, img = nil}
rightPlayerScore = 0
rightPlayerWin = false
rightEarlyPress = false

function love.load()
    -- load font
    font = love.graphics.newFont('fonts/Phantex.ttf')
    love.graphics.setFont(font)

    -- load sfx

    -- load gfx
    leftPlayer.img = 'gfx/leftPlayer.png'
    rightPlayer.img = 'gfx/rightPlayer.png'

end

function love.update(dt)

end

function love.draw()
    love.graphics.setBackgroundColor(255, 255, 255)

    love.graphics.rectangle('fill', 100, 300, )
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
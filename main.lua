require 'game'
require 'button'

function love.load()
    math.randomseed(os.time())

    -- window size
    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getHeight()
    centerX = windowWidth/2
    centerY = windowHeight/2

    -- load font
    font = love.graphics.newFont("fonts/Phantex.ttf", 40)
    love.graphics.setFont(font)

    -- load sprites
    backgroundImg = love.graphics.newImage('gfx/bg.png')
    ryzareLogo = love.graphics.newImage('gfx/ryzare-logo.png')
    titleImg = love.graphics.newImage('gfx/title.png')
    -- [[eyes states sprites]]
    leftPlayerImg = love.graphics.newImage('gfx/leftPlayer.png')
    leftBlinkImg = love.graphics.newImage('gfx/leftBlink.png')
    leftDeadImg = love.graphics.newImage('gfx/leftDead.png')
    rightPlayerImg = love.graphics.newImage('gfx/rightPlayer.png')
    rightBlinkImg = love.graphics.newImage('gfx/rightBlink.png')
    rightDeadImg = love.graphics.newImage('gfx/rightDead.png')

    -- load audio
    backgroundMusic = love.audio.newSource('sfx/bg.mp3')
    backgroundMusic:setLooping(true)
    backgroundMusic:play()

    -- set colors
    whiteColor = {r=220, g=220, b=230}
    blackColor = {r=25, g=25, b=33}

    game = Game:new('Start')
end

function love.update(dt)
    -- update game
    game:update(dt)
end

function love.draw()
    -- draw game
    game:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
require 'game'
require 'button'
require 'misc'
Timer = require 'libs/timer'

function love.load()
    math.randomseed(os.time())
    love.math.setRandomSeed(love.timer.getTime())

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
    -- [[monsters/sweet images]]
    scaryImgs = {
        love.graphics.newImage('gfx/scary1.png'),
        love.graphics.newImage('gfx/scary2.png'),
        love.graphics.newImage('gfx/scary3.png'),
        love.graphics.newImage('gfx/scary4.png'),
        love.graphics.newImage('gfx/scary5.png')
    }
    sweetImgs = {
        love.graphics.newImage('gfx/sweet1.png'),
        love.graphics.newImage('gfx/sweet2.png')
    }

    -- load audio
    backgroundMusic = love.audio.newSource('sfx/bg.mp3')
    backgroundMusic:setLooping(true)
    backgroundMusic:play()

    blinkSound = love.audio.newSource('sfx/blink.wav')

    -- set colors
    whiteColor = {r=220, g=220, b=230}
    blackColor = {r=25, g=25, b=33}

    game = Game:new('Start')
end

function love.update(dt)
    -- update game
    game:update(dt)

    -- update timer
    Timer.update(dt)
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
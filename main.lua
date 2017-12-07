require 'game'

function love.load()
    math.randomseed(os.time())

    -- native window size
    nativeWindowWidth = 600
    nativeWindowHeight = 400

    -- load font
    font = love.graphics.newFont("fonts/Phantex.ttf", 30)
    love.graphics.setFont(font)

    -- load sprites
    love.graphics.setDefaultFilter('nearest', 'nearest', 1)
    backgroundImg = love.graphics.newImage('gfx/bg.png')
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

    game = Game:new('Start')
end
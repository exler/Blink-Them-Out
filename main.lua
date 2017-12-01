-- 3rd party
Anim = require "lib/anim8"

-- global variables
gameStart = false

leftPlayer = {x = -12, y = 160, img = nil}
leftPlayerScore = 0
leftPlayerWin = false
leftEarlyPress = false

rightPlayer = {x = 580, y = 160, img = nil}
rightPlayerScore = 0
rightPlayerWin = false
rightEarlyPress = false

canPress = false
canPressTimerMax = 10
canPressTimer = canPressTimerMax
randomNumber = math.random(1, 20)

function love.load()
    font = love.graphics.newFont("fonts/Phantex.ttf", 30)
    love.graphics.setFont(font)
    bg = love.graphics.newImage("gfx/bg.png")

    scarySound = love.audio.newSource("sfx/scary.wav")
    -- PressSound = love.audio.newSource("gfx/Press.wav")

    leftIdle = love.graphics.newImage("gfx/leftPlayer.png")
    leftPlayer.img = leftIdle

    rightIdle = love.graphics.newImage("gfx/rightPlayer.png")
    rightPlayer.img = rightIdle

    scaryImgs = {
        love.graphics.newImage("gfx/scary1.png"), 
        love.graphics.newImage("gfx/scary2.png")
    }

    math.randomseed(os.time())

    scaryImg = scaryImgs[math.random(#scaryImgs)]
end

function love.update(dt)
    if love.keyboard.isDown "s" then
        gameStart = true
    end

    if gameStart == true then
        if
            leftPlayerWin == true and love.keyboard.isDown "space" or
                rightPlayerWin == true and love.keyboard.isDown "space" or
                leftEarlyPress == true and rightEarlyPress == true and love.keyboard.isDown "space"
         then
            leftPlayer.img = leftIdle
            leftPlayerWin = false
            leftEarlyPress = false
            rightPlayer.img = rightIdle
            rightPlayerWin = false
            rightEarlyPress = false
            canPress = false
            canPressTimer = 5
            canPressTimer = canPressTimerMax
            math.randomseed(os.time())
            randomNumber = math.random(1, 20)
            scaryImg = scaryImgs[math.random(#scaryImgs)]
        end

        if canPressTimer > 0 then
            canPressTimer = canPressTimer - (randomNumber * dt)
        end

        if canPressTimer < 0 and leftPlayerWin == false and rightPlayerWin == false then
            if canPress == false then
                love.audio.play(scarySound)
            end
            canPress = true
        end

        if love.keyboard.isDown("lctrl") and leftEarlyPress == false then
            if canPress == true and leftEarlyPress == false then
                -- love.audio.play(PressSound)
                canPress = false
                leftPlayerWin = true
                leftPlayerScore = leftPlayerScore + 1
            else
                leftEarlyPress = true
                rightPlayerWin = true
                rightPlayerScore = rightPlayerScore + 1
            end
        elseif love.keyboard.isDown("rctrl") and rightEarlyPress == false then
            if canPress == true and rightEarlyPress == false then
                -- love.audio.play(PressSound)
                canPress = false
                rightPlayerWin = true
                rightPlayerScore = rightPlayerScore + 1
            else
                rightEarlyPress = true
                leftPlayerWin = true
                leftPlayerScore = rightPlayerScore + 1
            end
        end
    end
end

function love.draw()
    love.graphics.draw(bg, 0, 0)

    if gameStart == false then
        love.graphics.print("Press S to start!", love.graphics:getWidth() / 2 - 70, love.graphics:getHeight() / 2)
    end

    if gameStart == true then
        if rightPlayerWin == false then
            love.graphics.draw(leftPlayer.img, leftPlayer.x, leftPlayer.y)
        end
        if leftPlayerWin == false then
            love.graphics.draw(rightPlayer.img, rightPlayer.x, rightPlayer.y)
        end

        if canPress == true and leftPlayerWin == false and rightPlayerWin == false then
            love.graphics.draw(scaryImg, love.graphics:getWidth() / 2 - 256, love.graphics:getHeight() / 2 - 256)
            love.graphics.print("Blink now!", love.graphics:getWidth() / 2 - 30, love.graphics:getHeight() - 46)
        end

        if (leftPlayerWin == true or rightPlayerWin == true) or (leftEarlyPress == true and rightEarlyPress == true) then
            love.graphics.print(
                "Press Space to reset!",
                love.graphics:getWidth() / 2 - 90,
                love.graphics:getHeight() / 2 - 200
            )
            love.graphics.setColor(255, 255, 255, 255)
        end

        love.graphics.print("Score: " .. tostring(leftPlayerScore), 10, 0)
		love.graphics.print("Score: " .. tostring(rightPlayerScore), 760, 0)
		love.graphics.print("" ..tostring(canPressTimer), 360, 0)
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

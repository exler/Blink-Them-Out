-- 3rd party
Anim = require "lib/anim8"

-- global variables
gameStart = false

leftPlayer = {x = -12, y = 160, img = nil}
leftPlayerWin = false
leftPlayerScore = 0
leftEarlyPress = false

rightPlayer = {x = 580, y = 160, img = nil}
rightPlayerWin = false
rightPlayerScore = 0
rightEarlyPress = false

dontClick = false
sweetNoPress = false
sweetNoPressTimerMax = 2
sweetNoPressTimer = sweetNoPressTimerMax

canPress = false
canPressTimerMax = 10
canPressTimer = canPressTimerMax
randomTimer = math.random(20)
randomArray = math.random(2)

function love.load()
    font = love.graphics.newFont("fonts/Phantex.ttf", 30)
    love.graphics.setFont(font)
    bg = love.graphics.newImage("gfx/bg.png")

    bgMusic = love.audio.newSource("sfx/bg.mp3")
    scarySound = love.audio.newSource("sfx/scary.wav")
    PressSound = love.audio.newSource("sfx/blink.wav")

    bgMusic:setLooping(true)
    bgMusic:play()

    leftIdle = love.graphics.newImage("gfx/leftPlayer.png")
    leftPlayer.img = leftIdle
    leftBlink = love.graphics.newImage("gfx/leftBlink.png")
    leftDead = love.graphics.newImage("gfx/leftDead.png")

    rightIdle = love.graphics.newImage("gfx/rightPlayer.png")
    rightPlayer.img = rightIdle
    rightBlink = love.graphics.newImage("gfx/rightBlink.png")
    rightDead = love.graphics.newImage("gfx/rightDead.png")

    scaryImgs = {
        love.graphics.newImage("gfx/scary1.png"),
        love.graphics.newImage("gfx/scary2.png"),
        love.graphics.newImage("gfx/scary3.png"),
        love.graphics.newImage("gfx/scary4.png")
    }
    sweetImgs = {
        love.graphics.newImage("gfx/sweet1.png"),
        love.graphics.newImage("gfx/sweet2.png")
    }

    math.randomseed(os.time())

    sweetImg = sweetImgs[math.random(#sweetImgs)]
    scaryImg = scaryImgs[math.random(#scaryImgs)]
end

function love.update(dt)
    if love.keyboard.isDown "s" then
        gameStart = true
    end

    if gameStart == true then
        if leftPlayerWin == true and love.keyboard.isDown "space" or
        rightPlayerWin == true and love.keyboard.isDown "space" or
        leftEarlyPress == true and rightEarlyPress == true and love.keyboard.isDown "space" or
        sweetNoPress == true and love.keyboard.isDown "space" then
            leftPlayer.img = leftIdle
            leftPlayerWin = false
            leftEarlyPress = false
            rightPlayer.img = rightIdle
            rightPlayerWin = false
            rightEarlyPress = false
            dontClick = false
            canPress = false
            canPressTimerMax = 10
            canPressTimer = canPressTimerMax
            math.randomseed(os.time())
            randomTimer = math.random(20)
            randomArray = math.random(2)
            sweetImg = sweetImgs[math.random(#sweetImgs)]
            scaryImg = scaryImgs[math.random(#scaryImgs)]
            sweetNoPress = false
            sweetNoPressTimerMax = 2
            sweetNoPressTimer = sweetNoPressTimerMax
        end

        if canPressTimer > 0 then
            canPressTimer = canPressTimer - (randomTimer * dt)
        end

        if canPressTimer < 0 and leftPlayerWin == false and rightPlayerWin == false then
            if canPress == false then
                love.audio.play(scarySound)
            end
            canPress = true

            if sweetNoPressTimer > 0 then
                sweetNoPressTimer = sweetNoPressTimer - (randomArray * dt)
            end
        end

        if love.keyboard.isDown("lctrl") and leftEarlyPress == false then
            if canPress == true and leftEarlyPress == false and dontClick == false then
                love.audio.play(PressSound)
                canPress = false
                leftPlayerWin = true
                leftPlayerScore = leftPlayerScore + 1
            elseif canPress == true and leftEarlyPress == false and dontClick == true then
                love.audio.play(PressSound)
                canPress = false
                rightPlayerWin = true
                rightPlayerScore = rightPlayerScore + 1
            else
                leftEarlyPress = true
            end
        elseif love.keyboard.isDown("rctrl") and rightEarlyPress == false then
            if canPress == true and rightEarlyPress == false and dontClick == false then
                love.audio.play(PressSound)
                canPress = false
                rightPlayerWin = true
                rightPlayerScore = rightPlayerScore + 1
            elseif canPress == true and rightEarlyPress == false and dontClick == true then
                love.audio.play(PressSound)
                canPress = false
                leftPlayerWin = true
                leftPlayerScore = leftPlayerScore + 1
            else
                rightEarlyPress = true
            end
        end
    end
end

function love.draw()
    love.graphics.draw(bg, 0, 0)

    if gameStart == false then
        love.graphics.rectangle("line", 50, love.graphics:getHeight() / 2, 100, 50, 2)
        love.graphics.rectangle("line", rightPlayer.x + 110, love.graphics:getHeight() / 2, 100, 50, 2)
        love.graphics.print("L CTRL", 60, love.graphics:getHeight() / 2 + 20)
        love.graphics.print("R CTRL", rightPlayer.x + 120, love.graphics:getHeight() / 2 + 20)
        love.graphics.print("Blink when you see a monster!", love.graphics:getWidth() / 2 - 120, love.graphics:getHeight() / 2)
        love.graphics.print("Press S to start!", love.graphics:getWidth() / 2 - 70, love.graphics:getHeight() / 2 + 40)
    end

    if gameStart == true then
        if rightPlayerWin == false and rightEarlyPress == false then
            love.graphics.draw(rightPlayer.img, rightPlayer.x, rightPlayer.y)
        elseif rightPlayerWin == false and rightEarlyPress == true then
            love.graphics.draw(rightBlink, rightPlayer.x, rightPlayer.y)
        end
        if leftPlayerWin == false and leftEarlyPress == false then
            love.graphics.draw(leftPlayer.img, leftPlayer.x, leftPlayer.y)
        elseif leftPlayerWin == false and leftEarlyPress == true then
            love.graphics.draw(leftBlink, leftPlayer.x, leftPlayer.y)
        end

        if canPress == true and leftPlayerWin == false and rightPlayerWin == false then
            bgMusic:setVolume(0)
            if randomArray == 1 then --scary
                love.graphics.draw(scaryImg, love.graphics:getWidth() / 2 - 256, love.graphics:getHeight() / 2 - 256)
                love.graphics.print("Blink now!", love.graphics:getWidth() / 2 - 30, love.graphics:getHeight() - 46)
            elseif randomArray == 2 then --sweet
                love.graphics.draw(sweetImg, love.graphics:getWidth() / 2 - 256, love.graphics:getHeight() / 2 - 256)
                love.graphics.print("How sweet :3", love.graphics:getWidth() / 2 - 30, love.graphics:getHeight() - 46)
                dontClick = true
            end
        end
        if dontClick == true and (rightPlayerWin == true or leftPlayerWin == true) then
            love.graphics.print("Not a monster!", love.graphics:getWidth() / 2 - 60, love.graphics:getHeight() / 2 - 250)
            if rightPlayerWin == true then
                love.graphics.print(
                    "Righty wins!",
                    love.graphics:getWidth() / 2 - 50,
                    love.graphics:getHeight() / 2 - 200
                )
                love.graphics.draw(rightPlayer.img, rightPlayer.x, rightPlayer.y)
                love.graphics.draw(leftBlink, leftPlayer.x, leftPlayer.y)
            end
            if leftPlayerWin == true then
                love.graphics.print(
                    "Lefty wins!",
                    love.graphics:getWidth() / 2 - 50,
                    love.graphics:getHeight() / 2 - 200
                )
                love.graphics.draw(leftPlayer.img, leftPlayer.x, leftPlayer.y)
                love.graphics.draw(rightBlink, rightPlayer.x, rightPlayer.y)
            end
        elseif dontClick == true and rightPlayerWin == false and leftPlayerWin == false and sweetNoPressTimer < 0 then
            sweetNoPress = true
            love.graphics.print(
                "Tie!",
                love.graphics:getWidth() / 2 - 30,
                love.graphics:getHeight() / 2 - 200
            )
            love.graphics.draw(rightPlayer.img, rightPlayer.x, rightPlayer.y)
            love.graphics.draw(leftPlayer.img, leftPlayer.x, leftPlayer.y)
        elseif (leftPlayerWin == true or rightPlayerWin == true) or (leftEarlyPress == true and rightEarlyPress == true) then
            bgMusic:setVolume(1)

            if leftPlayerWin == true then
                love.graphics.print(
                    "Lefty wins!",
                    love.graphics:getWidth() / 2 - 50,
                    love.graphics:getHeight() / 2 - 200
                )
                love.graphics.draw(leftBlink, leftPlayer.x, leftPlayer.y)
                love.graphics.draw(rightDead, rightPlayer.x, rightPlayer.y)
            end
            if rightPlayerWin == true then
                love.graphics.print(
                    "Righty wins!",
                    love.graphics:getWidth() / 2 - 50,
                    love.graphics:getHeight() / 2 - 200
                )
                love.graphics.draw(rightBlink, rightPlayer.x, rightPlayer.y)
                love.graphics.draw(leftDead, leftPlayer.x, leftPlayer.y)
            end

            love.graphics.print(
                "Press Space to reset!",
                love.graphics:getWidth() / 2 - 90,
                love.graphics:getHeight() / 2 - 250
            )
            love.graphics.setColor(255, 255, 255, 255)
        end

        love.graphics.print("Score: " .. tostring(leftPlayerScore), 10, 0)
        love.graphics.print("Score: " .. tostring(rightPlayerScore), 760, 0)
    -- love.graphics.print("" ..tostring(canPressTimer), 360, 0)
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

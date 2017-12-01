-- global variables
gameStart = false

leftPlayer = {x = 50, y = 200, img = nil}
leftPlayerScore = 0
leftPlayerWin = false
lToEarly = false

rightPlayer = {x = 600, y = 200, img = nil}
rightPlayerScore = 0
rightPlayerWin = false
rToEarly = false

canPress = false
canPressTimerMax = 10
canPressTimer = canPressTimerMax
randomNumber = math.random(1, 20)

function love.load()
    font = love.graphics.newFont("fonts/Phantex.ttf", 30)
    love.graphics.setFont(font)
    -- level = love.graphics.newImage("gfx/level.png")

    -- scarySound = love.audio.newSource("gfx/scary.wav")
    -- PressSound = love.audio.newSource("gfx/Press.wav")

    leftIdle = love.graphics.newImage("gfx/leftPlayer.png")
    leftPlayer.img = leftIdle
    -- lPress01 = love.graphics.newImage("gfx/leftPlayerPress01.png")
    -- lPress02 = love.graphics.newImage("gfx/leftPlayerPress02.png")
    -- lPress03 = love.graphics.newImage("gfx/leftPlayerPress03.png")
    -- lPress04 = love.graphics.newImage("gfx/leftPlayerPress04.png")
    -- lPress05 = love.graphics.newImage("gfx/leftPlayerPress05.png")
    -- lPress06 = love.graphics.newImage("gfx/leftPlayerPress06.png")
    -- lPress07 = love.graphics.newImage("gfx/leftPlayerPress07.png")

    rightIdle = love.graphics.newImage("gfx/rightPlayer.png")
    rightPlayer.img = rightIdle
    -- rPress01 = love.graphics.newImage("gfx/rightPlayerPress01.png")
    -- rPress02 = love.graphics.newImage("gfx/rightPlayerPress02.png")
    -- rPress03 = love.graphics.newImage("gfx/rightPlayerPress03.png")
    -- rPress04 = love.graphics.newImage("gfx/rightPlayerPress04.png")
    -- rPress05 = love.graphics.newImage("gfx/rightPlayerPress05.png")
    -- rPress06 = love.graphics.newImage("gfx/rightPlayerPress06.png")
    -- rPress07 = love.graphics.newImage("gfx/rightPlayerPress07.png")

    -- PressText = love.graphics.newImage("gfx/Press.png")
end

function love.update(dt)
    if love.keyboard.isDown "s" then
        gameStart = true
    end

    if gameStart == true then
        if
            leftPlayerWin == true and love.keyboard.isDown "space" or
                rightPlayerWin == true and love.keyboard.isDown "space" or
                lToEarly == true and rToEarly == true and love.keyboard.isDown "space"
         then
            leftPlayer.img = leftIdle
            leftPlayerWin = false
            lToEarly = false
            rightPlayer.img = rightIdle
            rightPlayerWin = false
            rToEarly = false
            animateTime = 8
            canPress = false
            canPressTimer = 5
            canPressTimer = canPressTimerMax
            randomNumber = math.random(1, 20)
        end

        if canPressTimer > 0 then
            canPressTimer = canPressTimer - (randomNumber * dt)
        end

        if canPressTimer < 0 and leftPlayerWin == false and rightPlayerWin == false then
            if canPress == false then
                -- love.audio.play(scarySound)
            end
            canPress = true
        end

        if love.keyboard.isDown("lctrl") and lToEarly == false then
            if canPress == true and lToEarly == false then
                -- love.audio.play(PressSound)
                canPress = false
                leftPlayerWin = true
                leftPlayerScore = leftPlayerScore + 1
            else
                lToEarly = true
            end
        elseif love.keyboard.isDown("rctrl") and rToEarly == false then
            if canPress == true and rToEarly == false then
                -- love.audio.play(PressSound)
                canPress = false
                rightPlayerWin = true
                rightPlayerScore = rightPlayerScore + 1
            else
                rToEarly = true
            end
        end

        --[[if leftPlayerWin == true then
            animateTime = animateTime - (10 * dt)

            if (animateTime > 7) then
                leftPlayer.img = lPress01
            elseif (animateTime > 6) then
                leftPlayer.img = lPress02
            elseif (animateTime > 5) then
                leftPlayer.img = lPress03
            elseif (animateTime > 4) then
                leftPlayer.img = lPress04
            elseif (animateTime > 3) then
                leftPlayer.img = lPress05
            elseif (animateTime > 2) then
                leftPlayer.img = lPress06
            elseif (animateTime > 1) then
                leftPlayer.img = lPress07
            elseif animateTime < 0 then
                animateTime = 5
            end
        end

        if rightPlayerWin == true then
            animateTime = animateTime - (10 * dt)

            if (animateTime > 7) then
                rightPlayer.img = rPress01
            elseif (animateTime > 6) then
                rightPlayer.img = rPress02
            elseif (animateTime > 5) then
                rightPlayer.img = rPress03
            elseif (animateTime > 4) then
                rightPlayer.img = rPress04
            elseif (animateTime > 3) then
                rightPlayer.img = rPress05
            elseif (animateTime > 2) then
                rightPlayer.img = rPress06
            elseif (animateTime > 1) then
                rightPlayer.img = rPress07
            elseif animateTime < 0 then
                animateTime = 5
            end
        end]]--
    end
end

function love.draw()
    -- love.graphics.draw(level, 0, 0)

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
            -- love.graphics.draw(PressText, love.graphics:getWidth() / 2 - 80, love.graphics:getHeight() / 2 - 260)
        end

        if (leftPlayerWin == true or rightPlayerWin == true) or (lToEarly == true and rToEarly == true) then
            love.graphics.setColor(0, 0, 0, 255)
            love.graphics.print(
                "Press spacebar to Reset",
                love.graphics:getWidth() / 2 - 124,
                love.graphics:getHeight() / 2 - 200
            )
            love.graphics.setColor(255, 255, 255, 255)
        end

        love.graphics.print("Score: " .. tostring(leftPlayerScore), 10, 0)
		love.graphics.print("Score: " .. tostring(rightPlayerScore), 1180, 0)
		love.graphics.print("" ..tostring(canPressTimer),500,0)
    end
end

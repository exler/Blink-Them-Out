function love.conf(t)
    -- global variables
    windowScale = 2
    windowWidth = 480
    windowHeight = 270

    t.version = "0.10.2"
    t.console = false

    t.window.title = "VAFG"
    t.window.icon = nil

    t.window.width = windowWidth * windowScale
    t.window.height = windowHeight * windowScale
    t.window.minwidth = windowWidth
    t.window.minheight = windowHeight
    t.window.resizable = false
    t.window.fullscreen = false
end
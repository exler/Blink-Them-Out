function love.conf(t)
    -- global variables
    windowWidth = 840
    windowHeight = 540

    t.version = "0.10.2"
    t.console = false

    t.window.title = "VAFG"
    t.window.icon = nil

    t.window.width = windowWidth
    t.window.height = windowHeight
    t.window.resizable = false
    t.window.fullscreen = false
end
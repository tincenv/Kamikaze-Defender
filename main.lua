-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

SCREEN_WIDTH, SCREEN_HEIGHT = 1024, 768
local backgroundImage = love.graphics.newImage("img/background.png")
local backgroundImageWidth = backgroundImage:getWidth()
local backgroundImageHeight = backgroundImage:getHeight()
imgScaleX = SCREEN_WIDTH / backgroundImageWidth
imgScaleY = SCREEN_HEIGHT / backgroundImageHeight

require("autoLoad")
autoLoad("ressources")
autoLoad("scenes")

function love.load()
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {resizable = false, vsync = true, centered = true})
    love.window.setTitle("Mon super jeu qui tue")
    changeScene("menu")
end

function love.update(dt)
    updateCurrentScene(dt)
end

function love.draw()
    drawCurrentScene()
end

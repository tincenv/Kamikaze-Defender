local scenes = {}

local currentScene = nil

function newScene(title)
    local scene = {}
    scene.title = title

    scene.load = function(data)
    end

    scene.update = function(dt)
    end

    scene.draw = function()
    end

    scene.keypressed = function(key)
    end

    scene.mousepressed = function(x, y, bouton)
    end

    scene.unload = function()
    end
    scenes[title] = scene
    return scene
end

function changeScene(title, data)
    if currentScenee then
        currentScene.unload()
    end
    currentScene = scenes[title]
    currentScene.load(data)
end

function drawCurrentScene()
    currentScene.draw()
end

function updateCurrentScene(dt)
    currentScene.update(dt)
end

function keypressend(key)
end

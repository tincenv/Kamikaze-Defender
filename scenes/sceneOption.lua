local scene = newScene("option")

scene.load = function()
end

scene.update = function(dt)
    if love.keyboard.isDown("b") then
        changeScene("menu")
    end
end

scene.draw = function()
    love.graphics.print("Option", SCREEN_WIDTH * 0.33, SCREEN_HEIGHT * .20)
    love.graphics.print("B - back to Menu", SCREEN_WIDTH * 0.33, SCREEN_HEIGHT * .20 + 20)
end
local scene = newScene("menu")

scene.load = function()
end

scene.update = function(dt)
    if love.keyboard.isDown("n") then
        changeScene("game")
    elseif love.keyboard.isDown("o") then
        changeScene("option")
    elseif love.keyboard.isDown("q") then
        love.event.quit()
    end
end

scene.draw = function()
    love.graphics.print("Menu", SCREEN_WIDTH * 0.33, SCREEN_HEIGHT * .20)
    love.graphics.print("N - New Games", SCREEN_WIDTH * 0.33, SCREEN_HEIGHT * .20 + 20)
    love.graphics.print("O - Options", SCREEN_WIDTH * 0.33, SCREEN_HEIGHT * .20 + 40)
    love.graphics.print("Q - Quit Game", SCREEN_WIDTH * 0.33, SCREEN_HEIGHT * .20 + 60)
end

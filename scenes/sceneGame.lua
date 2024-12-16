local scene = newScene("game")
local player = newPlayer()

solHeight = 20
enemies = {}
local backgroundImage = love.graphics.newImage("img/background.png")
local backgroundImageWidth = backgroundImage:getWidth()
local backgroundImageHeight = backgroundImage:getHeight()
imgScaleX = SCREEN_WIDTH / backgroundImageWidth
imgScaleY = SCREEN_HEIGHT / backgroundImageHeight
local backgroundImageOffsetX = 0
local backgroundImageOffsetY = 0
local backgroundImageX = 0
local backgroundImageY = 0
local backgroundImageAngle = 0

local virtualGroundHeight = 10 * imgScaleX
local virtualGroundWidth = SCREEN_WIDTH
local virtualGroundY = SCREEN_HEIGHT - virtualGroundHeight
local virtualGroundX = 0

castle = newCastle()

local enemySpawnRate = 1
local enemySpawnTimer = enemySpawnRate

scene.load = function(data)
    maxEnemyspawn = 10
end

scene.update = function(dt)
    --on insert les enemies chaque secondes
    if enemySpawnTimer <= 0 then
        if maxEnemyspawn > 0 then
            table.insert(enemies, newEnemy(math.random(50, SCREEN_WIDTH - 50), 0, 100, 50, 50))
            enemySpawnTimer = enemySpawnRate
            maxEnemyspawn = maxEnemyspawn - 1
        end
    elseif enemySpawnTimer > 0 then
        enemySpawnTimer = enemySpawnTimer - dt
    end

    player.update(dt)
    for _, enemy in ipairs(enemies) do
        enemy.update(dt)
    end

    --On check les colisions entre les ennemies et le bullets
    for _, bullet in ipairs(bullets) do
        for _, enemy in ipairs(enemies) do
            if checkCollisions(enemy, bullet) then
                enemy.takeDamage(bullet.damage)
                bullet.queueFree()
            end
        end
    end

    --On check les colisions entre les ennemies et le player
    for _, enemy in ipairs(enemies) do
        if checkCollisions(enemy, player) then
            changeScene("gameLose")
        end
    end

    --On check les colisions entre les ennemies et le chateau
    for _, enemy in ipairs(enemies) do
        if checkCollisions(enemy, castle) then
            changeScene("gameLose")
        end
    end

    --Si plus d'enemie, on affiche la scene win
    if #enemies <= 0 then
        if maxEnemyspawn <= 0 then
            changeScene("gameWin")
        end
    end

    updateBullets(dt)
    for i = #enemies, 1, -1 do
        if enemies[i].free then
            table.remove(enemies, i)
        end
    end
end

scene.draw = function()
    love.graphics.draw(
        backgroundImage,
        backgroundImageX,
        backgroundImageY,
        backgroundImageAngle,
        imgScaleX,
        imgScaleY,
        backgroundImageOffsetX,
        backgroundImageOffsetY
    )
    castle.draw()
    player.draw()
    for _, enemy in ipairs(enemies) do
        enemy.draw()
    end

    drawBullets()
    drawDebug()
end

local playerIdleImage = love.graphics.newImage("img/character_idle.png")
local playerRuning1Image = love.graphics.newImage("img/character_runing1.png")
--local playerRuning2Image = love.graphics.newImage("img/character_runing2.png")
--local playerRuning3Image = love.graphics.newImage("img/character_runing3.png")
--local playerRuning4Image = love.graphics.newImage("img/character_runing4.png")

local playerGunImage = love.graphics.newImage("img/raygun.png")

local playerImageWidth = playerIdleImage:getWidth()
local playerImageHeight = playerIdleImage:getHeight()
local playerGunWidth = playerGunImage:getWidth()
local playerGunHeight = playerGunImage:getHeight()

local offsetX = playerImageWidth * 0.5
local offsetY = playerImageHeight * 0.5
local gunOffsetX = playerGunWidth * 0.5
local gunOffsetY = playerGunHeight * 0.5

local oldMouseButtonState = false
local gunLength = playerGunImage:getWidth() - 40
local fireRate = 0.2

local enemies = newEnemy()

function newPlayer()
    p = {}

    p.x = love.graphics.getWidth() * 0.5
    p.y = love.graphics.getHeight() * 0.5
    p.radius = 25

    p.fallSpeed = 500
    p.jumpHeight = 10000
    p.gunAngle = 0
    p.speed = 200

    p.shootTimer = 0

    p.scaleX = 1
    p.scaleY = 1
    p.gunScaleX = 1
    p.gunScaleY = 1
    p.gunX = p.x + 15
    p.gunY = p.y - 10
    p.state = "idle"

    --p.isJumping = false
    p.jumpOrigin = p.y

    p.runingImgNumber = 1
    p.currentRuningImg = p.Runing1Image
    p.currentImg = playerIdleImage

    p.update = function(dt)
        p.state = "falling"
        -- Si le joueur n'est pas en bas de l'ecran et qu'il n'est pas en train de sauter, il descend
        if p.y < SCREEN_HEIGHT - playerImageHeight then
            p.state = "falling"
        elseif p.y < SCREEN_HEIGHT - playerImageHeight + solHeight then
            p.state = "idle"
            p.y = SCREEN_HEIGHT - playerImageHeight + solHeight
        else
            p.state = "idle"
        end

        if love.keyboard.isDown("left") and p.state ~= "falling" then
            --changeRuningImg(p.runingImgNumber)
            p.state = "running"
            p.x = p.x - p.speed * dt
        elseif love.keyboard.isDown("right") and p.state ~= "falling" then
            p.state = "running"
            p.x = p.x + p.speed * dt
        --changeRuningImg(p.runingImgNumber)
        --elseif love.keyboard.isDown("up") and p.state ~= "falling" then
        --   p.state = "jumping"
        end

        --machine a état du joueur
        if p.state == "idle" then
            p.currentImg = playerIdleImage
        elseif p.state == "running" then
            --  p.currentImg = changeRuningImg(p.runingImgNumber)
            p.currentImg = playerRuning1Image
            p.move(dt)
        elseif p.state == "jumping" then
            p.currentImg = playerIdleImage
        elseif p.state == "falling" then
            p.currentImg = playerIdleImage
            p.y = p.y + p.fallSpeed * dt
        end

        p.aim(love.mouse.getPosition())

        if love.mouse.isDown(1) and oldMouseButtonState == false then
            p.shoot()
        end

        if p.shootTimer > 0 then
            p.shootTimer = p.shootTimer - dt
        end

        oldMouseButtonState = love.mouse.isDown(1)
    end

    -- p.jump = function(dt, jumpOrigin)
    --     if p.isFalling(dt) == false then
    --         p.isJumping = true
    --         if (p.y < jumpOrigin + p.jumpHeight) then
    --             p.y = p.y - p.speed * dt
    --         end
    --     else
    --         p.isJumping = flase
    --     end
    -- end

    p.move = function(dt)
        if love.keyboard.isDown("q") then
            --changeRuningImg(p.runingImgNumber)
            p.state = "running"
            p.x = p.x - p.speed * dt
        elseif love.keyboard.isDown("d") then
            --changeRuningImg(p.runingImgNumber)
            p.state = "running"
            p.x = p.x + p.speed * dt
        else
            p.state = "idle"
        end
    end

    p.aim = function(x, y)
        local angle = math.atan2(y - p.y, x - p.x)
        if x > p.x and p.scaleX < 0 then
            p.scaleX = 1
            p.gunScaleY = 1
        elseif x < p.x and p.scaleX > 0 then
            p.scaleX = -1
            p.gunScaleY = -1
        end
        p.gunAngle = angle
    end

    p.shoot = function()
        if p.shootTimer <= 0 then
            local b = newBullet()

            local x = math.cos(p.gunAngle) * gunLength + p.x
            local y = math.sin(p.gunAngle) * gunLength + p.y

            b.fire(x, y, p.gunAngle)
            p.shootTimer = fireRate
            print("player shot ")
        end
    end

    p.draw = function()
        --love.graphics.setColor(0, 1, 0)
        --love.graphics.circle("line", p.x, p.y, p.radius)
        --love.graphics.setColor(1, 1, 1)
        love.graphics.draw(p.currentImg, p.x, p.y, p.angle, p.scaleX, p.scaleY, offsetX, offsetY)
        love.graphics.draw(playerGunImage, p.x, p.y, p.gunAngle, p.gunScaleX, p.gunScaleY, offsetX, offsetY)
    end

    p.setFireRate = function(rate)
        if rate < 0 then
            rate = 0
        elseif rate > 10 then
            rate = 10
        end
        fireRate = rate
    end

    --changeRuningImg = function(runingImgNumber)
    --    print(runingImgNumber)
    --    if runingImgNumber == 1 then
    --        --   playercurrentRuningImg = playerRuning2Image
    --        playerruningImgNumber = 2
    --    elseif runingImgNumber == 2 then
    --        -- playercurrentRuningImg = playerRuning3Image
    --        playerruningImgNumber = 3
    --    elseif runingImgNumber == 3 then
    --        -- playercurrentRuningImg = playerRuning4Image
    --        playerruningImgNumber = 4
    --    elseif runingImgNumber == 4 then
    --        playerruningImgNumber = 1
    --    --   playercurrentRuningImg = playerRuning1Image
    --    end
    --    return playercurrentRuningImg
    --end
    return p
end

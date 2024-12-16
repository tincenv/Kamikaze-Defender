local enemyImage = love.graphics.newImage("img/planeRed2.png")

local offsetX = enemyImage:getWidth() * 0.5
local offsetY = enemyImage:getHeight() * 0.5

function newEnemy(x, y, life, speed, radius)
    local enemy = {}

    enemy.type = "enemy"
    enemy.x = x or 0
    enemy.y = y or 0
    enemy.radius = radius or 50
    enemy.free = false
    enemy.life = life or 100
    enemy.speed = speed or 100
    enemy.scaleX = 1
    enemy.scaleY = 1

    enemy.idleMaxDuration = 5
    enemy.idleMinDuration = 2
    enemy.idleTimer = math.random(enemy.idleMinDuration, enemy.idleMaxDuration)

    enemy.update = function(dt)
        enemy.direction(castle.x, castle.y, dt)
    end

    enemy.draw = function()
        love.graphics.draw(enemyImage, enemy.x, enemy.y, enemy.angle, enemy.scaleX, enemy.scaleY, offsetX, offsetY)
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("line", enemy.x, enemy.y, enemy.radius)
        love.graphics.setColor(1, 1, 1)
    end

    enemy.takeDamage = function(damages)
        enemy.life = enemy.life - damages
        if enemy.life <= 0 then
            enemy.queueFree()
        end
    end

    enemy.direction = function(x, y, dt)
        --Si les enemies sorte de l'ecran on les supprimes
        if enemy.x < 0 or enemy.x > SCREEN_WIDTH or enemy.y < 0 or enemy.y > SCREEN_HEIGHT then
            enemy.queueFree()
        end
        --sur le premier tier de l'ecran, les ennemies descendent en ligne droite
        if enemy.y <= SCREEN_HEIGHT * 0.3 then
            enemy.y = enemy.y + enemy.speed * dt
            enemy.angle = 0.5 * math.pi
            if enemy.x < castle.x then
                if enemy.scaleY < 0 then
                    enemy.scaleY = enemy.scaleY * -1
                end
            elseif enemy.x > castle.x then
                if enemy.scaleY > 0 then
                    enemy.scaleY = enemy.scaleY * -1
                end
            end
        else
            --sur le 2eme tier de l'ecran, les ennemies descendent en direction du chateau

            if enemy.x < castle.x then
                enemy.x = enemy.x + enemy.speed * dt
            elseif enemy.x > castle.x then
                enemy.x = enemy.x - enemy.speed * dt
            end
            local angle = math.atan2(y - enemy.y, x - enemy.x)
            enemy.y = enemy.y + enemy.speed * dt
            enemy.angle = angle
        end
    end

    enemy.queueFree = function()
        enemy.free = true
    end

    return enemy
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function isIntersecting(x1, y1, r1, x2, y2, r2)
    local dist = distance(x1, y1, x2, y2)
    local rSum = r1 + r2
    return dist < rSum
end

function checkCollisions(entity1, entity2)
    if isIntersecting(entity2.x, entity2.y, entity2.radius, entity1.x, entity1.y, entity1.radius) then
        collision = true
    else
        collision = false
    end

    return collision
end

function drawDebug()
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Enemies: " .. #enemies, 10, 10)
    love.graphics.print("Bullets: " .. #bullets, 10, 25)
    love.graphics.print("p.state: " .. p.state, 10, 40)
    love.graphics.print("p.x: " .. p.x, 10, 55)
    love.graphics.print("p.y " .. p.y, 10, 70)
    love.graphics.setColor(1, 1, 1)
end

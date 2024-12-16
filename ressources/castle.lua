local castleImage = love.graphics.newImage("img/castle_grey.png")
local imageWidth = castleImage:getWidth()
local imageHeight = castleImage:getHeight()

local offsetX = imageWidth / 2
local offsetY = imageHeight

local groundHeight = 10 * imgScaleX
local groundWidth = SCREEN_WIDTH
local groundY = SCREEN_HEIGHT - groundHeight
local groundX = 0

function newCastle()
    local castle = {}

    castle.x = SCREEN_WIDTH * 0.5
    castle.y = SCREEN_HEIGHT - groundHeight
    castle.angle = 0
    castle.radius = 110

    castle.update = function(dt)
    end

    castle.draw = function()
        love.graphics.draw(castleImage, castle.x, castle.y, castle.angle, imgScaleX, imgScaleY, offsetX, offsetY)
        love.graphics.rectangle("fill", groundX, groundY, groundWidth, groundHeight)
        -- love.graphics.circle("line", castle.x, castle.y, castle.radius)
    end

    return castle
end

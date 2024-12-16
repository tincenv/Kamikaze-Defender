function autoLoad(dir)
    local files = love.filesystem.getDirectoryItems(dir)
    for k, file in ipairs(files) do
        file = file:sub(1, -5)
        require(dir .. "/" .. file)
        print("Loading " .. file)
    end
end


local function part1()
    pairs = {}
    for line in io.lines("input") do
        local first = line:match("%d+")
        local second = line:sub(first:len() + 1):match("%d+")
        pairs[#pairs+1] = {first,second}
    end

    local best = 0
    local best_pair = {}
    for i=1,#pairs do
        for j=1,#pairs do
            local a = pairs[i]
            local b = pairs[j]
            local area = (math.abs(a[1] - b[1]) + 1) * (math.abs(a[2] - b[2]) + 1)
            if area > best then
                best = area
                best_pair = {a,b}
            end
        end
    end

    print(best)
    print(best_pair[1][1], best_pair[1][2])
    print(best_pair[2][1], best_pair[2][2])
end

local function xy(tab, x,y)
    if tab[x] == nil then
        return false
    elseif tab[x][y] == nil then
        return false
    else
        return true
    end
end

local function part2()

    local tiles = {}
    local pairs = {}
    local lut = {}

    for line in io.lines("test") do
        local first = line:match("%d+")
        local second = line:sub(first:len() + 1):match("%d+")
        first = tonumber(first)
        second = tonumber(second)
        pairs[#pairs+1] = {first, second}

        if lut[first] == nil then
            lut[first] = {}
        end

        lut[first][second] = true
    end

    for i =1,#pairs - 1 do
        local a = pairs[i]
        local b = pairs[i + 1]
        local distx = a[1] - b[1]
        local disty = a[2] - b[2]
        local dirx = 1
        local diry = 1

        if distx < 0 then
            dirx = -1
        end
        if disty < 0 then
            diry = -1
        end

        for j =0,math.abs(distx) do
            if tiles[a[1] + dirx*j] == nil then
                tiles[a[1]+ dirx*j] = {}
            end
            tiles[a[1] + dirx*j][a[2]] = true
        end

        for j =0,math.abs(disty) do
            if tiles[a[1]] == nil then
                tiles[a[1]] = {}
            end
            tiles[a[1]][a[2] + diry*j] = true
        end

    end

    local max_x = 0
    local max_y = 0
    local min_x = 1000000000
    local min_y = 1000000000

    for i = 1, #pairs do
        if pairs[i][1] < min_x then
            min_x = pairs[i][1]
        end
        if pairs[i][1] > max_x then
            max_x = pairs[i][1]
        end

        if pairs[i][2] < min_y then
            min_y = pairs[i][2]
        end
        if pairs[i][2] > max_y then
            max_y = pairs[i][2]
        end
    end

    local map = {}

    for y = 1, max_y do
        map[#map+1] = '\n'
        for x = 1, max_x do
            if xy(lut,x,y) then
                map[#map+1] = '#'
            elseif xy(tiles,x,y) then
                map[#map+1] = 'x'
            else
                map[#map+1] = '.'
            end
        end
    end

    print(table.concat(map))

end


part2()

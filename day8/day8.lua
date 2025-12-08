

local junctions = {}

local num = 0
for line in io.lines("input") do
    num = num + 1
    local x = line:match("%d+")
    local y = line:sub(x:len()+1):match("%d+")
    local z = line:sub(x:len()+1 + y:len()+1):match("%d+")
    junctions[num] = {tonumber(x),tonumber(y),tonumber(z)}
end

local function dist(d1,d2)
    return math.sqrt((d1[1]-d2[1])^2 + (d1[2]-d2[2])^2 + (d1[3]-d2[3])^2)
end


local circuits = {}

local function print_j(j)
    print(j[1],j[2],j[3])
end



while(true) do

    local smallest_dist = 1000000000000000000000000000000000000000000000
    local pair = nil

    for i, j1 in ipairs(junctions) do
        for j, j2 in ipairs(junctions) do
            local distance = dist(j1,j2)

            if distance < smallest_dist and (circuits[i] == nil and circuits[j] == nil) and i ~= j then
                smallest_dist = distance
                pair = {i,j}
            end
        end
    end
    if pair ~= nil then
        circuits[pair[1]] = {}
        circuits[pair[1]][pair[2]] = smallest_dist
        circuits[pair[2]] = {}
        circuits[pair[2]][pair[1]] = smallest_dist
        print(smallest_dist)
    else
        break
    end
end



for i=1,#circuits do
    for _, value in pairs(circuits[i]) do
        print(value)
    end
end

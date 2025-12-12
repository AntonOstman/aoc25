local function directly_connected(graph, new)

    for _,val in pairs(graph) do
        if new == val then
            return true
        end
    end

    return false
end

local function bfs(graph, start)
    local visited = {}
    local queue = {}

    queue[#queue+1] = start
    visited[start] = true

    while(#queue > 0) do
        local cur = queue[1]
        table.remove(queue, 1)
        local neighbors = graph[cur]
        for _,neigh in pairs(neighbors) do
            if not visited[neigh] then
                queue[#queue+1] = neigh
                visited[neigh] = true
            end
        end
    end

    return visited
end

local function keys(tab)

    local tab_keys = {}
    for key,_ in pairs(tab) do
        tab_keys[#tab_keys+1] = key
    end

    return tab_keys
end

local function part1()

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


    local wanted_connections = 1000
    local num_cur_connections = 0

    for i =1,#junctions do
        circuits[i] = {}
    end

    while(num_cur_connections < wanted_connections) do

        local smallest_dist = 1000000000000000000000000000000000000000000000
        local pair = nil

        for i=1,#junctions do
            local j1 = junctions[i]
            for j=i+1,#junctions do

                local j2 = junctions[j]
                local distance = dist(j1,j2)

                if distance < smallest_dist and not directly_connected(circuits[i],j) then
                    smallest_dist = distance
                    pair = {i,j}
                end
            end
        end

        assert(pair ~= nil)

        if pair ~= nil then
            num_cur_connections = num_cur_connections + 1

            circuits[pair[1]][#circuits[pair[1]] + 1] = pair[2]
            circuits[pair[2]][#circuits[pair[2]] + 1] = pair[1]
        else
            break
        end
    end


    local scores = {}
    local num_circuits = 0

    local visited = {}
    for node,_ in pairs(circuits) do

        if not visited[node] then

            num_circuits = num_circuits + 1
            local new_visited = bfs(circuits, node)
            print("new circuit",table.concat(keys(new_visited),", "), 'num: ',#keys(new_visited))

            for new_node,_ in pairs(new_visited) do
                visited[new_node] = true
            end

            local score = #keys(new_visited)
            scores[#scores + 1] = score

        end
    end
    local function cmp(a,b)
        return a > b
    end

    table.sort(scores, cmp)
    print(table.concat(scores, ", "))

    local score = 1

    for i =1, 3 do
        score = score * scores[i]
    end

    print('num connected circuits', num_circuits)

    print('Part 1', score)

end

local function part2()

    local junctions = {}

    for line in io.lines("input") do
        local x = line:match("%d+")
        local y = line:sub(x:len()+1):match("%d+")
        local z = line:sub(x:len()+1 + y:len()+1):match("%d+")
        junctions[#junctions+1] = {tonumber(x),tonumber(y),tonumber(z)}
    end

    local function dist(d1,d2)
        return math.sqrt((d1[1]-d2[1])^2 + (d1[2]-d2[2])^2 + (d1[3]-d2[3])^2)
    end


    local circuits = {}

    for i =1,#junctions do
        circuits[i] = {}
    end


    print("connecting", #junctions,'jucntions')
    while(true) do

        local smallest_dist = 1000000000000000000000000000000000000000000000
        local pair = nil

        for i=1,#junctions do
            local j1 = junctions[i]
            for j=i+1,#junctions do

                local j2 = junctions[j]
                local distance = dist(j1,j2)

                if distance < smallest_dist and not directly_connected(circuits[i],j) then
                    smallest_dist = distance
                    pair = {i,j}

                end
            end
        end

        if pair ~= nil then

            circuits[pair[1]][#circuits[pair[1]] + 1] = pair[2]
            circuits[pair[2]][#circuits[pair[2]] + 1] = pair[1]
            local new_visited = bfs(circuits, pair[1])

            if #keys(new_visited) == #junctions then
                print('score',junctions[pair[2]][1]*junctions[pair[1]][1])

                break
            end
        end
    end
end

part1()
part2()

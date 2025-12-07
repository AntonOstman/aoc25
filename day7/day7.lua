
local function part1()
   local grid = {}
   local beams = {}

   local num_lines = 0
   for line in io.lines('input') do
      num_lines = num_lines + 1
      grid[num_lines] = {}
      beams[num_lines] = {}
      for i=1,line:len() do
         grid[num_lines][i] = line:sub(i,i)
         beams[num_lines][i] = false
      end
   end

   for y=1, #grid do
      for x=1, #grid[1] do
         if grid[y][x] == "S" then
            beams[y+1][x] = true
         end
      end
   end

   local score = 0

   for y = 2,#grid  do
      for x = 1,#grid[1] do
         if beams[y-1][x] then
            if grid[y][x] == '.' then
               beams[y][x] = true
            end
            if grid[y][x] == '^' then
               score = score + 1
               beams[y][x+1] = true
               beams[y][x-1] = true
            end
         end
      end
   end

   print("Part 1", score)
end

local Grid = {}
local Cache = {}

local function simulate_particle(startx, starty)

   if Cache[starty] == nil then
      Cache[starty] = {}
   end

   if Cache[starty][startx] ~= nil then
      return Cache[starty][startx]
   end

   for y = starty+1,#Grid do
      if Grid[y][startx] == '^' then
         local num_time_lines = simulate_particle(startx+1, y) + simulate_particle(startx-1, y)
         Cache[starty][startx] = num_time_lines
         return num_time_lines
      end
   end

   return 1
end


local function part2()

   local num_lines = 0
   local startx
   local starty
   for line in io.lines('input') do
      num_lines = num_lines + 1
      Grid[num_lines] = {}
      for i=1,line:len() do
         Grid[num_lines][i] = line:sub(i,i)
         if Grid[num_lines][i] == 'S' then
            startx = i
            starty = num_lines
         end
      end
   end

   print('Part 2', simulate_particle(startx,starty))
end

part1()
part2()

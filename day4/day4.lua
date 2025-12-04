
function print_table(puzzle)

   for _, value1 in ipairs(puzzle) do
      print(table.concat(value1, ''))
   end

end

function is_inside(pos, puzzle)
   if pos[1] > 0 and pos[1] <= #puzzle[1] and pos[2] > 0 and pos[2] <= #puzzle  then
      return true
   end
   return false
end

function num_rolls(pos, puzzle)

   local adj8 = {{1,0},{0,1},{-1,0},{0,-1},{1,1},{-1,1},{1,-1},{-1,-1}}

   local num = 0

   for _, value in ipairs(adj8) do
      local dx = value[1]
      local dy = value[2]


      if is_inside({pos[1] + dx, pos[2] + dy},puzzle) then
         local ans = puzzle[pos[2] + dy][pos[1] + dx]
         if ans == '@' then
            num = num + 1
         end
      end

   end

   return num
end

function part1()
   local num_lines = 0
   local puzzle = {}

   for line in io.lines("input") do

      num_lines = num_lines + 1

      puzzle[num_lines] = {}
      for i = 1, line:len() do
         puzzle[num_lines][i] = line:sub(i,i)
      end

   end

   local score = 0

   for x = 1,#puzzle[1] do
      for y = 1,#puzzle do
         if num_rolls({x,y}, puzzle) < 4 and puzzle[y][x] == '@' then
            score = score + 1
         end
      end
   end

   print('Part 1 ', score)
end

function part2()
   local num_lines = 0
   local puzzle = {}

   for line in io.lines("input") do

      num_lines = num_lines + 1

      puzzle[num_lines] = {}
      for i = 1, line:len() do
         puzzle[num_lines][i] = line:sub(i,i)
      end

   end

   -- print_table(puzzle)

   local score = 0

   local can_continue = true

   while can_continue do
      local removes = {}
      local num_removes = 0
      for x = 1, #puzzle[1] do
         for y = 1, #puzzle do
            if num_rolls({x,y}, puzzle) < 4 and puzzle[y][x] == '@' then
               score = score + 1
               num_removes = num_removes + 1
               removes[num_removes] = {x,y}
            end
         end
      end

      if #removes == 0 then
         can_continue = false
      end

      for i, value in ipairs(removes) do
         puzzle[value[2]][value[1]] = '.'
      end
   end

   print('Part 2 ', score)
end

part1()
part2()


function part1_code()
   local score = 0
   for line in io.lines("input") do

      local second_best_num = 0
      local second_best_idx = 0

      local best_num = 0

      for i=1,line:len() do
         local num1 = line:sub(i,i)
         for j=i+1,line:len() do
            local num2 = line:sub(j,j)

            local num = tonumber(num1 .. num2)

            if num > best_num then
               best_num = num
            end
         end
         -- print(num)
      end

      print(best_num)
      score = score + tonumber(tostring(best_num))
   end

   print('Part 1', score)
end

Cache = {}

function recurse(num)

   if Cache[num] ~= nil then
      return Cache[num]
   end

   if num:len() == 12 then
      return tonumber(num)
   end

   local largest = 0
   for i=1,num:len() do
      local ans = recurse(num:sub(1,i-1) .. num:sub(i+1))
      -- print(ans)

      if ans > largest then
         largest = ans
      end
   end

   Cache[num] = largest
   return largest
end

function part2_code()
   local score = 0
   for line in io.lines("input") do
      Largest = 0

      score = score + recurse(line)
      -- print(string.format("%30.0f", recurse(line)))
   end

   print('Part 2', string.format("%30.0f",score))
end

part2_code()

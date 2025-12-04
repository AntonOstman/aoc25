
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
      end

      score = score + tonumber(tostring(best_num))
   end

   print('Part 1', score)
end

Cache = {}

function largest_idx(num, allowed)
   local largest = 0
   local idx = 0

   for i = 1, num:len() do
      if tonumber(num:sub(i,i)) > largest and num:sub(i):len() >= allowed then
         largest = tonumber(num:sub(i,i))
         idx = i
      end
   end
   return idx
end

function recurse(num, cur)

   if cur:len() == 12 then
      return tonumber(cur)
   end

   local idx = largest_idx(num, 12 - cur:len())

   local ans = recurse(num:sub(idx + 1), cur .. num:sub(idx,idx))

   return ans
end

function part2_code()
   local score = 0
   for line in io.lines("input") do
      score = score + recurse(line, "")
   end

   print('Part 2', string.format("%30.0f",score))
end

part1_code()
part2_code()

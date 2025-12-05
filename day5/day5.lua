function part1()
   local parse_nums = false

   local ranges = {}
   local nums = {}
   local fresh = {}
   local score = 0
   local num_lines = 0

   for line in io.lines("input") do

      if line == "" then
         parse_nums = true
      end
      if not parse_nums then
         local first = line:match("%d+-")
         local second = line:match("-%d+")
         ranges[#ranges+1] = {tonumber(first:sub(1,first:len() - 1)), tonumber(second:sub(2))}
      else
         nums[#nums+1] = tonumber(line)
      end
      num_lines = num_lines + 1
   end

   for _, num in ipairs(nums) do
      for _, range in ipairs(ranges) do
         local start = range[1]
         local stop = range[2]
         if (num >= start and num <= stop) and fresh[num] ~= true then
            score = score + 1
            fresh[num] = true
         end
      end
   end

   print('Part 1', score)
end

local function is_inside(start, stop, num)
   if (num >= start and num <= stop) then
      return true
   end
   return false
end

local function merge_ranges(ranges)
   local solved_indices = {}
   local new_ranges = {}

   for i, range1 in ipairs(ranges) do
      if solved_indices[i] ~= true then
         local start1 = range1[1]
         local stop1 = range1[2]
         assert (start1 <= stop1, "start larger than stop")
         for j, range2 in ipairs(ranges) do
            if i ~= j and solved_indices[j] ~= true then
               local start2 = range2[1]
               local stop2 = range2[2]
               assert (start2 <= stop2, j)
               if is_inside(start1, stop1, start2) and is_inside(start1, stop1, stop2) then
                  solved_indices[j] = true
               elseif is_inside(start1, stop1, start2) then
                  stop1 = stop2
                  solved_indices[j] = true
               elseif is_inside(start1, stop1, stop2) then
                  start1 = start2
                  solved_indices[j] = true
               elseif is_inside(start2, stop2, start1) and is_inside(start2, stop2, stop1) then
                  solved_indices[j] = true
                  stop1 = stop2
                  start1 = start2
               elseif is_inside(start2, stop2, start1) then
                  start1 = start2
                  solved_indices[j] = true
               elseif is_inside(start2, stop2, stop1) then
                  stop1 = stop2
                  solved_indices[j] = true
               end
            end
         end
         assert (start1 <= stop1)
         new_ranges[#new_ranges+1] = {start1, stop1}
         solved_indices[i] = true
      end
   end
   return new_ranges
end

function part2()
   local ranges = {}

   for line in io.lines("input") do

      if line == "" then
         break
      end

      local first = line:match("%d+-")
      local second = line:match("-%d+")
      first = tonumber(first:sub(1,first:len() - 1))
      second = tonumber(second:sub(2))

      ranges[#ranges+1] = {first, second}
   end

   local prev_len = 100000000000000000

   while #ranges ~= prev_len do
      prev_len = #ranges
      ranges = merge_ranges(ranges)
   end

   local score = 0
   for i, range in ipairs(ranges) do
      score = score + range[2] - range[1] + 1
   end

   print('Part 2', string.format("%30.f", score))
end

part1()
part2()

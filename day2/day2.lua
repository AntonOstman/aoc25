

function part1_code()
   local lines
   for line in io.lines("input") do
      lines = line
   end

   local score = 0

   while string.len(lines) > 0 do
      local range = string.match(lines, "%d+-%d+")
      local first = string.match(lines, "%d+-")
      local last = string.match(lines, "-%d+")
      first = string.sub(first, 1, string.len(first) - 1)
      last = string.sub(last, 2, string.len(last))

      for i=tonumber(first), tonumber(last) do
         local cur = tostring(i)
         if string.len(cur) % 2 == 0 then

            local stop = string.len(cur) / 2
            local start = stop + 1
            local part1 = string.sub(cur, 1, stop)
            local part2 = string.sub(cur, start, string.len(cur))

            if part1 == part2 then
               score = score + tonumber(cur)
            end

         end
      end

      lines = string.sub(lines, string.len(range) + 2)
   end
   print('Part 1', string.format("%30.0f",score))
end

function part2_code()
   local lines
   for line in io.lines("input") do
      lines = line
   end

   local score = 0

   while string.len(lines) > 0 do
      local range = string.match(lines, "%d+-%d+")
      local first = string.match(lines, "%d+-")
      local last = string.match(lines, "-%d+")
      first = string.sub(first, 1, string.len(first) - 1)
      last = string.sub(last, 2, string.len(last))

      for i=tonumber(first), tonumber(last) do
         local cur = tostring(i)
         for j=1, string.len(cur) do
            parts = {}
            if string.len(cur) % j == 0 and string.len(cur) ~= j then

               local start = 1
               local num_steps = string.len(cur) / j
               for k=1, num_steps do
                  local stop = start + j - 1
                  local part = string.sub(cur, start, stop)
                  start = stop + 1

                  table.insert(parts, part)
               end

               local all_same = true

               for k=1,#parts - 1 do 
                  if parts[k] ~= parts[k + 1] then
                     all_same = false
                  end
               end

               if all_same and #parts > 1 then
                  score = score + tonumber(cur)
                  break
               end

            end
         end
      end

      lines = string.sub(lines, string.len(range) + 2)
   end
   print('Part 2', string.format("%30.0f",score))
end

part1_code()
part2_code()

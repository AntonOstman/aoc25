
local function part1()
   local function add_cols(cols, col, operation)
      local sum = 0

      for row = 1, #cols do
         if sum == 0 then
            sum = cols[row][col]
         else
            if operation == '+' then
               sum = cols[row][col] + sum
            elseif operation == '*' then
               sum = cols[row][col] * sum
            else
               assert(false,'Bad op')
            end
         end
      end

      return sum
   end

   local col = 1

   local cols = {}
   local operations = {}

   for line in io.lines("input") do
      local cur_line = line
      local cur_row = {}
      while cur_line:gsub("%s+","") ~= "" do
         local operation = cur_line:match("^%s*[%+%*]")
         if operation ~= nil then
            cur_line = cur_line:sub(operation:len() + 1)
            operations[#operations+1] = operation:match("%S")
         else
            local num = cur_line:match("^%s*%d+")
            cur_line = cur_line:sub(num:len() + 1)
            cur_row[#cur_row+1] = tonumber(num)
         end
      end
      if #cur_row > 0 then
         cols[col] = cur_row
         col = col + 1
      end
   end

   local total = 0

   for i = 1, #cols[1] do
      total = total + add_cols(cols,i, operations[i])
   end
   print('Part 1', total)
end

local function part2()

   local lines = {}

   for line in io.lines("input") do
      lines[#lines+1] = line
   end

   local total = 0

   local cur_op = ""
   local sum = 0

   for col=1,#lines[1] do
      local num = ""
      for row=1,#lines do
         if row ~= #lines then

            local new_num = lines[row]:sub(col,col):match("%S")
            if new_num == nil then
               new_num = ""
            end

            num = num .. new_num
         else
            local operation = lines[row]:sub(col,col):match("%S")
            if operation == "+" or operation == "*" then
               cur_op = lines[row]:sub(col,col)
            end
         end
      end

      if num == "" then
         total = total + sum
         sum = 0
      else
         if cur_op == "*" then
            if sum == 0 then
               sum = tonumber(num)
            else
               sum = sum * tonumber(num)
            end
         elseif cur_op == "+" then
            sum = sum + tonumber(num)
         else
            assert(false, 'Bad op')
         end
      end
   end
   total = total + sum

   print('Part 2',total)
end

part1()
part2()

local params = { ... }
local file = io.open(params[1], "r")
local nClock = os.clock()
local total1, total2, enabled = 0, 0, true

function main()
  if (file == nil) then
    print("error file not found")
  else
    for match, args in file:read("*a"):gmatch("([md][ulon't]+)(%([%d,]*%))") do
      if match == "do" then
        enabled = true
      elseif match == "don't" then
        enabled = false
      elseif match == "mul" and args:match("%(%d%d?%d?%,%d%d?%d?%)") then
        local num1, num2 = args:match("(%d+),(%d+)")

        total1, total2 = total1 + (num1 * num2), total2 + (enabled and (num1 * num2) or 0)
      end
    end
  end
  print(string.format("Part 1: %d", total1))
  print(string.format("Part 2: %d", total2))
  print("Elapsed time: " .. os.clock() - nClock)
end

main()

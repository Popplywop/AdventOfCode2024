local params = {...}
local file = io.open(params[1], "r")
local t1 = {}
local t2 = {}

function Part1()
  local total = 0
  for i, v in ipairs(t1) do
    local sum = math.abs(v - t2[i])
    total = total + sum
  end
  print(total)
end

function Part2()
  local similarity = 0
  for _, a in ipairs(t1) do
    for _, b in ipairs(t2) do
      if a == b then
        similarity = similarity + a
      elseif b > a then
        break;
      end
    end
  end
  print(similarity)
end

if (file == nil) then
  print("error file not found")
else
  local i = 1
  for line in file:lines() do
    for token in string.gmatch(line, "%w+") do
      if (i % 2 == 0) then
        table.insert(t2, token)
      else
        table.insert(t1, token)
      end
      i = i + 1
    end
  end

  table.sort(t1)
  table.sort(t2)

  Part1()
  Part2()

end

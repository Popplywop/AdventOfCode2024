local params = { ... }
local file = io.open(params[1], "r")
local safe_reports = 0
local nClock = os.clock()

function main()
  if (file == nil) then
    print("error file not found")
  else
    for line in file:lines() do
      local report = {}
      for level in line:gmatch("%d+") do
        level = math.tointeger(level)
        table.insert(report, level)
      end
      if (IsSafeReport(report)) then
        safe_reports = safe_reports + 1
      else
        for i = 1, #report, 1 do
          local copy = deepcopy(report)
          table.remove(copy, i)
          if (IsSafeReport(copy)) then
            safe_reports = safe_reports + 1
            break
          end
        end
      end
    end
    print(safe_reports)
    print("Elapsed time: " .. os.clock()-nClock)
  end
end

function IsSafeReport(report)
  if (#report <= 2) then return true end
  local minDist = 1
  local maxDist = 3
  local isIncreasing = false
  local isDecreasing = false
  local badDist = false
  local prev = report[1]
  local curr
  local dist

  for i = 2, #report, 1 do
    curr = report[i]
    if (curr > prev) then isIncreasing = true end
    if (curr < prev) then isDecreasing = true end
    dist = math.abs(curr - prev)
    badDist = badDist or (dist < minDist) or (dist > maxDist)

    prev = curr
    if ((badDist or (isIncreasing and isDecreasing))) then
      return false
    end
  end
  return true
end

function deepcopy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
    copy = {}
    for orig_key, orig_value in next, orig, nil do
      copy[deepcopy(orig_key)] = deepcopy(orig_value)
    end
    setmetatable(copy, deepcopy(getmetatable(orig)))
  else   -- number, string, boolean, etc
    copy = orig
  end
  return copy
end

main()

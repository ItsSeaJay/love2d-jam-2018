-- range.lua

Range = Object:extend()

function Range:new(min, max)
  self.min = min
  self.max = max
end
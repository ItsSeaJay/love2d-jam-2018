-- maths.lua

maths = {}

function maths.lerp(current, target, time)
  return current * (1 - time) + target * time
end

return maths
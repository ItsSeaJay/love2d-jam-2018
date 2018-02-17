-- maths.lua

maths = {}

function maths.lerp(current, target, speed)
  return current * (1 - speed) + target * speed
end

return maths
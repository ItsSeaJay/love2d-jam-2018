-- maths.lua

lerp = {}

function lerp.lerp(current, target, speed)
  return current * (1 - speed) + target * speed
end

return lerp
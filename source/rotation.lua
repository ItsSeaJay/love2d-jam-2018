-- rotation.lua

rotation = {}

-- functions below ripped off from maurice
--- thanks, maurice!

function rotation.turnTo(toR)
  self.lerpTo = toR
  self.lerpTimer = 0
  
  -- adjust lerpFrom when looping
  self.lerpFrom = r
  
  if (self.lerpTo - self.lerpFrom) > math.pi then
    self.lerpFrom = self.lerpFrom + math.pi*2
  elseif (self.lerpFrom - self.lerpTo) > math.pi then
    self.lerpFrom = self.lerpFrom - math.pi*2
  end
end

function rotation.getNormalized(r) -- use this when doing calculations!
	r = math.fmod(r + math.pi, math.pi * 2 ) - math.pi
  r = math.fmod(r - math.pi, math.pi * 2 ) + math.pi
  
  return r
end

return rotation
-- shield.lua

Shield = Object:extend()

function Shield:new(x, y)
  -- transform
  self.transform = Transform(x, y, 64, 16)
  
  -- origin
  self.transform.origin.y = -self.transform.size.height / 2 -64
  
  -- turning
  -- (direction is measured in degrees)
  self.direction = 0
  
  self.lerpTime = 0.16  
  self.lerpTimer = self.lerpTime
  
  self.lerpTo = 0
  self.lerpFrom = 0
  
  -- colour
  self.colour = {}
  self.colour.red = 255
  self.colour.green = 255
  self.colour.blue = 255
  
  -- hitbox
  self.hitbox = HC.rectangle(
    self.transform.position.x + self.transform.origin.x,
    self.transform.position.y + self.transform.origin.y,
    self.transform.size.width / 3,
    self.transform.size.height
  )
  self.hitbox.tag = "shield"
  
  -- sprite
  self.sprite = love.graphics.newImage("resources/graphics/shield.png")
end

function Shield:update(deltaTime)
  -- lerp direction towards target
  -- the shield must take the shortest possible path
  if self.lerpTimer < self.lerpTime then
    self.lerpTimer = math.min(self.lerpTime, self.lerpTimer + deltaTime)
  end
  
  self.direction = easing.inOutQuad(
    self.lerpTimer,
    self.lerpFrom,
    self.lerpTo - self.lerpFrom,
    self.lerpTime
  )
  
  -- move hitbox with shield
  self.hitbox:setRotation(self.direction)
  local pivot = rotateAround(
    0,
    64,
    self.direction
  )
  self.hitbox:moveTo(
    pivot.x + self.transform.position.x,
    pivot.y + self.transform.position.y
  )
end

function Shield:draw()
  if debug then
    -- hitbox
    love.graphics.setColor(255, 0, 0)
    self.hitbox:draw('line')
    
    -- state
    love.graphics.setColor(255, 255, 255)
  end
  
  -- draw the shield
  love.graphics.push()
    love.graphics.setColor(
      self.colour.red,
      self.colour.green,
      self.colour.blue
    )
    love.graphics.translate(
      self.transform.position.x,
      self.transform.position.y
    )
    love.graphics.rotate(self.direction)
    love.graphics.rectangle(
      "fill",
      self.transform.origin.x,
      self.transform.origin.y,
      self.transform.size.width,
      self.transform.size.height
    )
  love.graphics.pop()
end

function rotateAround(cx, cy, angle)
  local point = {}
  point.x = 0
  point.y = 0
  
  -- move the point to origin
  point.x = point.x - cx
  point.y = point.y - cy
  
  -- rotate around the point
  xnew = point.x * math.cos(angle) - point.y * math.sin(angle)
  ynew = point.x * math.sin(angle) + point.y * math.cos(angle)
  
  -- translate the point back to where it was
  point.x = xnew + cx
  point.y = ynew + cx
  
  return point
end

function getDifference(a, b)
  local difference = a - b
  
  while difference > math.pi do
    difference = difference - 2 * math.pi
  end
  
  while difference < -math.pi do
    difference = difference + 2 * math.pi
  end
  
  return difference
end

function Shield:turnTo(toR)
  self.lerpTo = toR
  self.lerpTimer = 0
  
  -- adjust lerpFrom when looping
  self.lerpFrom = self.direction
  
  if (self.lerpTo - self.lerpFrom) > math.pi then
    self.lerpFrom = self.lerpFrom + math.pi * 2
  elseif (self.lerpFrom - self.lerpTo) > math.pi then
    self.lerpFrom = self.lerpFrom - math.pi * 2
  end
end

function Shield:getNormalized(r) -- use this when doing calculations!
	r = math.fmod(r + math.pi, math.pi * 2 ) - math.pi
  r = math.fmod(r - math.pi, math.pi * 2 ) + math.pi
  
  return r
end
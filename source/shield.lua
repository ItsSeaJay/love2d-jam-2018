-- shield.lua

Shield = Object:extend()

function Shield:new(x, y)
  -- transform
  self.transform = Transform(x, y, 64, 16)
  
  -- origin
  self.transform.origin.y = -self.transform.size.height / 2 -64
  
  -- direction is measured in degrees
  self.direction = {}
  self.direction.current = 0
  self.direction.target = 0
  
  self.speed = 16
  
  -- colour
  self.colour = {}
  self.colour.red = 255
  self.colour.green = 255
  self.colour.blue = 255
  
  -- state machine
  self.states = {}
  self.states.up = "up"
  self.states.down = "down"
  self.states.left = "left"
  self.states.right = "right"
  
  self.state = self.states.up
  
  -- hitbox
  self.hitbox = HC.rectangle(
    self.transform.position.x + self.transform.origin.x,
    self.transform.position.y + self.transform.origin.y,
    self.transform.size.width / 3,
    self.transform.size.height
  )
  self.hitbox.tag = "shield"
end

function Shield:update(deltaTime)  
  -- state machine
  if self.state == self.states.up then
    -- up state
    self.direction.target = 0
  elseif self.state == self.states.down then
    -- down state
    self.direction.target = 180
  elseif self.state == self.states.left then
    -- left state
    self.direction.target = 270
  elseif self.state == self.states.right then
    -- right state
    self.direction.target = 90
  end
  
  -- lerp direction towards target
  self.direction.current = lerp.lerp(
    self.direction.current,
    self.direction.target,
    self.speed * deltaTime
  )
  
  -- move hitbox with shield
  self.hitbox:setRotation(math.rad(self.direction.current))
  local pivot = rotateAround(
    0,
    64,
    math.rad(self.direction.current)
  )
  self.hitbox:moveTo(
    pivot.x + self.transform.position.x,
    pivot.y + self.transform.position.y
  )
end

function Shield:draw()
  -- debug hitbox
  if debug then
    love.graphics.setColor(255, 0, 0)
    self.hitbox:draw('line')
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
    love.graphics.rotate(math.rad(self.direction.current))
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
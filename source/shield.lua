-- shield.lua

Shield = Object:extend()

function Shield:new(x, y)
  -- transform
  self.transform = Transform(x, y, 64, 16)
  
  self.origin = {}
  self.origin.x = -self.transform.size.width / 2
  self.origin.y = -self.transform.size.height / 2 - 64
  
  -- direction is measured in degrees
  self.direction = {}
  self.direction.current = 0
  self.direction.target = 0
  
  self.speed = 16
  
  -- state machine
  self.states = {}
  self.states.up = "up"
  self.states.down = "down"
  self.states.left = "left"
  self.states.right = "right"
  
  self.state = self.states.up
end

function Shield:update(delta)  
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
  
  self.direction.current = lerp.lerp(
    self.direction.current,
    self.direction.target,
    self.speed * delta
  )
end

function Shield:draw()  
  love.graphics.push()
    love.graphics.translate(
      self.transform.position.x,
      self.transform.position.y
    )
    love.graphics.rotate(math.rad(self.direction.current))
    love.graphics.rectangle(
      "fill",
      self.origin.x,
      self.origin.y,
      self.transform.size.width,
      self.transform.size.height
    )
  love.graphics.pop()
end
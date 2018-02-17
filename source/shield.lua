-- shield.lua

Shield = Object:extend()

function Shield:new(x, y)
  -- transform
  self.position = {}
  self.position.x = x
  self.position.y = y
  
  self.size = {}
  self.size.width = 64
  self.size.height = 16
  
  self.origin = {}
  self.origin.x = -self.size.width / 2
  self.origin.y = -self.size.height / 2 - 64
  
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
      self.position.x,
      self.position.y
    )
    love.graphics.rotate(math.rad(self.direction.current))
    love.graphics.rectangle(
      "fill",
      self.origin.x,
      self.origin.y,
      self.size.width,
      self.size.height
    )
  love.graphics.pop()
end
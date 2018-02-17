-- shield.lua

Shield = Object:extend()

function Shield:new()
  self.states = {}
  self.states.up = "up"
  self.states.down = "down"
  self.states.left = "left"
  self.states.right = "right"
  
  self.state = self.states.up
  
  self.position = {}
  self.position.x = love.graphics.getWidth() / 2
  self.position.y = love.graphics.getHeight() / 2
  
  self.size = {}
  self.size.width = 32
  self.size.height = 32
  
  self.origin = {}
  self.origin.x = -self.size.width / 2
  self.origin.y = -self.size.height / 2 - 64
  
  self.direction = {}
  self.direction.current = 0 -- Measured in degrees
  self.direction.target = 0
  
  self.speed = 8
end

function Shield:update(delta)  
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
  
  self.direction.current = maths.lerp(
    self.direction.current,
    self.direction.target,
    self.speed * delta
  )
end

function Shield:draw()
  love.graphics.print(self.state, 32, 32)
  
  love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)
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
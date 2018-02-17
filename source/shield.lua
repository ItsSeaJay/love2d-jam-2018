-- shield.lua

Shield = Object:extend()

function Shield.new(self)
  self.states = {}
  self.states.up = "up"
  self.states.down = "down"
  self.states.left = "left"
  self.states.right = "right"
  
  self.state = self.states.left
  
  self.position = {}
  self.position.x = love.graphics.getWidth() / 2
  self.position.y = love.graphics.getHeight() / 2
  
  self.size = {}
  self.size.width = 32
  self.size.height = 32
  
  self.origin = {}
  self.origin.x = self.size.width / 2
  self.origin.y = self.size.height / 2
  
  self.direction = 0 -- Measured in degrees
end

function Shield.update(self, delta)  
  if self.state == self.states.up then
    -- up state
    self.direction = self.direction + 1 * delta
  elseif self.state == self.states.down then
    -- down state
    self.direction = self.direction + 1 * delta
  elseif self.state == self.states.left then
    -- left state
    self.direction = self.direction + 1 * delta
  elseif self.state == self.states.right then
    -- right state
    self.direction = self.direction + 1 * delta
  else
    -- default
  end
end

function Shield.draw(self)
  love.graphics.print(self.state, 32, 32)
  
  love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)
    love.graphics.rotate(self.direction)
    love.graphics.rectangle(
      "fill",
      -self.size.width / 2,
      -self.size.height / 2,
      self.size.width,
      self.size.height
    )
  love.graphics.pop()
end
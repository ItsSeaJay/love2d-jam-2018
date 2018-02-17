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
  
  self.width = 32
  self.height = 32
  
  self.origin = {}
  self.origin.x = self.width / 2
  self.origin.y = self.height / 2
  
  self.rotation = 0
end

function Shield.update(self, delta)  
  if self.state == self.states.up then
    -- up state
  elseif self.state == self.states.down then
    -- down state
  elseif self.state == self.states.left then
    -- left state
  elseif self.state == self.states.right then
    -- right state
  else
    -- default
  end
end

function Shield.draw(self)
  love.graphics.print(self.state, 32, 32)
  
  love.graphics.rectangle(
    "fill",
    self.position.x,
    self.position.y,
    self.width,
    self.height
  )
end
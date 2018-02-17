-- player.lua

Player = Object:extend()

function Player:new(x, y)  
  self.shield = Shield(x, y)
  
  -- inputs
  self.inputs = {}
  self.inputs.up = "w"
  self.inputs.down = "s"
  self.inputs.left = "a"
  self.inputs.right = "d"
  
  -- transform
  self.position = {}
  self.position.x = x
  self.position.y = y
  
  self.size = {}
  self.size.width = 32
  self.size.height = 32
  
  self.origin = {}
  self.origin.x = -self.size.width / 2
  self.origin.y = -self.size.height / 2
end

function Player:update(delta)
  if love.keyboard.isDown(self.inputs.up) then
    self.shield.state = self.shield.states.up
  elseif love.keyboard.isDown(self.inputs.down) then
    self.shield.state = self.shield.states.down
  elseif love.keyboard.isDown(self.inputs.left) then
    self.shield.state = self.shield.states.left
  elseif love.keyboard.isDown(self.inputs.right) then
    self.shield.state = self.shield.states.right
  end
  
  self.shield:update(delta)
end

function Player:draw()
  love.graphics.push()
    love.graphics.translate(
      self.position.x,
      self.position.y
    )
    love.graphics.rectangle(
      "fill",
      self.origin.x,
      self.origin.y,
      self.size.width,
      self.size.height
    )
  love.graphics.pop()
  
  self.shield:draw()
end
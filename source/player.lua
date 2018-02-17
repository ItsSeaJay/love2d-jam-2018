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
  self.transform = Transform(x, y, 32, 32)
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
      self.transform.position.x,
      self.transform.position.y
    )
    love.graphics.rectangle(
      "fill",
      self.transform.origin.x,
      self.transform.origin.y,
      self.transform.size.width,
      self.transform.size.height
    )
  love.graphics.pop()
  
  self.shield:draw()
end
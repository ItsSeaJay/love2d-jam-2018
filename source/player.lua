-- player.lua

Player = Object:extend()

function Player:new()
  self.shield = Shield()
  
  self.inputs = {}
  self.inputs.up = "w"
  self.inputs.down = "s"
  self.inputs.left = "a"
  self.inputs.right = "d"
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
  self.shield:draw()
end
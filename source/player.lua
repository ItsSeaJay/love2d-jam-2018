-- player.lua

Player = Object:extend()

function Player:new()
  self.shield = Sheild()
end

function Player:update(delta)
  self.shield:update(delta)
end

function Player:draw()
  self.sheild:draw()
end
-- player.lua

Player = Object:extend()

function Player:new()
  self.shield = Shield()
end

function Player:update(delta)
  self.shield:update(delta)
end

function Player:draw()
  self.shield:draw()
end
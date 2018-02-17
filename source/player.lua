-- player.lua

Player = Object:extend()

function Player:new()
  self.shield = Sheild()
end

function Player:update(delta)
  -- TODO: allow player to update shield
end

function Player:draw()
  -- TODO: draw player
end
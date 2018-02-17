-- shield.lua

Shield = Object:extend()

function Shield.new(self)
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2
  
  self.width = 32
  self.height = 32
end

function Shield.update(self, delta)
  -- TODO: update shield
end

function Shield.draw(self)
  love.graphics.rectangle(
    "fill",
    self.x,
    self.y,
    self.width,
    self.height
  )
end
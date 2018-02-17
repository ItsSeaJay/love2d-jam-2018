-- shield.lua

Shield = Object:extend()

function Shield.new(self)
  self.test = math.random() * 6 + 1
end

function Shield.update()
  -- TODO: update shield
end

function Shield.draw()
  -- TODO: draw shield
end
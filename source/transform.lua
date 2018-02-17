-- transform.lua

Transform = Object:extend()

function Transform:new(x, y, width, height)
  self.position = {}
  self.position.x = x
  self.position.y = y
  
  self.size = {}
  self.size.width = width
  self.size.height = height
end
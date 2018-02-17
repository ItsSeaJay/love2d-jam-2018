-- transform.lua

Transform = Object:extend()

function Transform:new(x, y, width, height)
  -- position
  self.position = {}
  self.position.x = x
  self.position.y = y
  
  -- size
  self.size = {}
  self.size.width = width
  self.size.height = height
  
  -- origin
  -- default origin to the center of the object
  self.origin = {}
  self.origin.x = -self.size.width / 2
  self.origin.y = -self.size.height / 2
end
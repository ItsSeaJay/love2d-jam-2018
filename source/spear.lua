-- spear.lua

Spear = Object:extend()

function Spear:new(x, y)
  self.destroyed = false
  self.transform = Transform(x, y, 16, 32)
  self.direction = 180
  self.speed = 32
end

function Spear:update(delta)
  -- move according to direction
  self.transform.position.x = self.transform.position.x +
    math.sin(math.rad(self.direction) * self.speed)
  self.transform.position.y = self.transform.position.y +
    math.cos(math.rad(self.direction) * self.speed)
end

function Spear:draw()
  love.graphics.push()
    love.graphics.translate(
      self.transform.position.x,
      self.transform.position.y
    )
    love.graphics.rotate(math.rad(self.direction))
    love.graphics.rectangle(
      "fill",
      self.transform.origin.x,
      self.transform.origin.y,
      self.transform.size.width,
      self.transform.size.height
    )
  love.graphics.pop()
end
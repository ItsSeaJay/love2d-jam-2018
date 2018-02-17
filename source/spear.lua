-- spear.lua

Spear = Object:extend()

function Spear:new(x, y)
  self.destroyed = false
  self.transform = Transform(x, y, 16, 32)
  self.direction = 180
  self.speed = 64
  
  self.velocity = {}
  self.velocity.x = 0
  self.velocity.y = 0
  
  self.hitbox = HC.rectangle(
    self.transform.position.x,
    self.transform.position.y,
    self.transform.size.x,
    self.transform.size.y
  )
end

function Spear:update(delta)
  -- move according to the spear's direction
  -- measured in degrees, where 0 is up
  self.velocity.x = math.sin(math.rad(self.direction)) * self.speed * delta
  self.velocity.y = -math.cos(math.rad(self.direction)) * self.speed * delta
  
  self.transform.position.x = self.transform.position.x + self.velocity.x
  self.transform.position.y = self.transform.position.y + self.velocity.y
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
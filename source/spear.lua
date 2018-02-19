-- spear.lua

Spear = Object:extend()

function Spear:new(x, y, direction, speed)
  self.destroyed = false
  self.transform = Transform(x, y, 16, 32)
  self.direction = direction
  self.speed = speed
  
  self.velocity = {}
  self.velocity.x = 0
  self.velocity.y = 0
  
  self.hitbox = HC.rectangle(
    self.transform.position.x + self.transform.origin.x,
    self.transform.position.y + self.transform.origin.y,
    self.transform.size.width,
    self.transform.size.height
  )
  self.tag = "troop"
  
  self.sprite = love.graphics.newImage("resources/graphics/spear.png")
end

function Spear:update(deltaTime)
  -- move according to the spear's direction
  -- measured in degrees, where 0 is up
  self.velocity.x = math.sin(math.rad(self.direction)) * self.speed * deltaTime
  self.velocity.y = -math.cos(math.rad(self.direction)) * self.speed * deltaTime
  
  self.transform.position.x = self.transform.position.x + self.velocity.x
  self.transform.position.y = self.transform.position.y + self.velocity.y
  
  self.hitbox:setRotation(math.rad(self.direction))
  self.hitbox:moveTo(self.transform.position.x, self.transform.position.y)
  
  -- check for collisions
  for other, delta in pairs(HC.collisions(self.hitbox)) do 
    if other.tag == "player" then
      self.destroyed = true
      player.lives = math.max(player.lives - 1, 0)
      player.damageTime = player.damageTimer
      sounds.hurt:play()
    elseif other.tag == "shield" then
      self.destroyed = true
      player.score = player.score + 1
      sounds.block:play()
    end
  end
end

function Spear:draw()
  -- draw hitbox
  if debug then
    love.graphics.setColor(255, 0, 0)
    self.hitbox:draw('line')
  end
  
  love.graphics.push()
    love.graphics.setColor(255, 255, 255)
    love.graphics.translate(
      self.transform.position.x,
      self.transform.position.y
    )
    love.graphics.rotate(math.rad(self.direction))
    love.graphics.draw(
      self.sprite,
      self.transform.origin.x - (self.sprite:getWidth() / 3),
      self.transform.origin.y
    )
  love.graphics.pop()
end
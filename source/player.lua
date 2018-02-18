-- player.lua

Player = Object:extend()

function Player:new(x, y)
  -- shield
  self.shield = Shield(x, y)
  
  -- inputs
  self.inputs = {}
  self.inputs.up = "w"
  self.inputs.down = "s"
  self.inputs.left = "a"
  self.inputs.right = "d"
  
  -- transform
  self.transform = Transform(x, y, 32, 32)
  
  -- colour
  self.colour = {}
  self.colour.red = 255
  self.colour.green = 255
  self.colour.blue = 255
  
  -- hitbox
  self.hitbox = HC.rectangle(
    self.transform.position.x + self.transform.origin.x,
    self.transform.position.y + self.transform.origin.y,
    self.transform.size.width,
    self.transform.size.height
  )
  self.hitbox.tag = "player"
  
  -- lives
  self.lives = 3
  
  -- score
  self.score = 0
end

function Player:update(deltaTime)
  -- reposition the player's shield when keys are pressed
  if love.keyboard.isDown(self.inputs.up) then
    self.shield.state = self.shield.states.up
  elseif love.keyboard.isDown(self.inputs.down) then
    self.shield.state = self.shield.states.down
  elseif love.keyboard.isDown(self.inputs.left) then
    self.shield.state = self.shield.states.left
  elseif love.keyboard.isDown(self.inputs.right) then
    self.shield.state = self.shield.states.right
  end
  
  self.shield:update(deltaTime)
  
  -- check for collisions
  for other, delta in pairs(HC.collisions(self.hitbox)) do 
    -- TODO: better collisions
  end
  
  -- death
  if self.lives <= 0 then
    self.die()
  end
end

function Player:draw()
  -- debug drawing
  if debug then
    -- hitbox
    love.graphics.setColor(255, 0, 0)
    self.hitbox:draw('line')
    
    -- life count
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(self.lives, 32, 32)
    
    -- score
    love.graphics.print(self.score, 32, 96)
  end  
  
  -- draw the player themselves
  love.graphics.push()
    love.graphics.setColor(
      self.colour.red,
      self.colour.green,
      self.colour.blue
    )
    love.graphics.translate(
      self.transform.position.x,
      self.transform.position.y
    )
    love.graphics.rectangle(
      "fill",
      self.transform.origin.x,
      self.transform.origin.y,
      self.transform.size.width,
      self.transform.size.height
    )
  love.graphics.pop()
  
  self.shield:draw()
end

function Player:die()
  game.state = game.states.over
end
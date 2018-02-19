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
  self.direction = 0
  
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
  
  -- image
  self.image = love.graphics.newImage("resources/graphics/knight1.png")
  
  -- damage
  self.damageTimer = 0.33
  self.damageTime = 0
end

function Player:update(deltaTime)  
  self.shield:update(deltaTime)
  
  if self.lives <= 0 then
    self.die()
  end
  
  self.damageTime = math.max(self.damageTime - deltaTime, 0)
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
  
  -- draw the life count
  love.graphics.setFont(fonts.m5x7)
  love.graphics.print(
    self.lives,
    love.graphics.getWidth() / 2 - 16,
    love.graphics.getHeight() / 2
  )
  
  -- draw the player themselves
  love.graphics.push()
    if self.damageTime > 0 then
      love.graphics.setColor(255, 0, 0)
    else
      love.graphics.setColor(
        self.colour.red,
        self.colour.green,
        self.colour.blue
      )
    end
    love.graphics.translate(
      self.transform.position.x,
      self.transform.position.y
    )
    love.graphics.draw(
      self.image, -- sprite
      self.transform.origin.x, -- position x
      self.transform.origin.y, -- position y
      self.direction, -- rotation
      1, -- width
      1, -- height
      self.image:getWidth() / 3, -- origin x
      self.image:getHeight() / 3 -- origin y
    )
  love.graphics.pop()
  
  self.shield:draw()
end

function Player:keypressed(key)
  -- move the shield when keys are pressed
  if key == player.inputs.up or key == "up" then
    self.shield:turnTo(0)
  elseif key == player.inputs.down or key == "down" then
    self.shield:turnTo(math.pi)
  elseif key == player.inputs.left or key == "left" then
    self.shield:turnTo(math.pi * 1.5)
  elseif key == player.inputs.right or key == "right" then
    self.shield:turnTo(math.pi * 0.5)
  end
end

function Player:die()
  game.state = game.states.over
end
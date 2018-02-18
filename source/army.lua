-- army.lua

Army = Object:extend()

function Army:new()
  
  self.transform = Transform(0, 0, 1, 1)
  self.troops = {}
  
  -- spawn points
  self.points = {}
  self.points.top = Transform(
    love.graphics.getWidth() / 2,
    -32,
    1,
    1
  )
  self.points.bottom = Transform(
    love.graphics.getWidth() / 2,
    love.graphics.getHeight() + 32,
    1,
    1
  )
  self.points.left = Transform(
    -32,
    love.graphics.getHeight() / 2,
    1,
    1
  )
  self.points.right = Transform(
    love.graphics.getHeight() / 2,
    love.graphics.getWidth() + 32,
    1,
    1
  )
  
  -- spawn in test spear
  table.insert(
    self.troops,
    Spear(
      self.points.bottom.position.x,
      self.points.bottom.position.y,
      0,
      128
    )
  )
end

function Army:update(deltaTime)
  -- debug controls
  if debug then
    if love.keyboard.isDown("space") then
      table.insert(
        self.troops,
        Spear(
          self.points.bottom.position.x,
          self.points.bottom.position.y,
          0,
          128
        )
      )
    end
  end
  
  -- update all troops
  for key, troop in ipairs(self.troops) do
    troop:update(deltaTime)
  end
  
  -- remove destroyed troops
  for i = #self.troops, 1, -1 do
    -- get a local instance of the troop
    local troop = self.troops[i]
    
    if troop.destroyed then
      table.remove(self.troops, i)
    end
  end
end

function Army:draw(deltaTime)
  for key, troop in ipairs(self.troops) do
    troop:draw()
  end
end
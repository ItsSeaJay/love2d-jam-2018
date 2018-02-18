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
  
  if debug then
    -- spawn test spear
    self:enlist(Spear, self.points.right)
  end
end

function Army:update(deltaTime)
  -- debug controls
  if debug then
    -- do debug stuff...
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

function Army:enlist(kind, position)
  local direction = 0
  
  if position == self.points.top.position then
    -- go down
    direction = 180
  elseif position == self.points.top.position then
    -- go up
    direction = 0
  elseif position == self.points.left.position then
    -- go right
    direction = 90
  elseif position == self.points.right.position then
    -- go left
    direction = 90
  end
  
  table.insert(
    self.troops,
    kind(
      position.x,
      position.y,
      direction,
      32
    )
  )
end
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
  ).position
  self.points.bottom = Transform(
    love.graphics.getWidth() / 2,
    love.graphics.getHeight() + 32,
    1,
    1
  ).position
  self.points.left = Transform(
    -32,
    love.graphics.getHeight() / 2,
    1,
    1
  ).position
  self.points.right = Transform(
    love.graphics.getWidth() + 32,
    love.graphics.getHeight() / 2,
    1,
    1
  ).position
  
  -- difficulty
  self.difficulty = 1
  self.timer = self.difficulty
end

function Army:update(deltaTime)
  -- debug controls
  if debug then
    -- do debug stuff...
  end
  
  -- update all enlisted troops
  for key, troop in ipairs(self.troops) do
    troop:update(deltaTime)
  end
  
  -- tick timer downward
  self.timer = math.max(self.timer - deltaTime, 0)
  
  if self.timer == 0 then
    self:enlist(Spear, self:getRandomPoint())
    self.timer = self.difficulty
  end
  
  self:teardown()
end

function Army:draw(deltaTime)
  for key, troop in ipairs(self.troops) do
    troop:draw()
  end
end

function Army:teardown()
  for i = #self.troops, 1, -1 do
    -- get a local instance of the troop
    local troop = self.troops[i]
    
    if troop.destroyed then
      -- remove that troop
      table.remove(self.troops, i)
    end
  end
end

function Army:enlist(kind, position)
  local direction = 0
  
  -- figure out where that troop should move towards
  -- based on where it spawned
  if position == self.points.top then
    -- go down
    direction = 180
  elseif position == self.points.top then
    -- go up
    direction = 0
  elseif position == self.points.left then
    -- go right
    direction = 90
  elseif position == self.points.right then
    -- go left
    direction = 270
  end
  
  -- enlist that kind of troop
  table.insert(
    self.troops,
    kind(
      position.x,
      position.y,
      direction,
      128
    )
  )
end

function Army:getRandomPoint()
  local points = {}
  
  -- make a copy of the spawn points using numerical keys
  for key, point in pairs(self.points) do
    table.insert(
      points,
      point
    )
  end
  
  -- return a random index
  local selected = math.floor(math.random() * #points + 1)
  
  return points[selected]
end
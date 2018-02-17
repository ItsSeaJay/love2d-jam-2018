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
    love.graphics.getHeight() + 32,
    love.graphics.getWidth() / 2,
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
end

function Army:update(deltaTime)
  -- debug controls
  if debug then
    if love.keyboard.isDown("space") then
      table.insert(
        self.troops,
        Spear(
          0,
          0,
          0,
          32
        )
      )
    end
  end
end
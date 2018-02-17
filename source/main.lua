-- main.lua

function love.load()
  Object = require "classic"
  
  require "player"
  require "shield"
  require "maths"
  
  player = Player()
  
  debug = true
end

function love.update(delta)
  -- Debug controls
  if debug then
    if love.keyboard.isDown("escape") then
      love.event.quit()
    end
    
    if love.keyboard.isDown("f5") then
      love.load()
    end
  end
  
  player:update(delta)
end

function love.draw()
  player:draw()
end
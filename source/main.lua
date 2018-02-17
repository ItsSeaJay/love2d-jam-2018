-- main.lua

function love.load()
  Object = require "classic"
  
  require "shield"
  require "maths"
  
  shield = Shield()
  
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
  
  shield.update(shield, delta)
end

function love.draw()
  shield.draw(shield)
end
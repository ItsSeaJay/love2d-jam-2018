-- main.lua

function love.load()
  Object = require "classic"
  
  require "shield"
  
  shield = Shield()
end

function love.update(delta)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
  
  shield.update(shield, delta)
end

function love.draw()
  shield.draw(shield)
end
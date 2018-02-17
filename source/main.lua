-- main.lua

function love.load()
  -- requirements
  Object = require "classic"
  
  require "transform"
  require "player"
  require "spear"
  require "shield"
  require "lerp"
  
  -- game
  game = {}
  game.title = "LOVE Jam 2018"
  
  love.window.setTitle(game.title)
  
  -- player
  player = Player(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  
  -- enemies
  enemies = {}
  enemies.test = Spear()
  
  -- debug
  debug = true
end

function love.update(delta)
  -- debug controls
  if debug then
    if love.keyboard.isDown("escape") then
      love.event.quit()
    end
    
    if love.keyboard.isDown("f5") then
      love.load()
    end
  end
  
  player:update(delta)
  
  for enemy in pairs(enemies) do
    -- enemy:update(delta)
  end
  
  love.teardown()
end

function love.draw()
  player:draw()
end

function love.teardown()
  -- TODO: destroy enemies (not literally)
end
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
  game.title = "LÖVE Jam 2018"
  
  love.window.setTitle(game.title)
  
  -- player
  player = Player(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  
  -- enemies
  enemies = {}
  enemies.test = Spear(love.graphics.getWidth() / 2, -128)
  
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
  
  -- update game objects
  player:update(delta)
  enemies.test:update(delta)
  
  -- destroy marked objects
  love.teardown()
end

function love.draw()
  -- draw game objects
  player:draw()
  enemies.test:draw(delta)
end

function love.teardown()
  -- TODO: destroy enemies (not literally)
end
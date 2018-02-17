-- main.lua

function love.load()
  -- requirements
  -- 3rd party
  Object = require "libraries/classic"
  HC = require "libraries/HC"
  
  -- 1st party
  require "transform"
  require "player"
  require "army"
  require "spear"
  require "shield"
  require "lerp"
  
  game = {}
  game.title = "LÖVE Jam 2018"
  
  love.window.setTitle(game.title)
  
  -- player
  player = Player(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  army = Army()
  
  -- debug
  debug = true
end

function love.update(deltaTime)
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
  player:update(deltaTime)
  army:update(deltaTime)
  
  -- destroy marked objects
  love.teardown()
end

function love.draw()
  -- debug messages
  if debug then
    
  end
  
  -- draw game objects
  love.graphics.setColor(255, 255, 255)
  player:draw()
  army:draw()
end

function love.teardown()
end
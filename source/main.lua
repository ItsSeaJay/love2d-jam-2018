-- main.lua

console = {}

function love.load()
  -- requirements
  -- 3rd party
  Object = require "libraries/classic"
  HC = require "libraries/HC"
  
  -- 1st party
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
  enemies.test = Spear(love.graphics.getWidth() / 2, -32)
  
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
  enemies.test:update(deltaTime)
  
  -- destroy marked objects
  love.teardown()
end

function love.draw()
  -- debug messages
  if debug then
    -- print console
    for i = 1, #console do
      love.graphics.setColor(255, 255, 255, 255 - (i - 1) * 6)
      love.graphics.print(console[#console - (i - 1)], 10, i * 15)
    end
  end
  
  -- draw game objects
  love.graphics.setColor(255, 255, 255)
  player:draw()
  enemies.test:draw(delta)
end

function love.teardown()
  -- TODO: destroy enemies (not literally)
end
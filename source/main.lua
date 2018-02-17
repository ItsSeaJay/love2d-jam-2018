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
  
  -- projectiles
  projectiles = {}
  table.insert(
    projectiles,
    Spear(
      32,
      love.graphics.getHeight() / 2,
      90,
      32
    )
  )
  
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
  
  -- update projectiles
  for i = #projectiles, 1, -1 do
    local projectile = projectiles[i]
    
    projectile:update(deltaTime)
  end
  
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
  
  -- draw projectiles
  for i = #projectiles, 1, -1 do
    local projectile = projectiles[i]
    
    projectile:draw()
  end
end

function love.teardown()
  -- remove destroyed particles
  for i = #projectiles, 1, -1 do
    local projectile = projectiles[i]
    
    if projectile.destroyed then
      table.remove(projectiles, i)
    end
  end
end
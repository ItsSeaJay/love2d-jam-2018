-- main.lua

math.randomseed(os.time())

function love.load()
  -- requirements
  -- 3rd party
  Object = require "libraries/classic"
  HC = require "libraries/HC"
  easing = require "libraries/easing"
  anim8 = require "libraries/anim8"
  
  -- 1st party
  require "transform"
  require "player"
  require "army"
  require "spear"
  require "shield"
  require "range"
  require "lerp"
  
  -- game
  game = {}
  game.title = "LÖVE Jam 2018"
  
  game.states = {}
  game.states.playing = "playing"
  game.states.paused = "paused"
  game.states.over = "over"
  
  game.state = game.states.playing
  
  love.window.setTitle(game.title)
  
  -- tiles
  tiles = {}
  tiles.cobblestone = love.graphics.newImage("resources/graphics/cobblestone.png")
  
  -- courtyard
  courtyard = love.graphics.newImage("resources/graphics/courtyard.png")
  
  -- player
  player = Player(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  army = Army()
  
  -- debug
  debug = false
end

function love.update(deltaTime)
  -- debug controls
  if debug then    
    if love.keyboard.isDown("f5") then
      love.load()
    end
  end
  
  -- update game state machine
  if game.state == game.states.playing then
    -- update the player and army
    player:update(deltaTime)
    army:update(deltaTime)
  elseif game.state == game.states.paused then
    
  end
  
  -- destroy marked objects
  love.teardown()
end

function love.draw()  
  -- draw game objects
  if game.state == game.states.playing then
    -- Courtyard
    love.graphics.draw(
      courtyard,
      0,
      0
    )
    
    -- game entities
    player:draw()
    army:draw()
  elseif game.state == game.states.paused then
    love.graphics.print(
      "Paused",
      love.graphics.getWidth() / 2,
      love.graphics.getHeight() / 2
    )
  elseif game.state == game.states.over then
    love.graphics.print(
      "Game Over",
      love.graphics.getWidth() / 2,
      love.graphics.getHeight() / 2
    )
  end
end

function love.teardown()
end

function love.keypressed(key)
  if game.state == game.states.playing then
    if key == "escape" then
      game.state = game.states.paused
    end
    
    -- handle player input
    player:keypressed(key)
  elseif game.state == game.states.paused then
    if key == "escape" then
      game.state = game.states.playing
    end
  elseif game.state == game.states.over then
    if key == "space" then
      love.load()
    end
  end
end
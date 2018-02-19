-- main.lua

math.randomseed(os.time())

function love.load()
  Object = require "libraries/classic"
  HC = require "libraries/HC"
  easing = require "libraries/easing"
  anim8 = require "libraries/anim8"
  
  require "transform"
  require "player"
  require "army"
  require "spear"
  require "shield"
  require "range"
  require "lerp"
  
  game = {}
  game.title = "LÖVE Jam 2018"
  
  game.states = {}
  game.states.playing = "playing"
  game.states.paused = "paused"
  game.states.over = "over"
  
  game.state = game.states.playing
  
  love.window.setTitle(game.title)
  
  tiles = {}
  tiles.cobblestone = love.graphics.newImage("resources/graphics/cobblestone.png")
  tiles.bricks = love.graphics.newImage("resources/graphics/big-bricks.png")
  
  titles = {}
  titles.paused = love.graphics.newImage("resources/graphics/paused.png")
  
  courtyard = love.graphics.newImage("resources/graphics/courtyard.png")
  
  fonts = {}
  fonts.m5x7 = love.graphics.newFont("resources/fonts/m5x7.ttf", 64)
  
  player = Player(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  army = Army()
  
  debug = false
end

function love.update(deltaTime)
  -- debug controls
  if debug then
    -- allow a quick restart
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
    -- calculate sin wave
    local wave = {}
    wave.crest = math.sin(love.timer.getTime())
    wave.height = 16
    local offset = 128
    
    -- background
    for x = 0, 16, 1 do
      for y = 0, 16, 1 do
        love.graphics.draw(
          tiles.bricks,
          x * tiles.bricks:getWidth(),
          y * tiles.bricks:getHeight()
        )
      end
    end
    
    -- title
    love.graphics.draw(
      titles.paused,
      (love.graphics.getWidth() / 2),
      (love.graphics.getHeight() / 2) + 
        (wave.crest * wave.height) - 
        offset,
      0,
      1,
      1,
      titles.paused:getWidth() / 2,
      titles.paused:getHeight() / 2
    )
    
    -- information
    love.graphics.setFont(fonts.m5x7)
    love.graphics.print(
      "Press escape to continue.",
      love.graphics.getWidth() / 2 - 256,
      love.graphics.getHeight() / 2
    )
  elseif game.state == game.states.over then
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle(
      "fill",
      0,
      0,
      love.graphics.getWidth(),
      love.graphics.getHeight()
    )
    love.graphics.setColor(255, 255, 255)
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
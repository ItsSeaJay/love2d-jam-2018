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
  
  game.state = game.states.title
  
  deathFlashTimer = 0.1
  deathFlashTime = deathFlashTimer
  
  love.window.setTitle(game.title)
  
  tiles = {}
  tiles.cobblestone = love.graphics.newImage("resources/graphics/cobblestone.png")
  tiles.bricks = love.graphics.newImage("resources/graphics/big-bricks.png")
  
  titles = {}
  titles.main = love.graphics.newImage("resources/graphics/title-screen.png")
  titles.paused = love.graphics.newImage("resources/graphics/paused.png")
  titles.slain = love.graphics.newImage("resources/graphics/slain.png")
  
  courtyard = love.graphics.newImage("resources/graphics/courtyard.png")
  
  fonts = {}
  fonts.m5x7 = love.graphics.newFont("resources/fonts/m5x7.ttf", 64)
  
  player = Player(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  army = Army()
  
  sounds = {}
  sounds.death = love.audio.newSource("resources/audio/death.wav", "static")
  sounds.pause = love.audio.newSource("resources/audio/pause.wav", "static")
  sounds.block = love.audio.newSource("resources/audio/shield-block.wav", "static")
  sounds.hurt = love.audio.newSource("resources/audio/hurt.wav", "static")
  sounds.throw = love.audio.newSource("resources/audio/throw.wav", "static")
  
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
    
  elseif game.state == game.states.over then
    deathFlashTime = math.max(deathFlashTime - deltaTime, 0)    
  end
end

function love.draw()  
  -- draw game objects
  if game.state == game.states.title then
    love.graphics.draw(
      titles.main,
      0,
      0
    )
  elseif game.state == game.states.playing then
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
    -- background
    love.graphics.setColor(208, 70, 72)
    love.graphics.rectangle(
      "fill",
      0,
      0,
      love.graphics.getWidth(),
      love.graphics.getHeight()
    )
    love.graphics.setColor(255, 255, 255)
    
    -- title
    love.graphics.draw(
      titles.slain,
      (love.graphics.getWidth() / 2),
      (love.graphics.getHeight() / 2),
      0,
      1,
      1,
      titles.paused:getWidth() / 2,
      titles.paused:getHeight() / 2
    )
    
    -- information
    love.graphics.setFont(fonts.m5x7)
    
    -- react to the player's score
    if player.score > 0 then
      love.graphics.printf(
      "...but you managed to block " ..
        player.score ..
        " spears.",
      love.graphics.getWidth() / 2 - 258,
      love.graphics.getHeight() - 256,
      love.graphics.getWidth() / 2,
      "left"
    )
  else
    love.graphics.printf(
      "...horribly.",
      love.graphics.getWidth() / 2 - 128,
      love.graphics.getHeight() - 200,
      love.graphics.getWidth() / 2,
      "left"
    )
  end
    
    love.graphics.print(
      "press escape to restart",
      love.graphics.getWidth() / 2 - 258,
      love.graphics.getHeight() - 128
    )
    
    -- flash
    if deathFlashTime > 0 then
      love.graphics.setColor(255, 255, 255)
      love.graphics.rectangle(
        "fill",
        0,
        0,
        love.graphics.getWidth(),
        love.graphics.getHeight()
      )
      love.graphics.setColor(255, 255, 255)
    end
  end
end

function love.keypressed(key)
  if game.state == game.states.title then
    if key == "escape" then
      reset()
    end
  elseif game.state == game.states.playing then
    if key == "escape" then
      game.state = game.states.paused
      sounds.pause:play()
    end
    -- handle player input
    player:keypressed(key)
  elseif game.state == game.states.paused then
    if key == "escape" then
      game.state = game.states.playing
    end
  elseif game.state == game.states.over then
    if key == "escape" then
      reset()
    end
  end
end

function reset()
  game.state = game.states.playing
  
  player.lives = 3
  player.score = 0
  player.damageTimer = 0
  
  player.shield.direction = 0
  
  -- clear enemy troops
  for i in pairs (army.troops) do
    army.troops [i] = nil
  end
  
  army.difficulty = 1 -- lower values are harder
  army.timer = army.difficulty
  army.speed = 128
  army.speedup = 2
  army.maxspeed = 512
end
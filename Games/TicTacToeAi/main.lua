love.window.setMode(480, 720)

-- global things goes here
sx,sy = love.graphics.getDimensions()
button = require("button")
--------------------------

local page = 1

function change_page(pn)
  page = pn
end

local welcome = require("welcome_screen")
local game = require("game")

current_page = welcome

function love.load()
  font = love.graphics.newFont("Unikuweb.ttf", 15)
  love.graphics.setFont(font)
end

function love.update(dt)
  if page == 1 then
    current_page = welcome
  elseif page == 2 then
    current_page = game
  end
end

function love.draw()
  current_page.draw()
  if love.keyboard.isDown('h') then
    current_page = game
  end
end

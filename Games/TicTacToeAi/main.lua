love.window.setMode(480, 720)
local welcome = require("welcome_screen")
local game = require("game")

local button = require("button")

-- loading nececary stuff to the modules
welcome.button = button

local current_page = welcome

function love.load()
  welcome.load()

  font = love.graphics.newFont("Unikuweb.ttf", 15)
  love.graphics.setFont(font)
end

function love.draw()
  current_page.draw()
  if love.keyboard.isDown('h') then
    current_page = game
  end
end

love.window.setMode(480, 720)
local welcome = require("welcome_screen")
local game = require("game")

--local button = require("button")

local passed_values = 9
welcome.passed_values = passed_values

local current_page = welcome

function love.load(arg)
  font = love.graphics.newFont("Unikuweb.ttf", 15)
  love.graphics.setFont(font)
end

function love.draw()
  current_page.draw()
  if love.keyboard.isDown('h') then
    current_page = game
  end
end

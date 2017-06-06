function love.load()
  debug = ''
  points = {}

  learning_rate = 0.01

  sw, sh = love.graphics.getDimensions()

  square_size = 50
end

function love.update(dt)
  debug = 'Number of points: ' .. #points

  for i, v in pairs(points) do
    -- do stuff
  end
end

function love.draw()
  screen = {}
  for i = 0, sw - square_size, square_size do
    for j = 0, sh - square_size, square_size do
      screen[j*square_size+i] = 0
    end
  end

  for i, v in pairs(points) do
    x = v.x/square_size
    y = v.y/square_size
    screen[y*square_size+x] = 255
    print(y*square_size + x)
  end

  for i = 0, sw - square_size, square_size do
    for j = 0, sh - square_size, square_size do
      x = i/square_size
      y = j/square_size

      love.graphics.setColor(screen[0], 0, 0)
      love.graphics.rectangle('fill', i, j, square_size, square_size)
    end
  end

  for i, v in pairs(points) do
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle('fill', v.x, v.y, 5)
  end



  love.graphics.setColor(55, 200, 100)
  love.graphics.setFont(love.graphics.newFont(20))
  love.graphics.print(debug, 50, 20)
end

pressed = false
function love.mousepressed(xx, yy, button, isTouch)
  if pressed == false then
    if button == 1 then
      table.insert(points, {x=xx, y=yy})
    end
    pressed = true
  end
end
function love.mousereleased(x, y, button, isTouch)
  if button == 1 then
    pressed = false
  end
end

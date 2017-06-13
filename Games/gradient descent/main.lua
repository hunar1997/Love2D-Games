function love.load()
  debug = ''
  points = {}

  learning_rate = 0.00001

  sw, sh = love.graphics.getDimensions()
  w1, w2 = 1, 1
  square_size = 20
end
function learn()
  for i = 0, sw - square_size, square_size do
    for j = 0, sh - square_size, square_size do
      x = math.floor(i/square_size)
      y = math.floor(j/square_size)

      actual = screen[y*width+x]
      error = actual + (w1*x+w2*y)

      w1 = w1 + (2*error*x)*learning_rate
      w2 = w2 + (2*error*y)*learning_rate
    end
  end
end

function love.update(dt)
  debug = 'Number of points: ' .. #points

  width = sw/square_size
  screen = {}
  for i = 0, sw - square_size, square_size do
    for j = 0, sh - square_size, square_size do
      x = math.floor(i/square_size)
      y = math.floor(j/square_size)
      screen[y*width+x] = x*w1+y*w2
    end
  end

  for i, v in pairs(points) do
    x = math.floor(v.x/square_size)
    y = math.floor(v.y/square_size)
    screen[y*width+x] = 255
  end
end

function love.draw()
  for i = 0, sw - square_size, square_size do
    for j = 0, sh - square_size, square_size do
      x = math.floor(i/square_size)
      y = math.floor(j/square_size)

      love.graphics.setColor(screen[y*width+x], screen[y*width+x], 0)
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

function love.keyreleased(key)
  if key=='l' then
    learn()
    print(w1, w2)
  end
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

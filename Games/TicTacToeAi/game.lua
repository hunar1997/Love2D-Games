local M = {}

bx = sw*.1
by = sh*.3
size = sw*.8

function M.draw()
  -- the four lines
  love.graphics.setColor(0, 255, 0)
  love.graphics.line(bx+size/3, by, bx+size/3, by+size)
  love.graphics.line(bx+size/3*2, by, bx+size/3*2, by+size)
  love.graphics.line(bx, by+size/3, bx+size, by+size/3)
  love.graphics.line(bx, by+size/3*2, bx+size, by+size/3*2)

  -- boundary box
  love.graphics.setColor(0, 255, 255)
  love.graphics.line(bx, by, bx+size, by)
  love.graphics.line(bx, by+size, bx+size, by+size)
  love.graphics.line(bx, by, bx, by+size)
  love.graphics.line(bx+size, by, bx+size, by+size)

  -- title
  love.graphics.print("Turn: ",sw*.3, sh*.1)
end

return M

local M = {}

function M.make_button(x_, y_, width_, height_, text_, color_button_, color_text_, callback_)

  local table = {
    x = x_*sx - width_*sx/2,
    y = y_*sy - height_*sy/2,
    width = width_*sx,
    height = height_*sy,
    text = text_,
    color = color_,
    color_button = color_button_,
    color_text = color_text_,
    callback = callback_
  }
  function table:check()
    if love.mouse.isDown(1) then
      mx = love.mouse.getX()
      my = love.mouse.getY()
      if mx>table.x and mx<table.x+table.width and my>table.y and my<table.y+table.height then
        table.callback()
      end
    end
  end
  function table:draw()
    love.graphics.setColor(table.color_button)
    love.graphics.rectangle('fill', table.x, table.y, table.width, table.height)
    love.graphics.setColor(table.color_text)
    love.graphics.print(table.text, table.x, table.y)
  end
  return table
end

return M

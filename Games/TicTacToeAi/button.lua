local M = {}

function M.make_button(x_, y_, width_, height_, text_, color_)

  local table = {
    x = x_,
    y = y_,
    width = width_,
    height = height_,
    text = text_,
    color = color_
  }
  function table:draw()
    
  end
  return table
end

return M

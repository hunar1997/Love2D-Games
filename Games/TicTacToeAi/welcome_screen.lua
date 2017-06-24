local M = {}

function M.is_it_working()
  change_page(2)
end

M.enter = button.make_button(.5, .5, .8, .2, "Start game", {255, 0, 0}, {0, 255, 255}, M.is_it_working)

function M.draw()
  M.enter:check()
  M.enter:draw()
end

return M

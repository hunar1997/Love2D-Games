local M = {}

function is_it_working()
  print("yes it is :D finally aaaaaaaaaaaaa")
end

function M.load()
  M.enter = M.button.make_button(100, 100, 100, 40, "slaw", {255, 0, 0}, {0, 255, 255}, is_it_working)
end

function M.draw()
  M.enter:check()
  M.enter:draw()
end

return M

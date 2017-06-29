math.randomseed(7)
require "Matrix"

function love.load()
  m1 = {{1,2}, {3,4}}
  m2 = {{5}, {6}}
  m3 = multiply_matrix(m1, m2)
  print_matrix(m1)
  print_matrix(m2)
  print_matrix(m3)
end

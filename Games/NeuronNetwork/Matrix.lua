function create_matrix(rows, cols)
  matrix = {}

  for row=1, rows do
    matrix[row] = {}
    for col=1, cols do
      matrix[row][col] = math.random(-5000, 5000)/1000  -- a number like 0.000
    end
  end

  return matrix
end

function multiply_matrix(m1, m2)
  matrix = {}
  
  for row=1, #m1 do
    matrix[row] = {}
    sum = 0
    for col=1, #m1[1] do
      sum = sum + m1[row][col] * m2[col][1]
    end
    matrix[row][1] = sum
  end

  return matrix
end

function print_matrix(matrix)

  for row=1, #matrix do
    if row==1 then print() end
    for col=1, #matrix[1] do
      if col==1 then io.write(" ") end
      io.write( matrix[row][col] .. " " )
    end
    print()
  end
  print()

end

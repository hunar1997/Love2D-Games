function love.load()
  myShader = love.graphics.newShader[[
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
      vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
      number average = (pixel.r+pixel.b+pixel.g)/3.0;
      number factor = abs(0.5-texture_coords.x)*2;
      pixel.r = pixel.r + (average-pixel.r) * factor;
      pixel.g = pixel.g + (average-pixel.g) * factor;
      pixel.b = pixel.b + (average-pixel.b) * factor;
      return pixel;
    }
  ]]
end

drushm = love.graphics.newImage("dad.jpg")
function love.draw()
  love.graphics.setShader(myShader)
  love.graphics.draw(drushm, 100, 200)

  love.graphics.setShader()
  love.graphics.draw(drushm, 400, 200)
end

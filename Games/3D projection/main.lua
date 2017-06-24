require("functions")

screen = vec2( love.graphics.getWidth(), love.graphics.getHeight() )
function love.load()
  view_angle = 45
  radius = 20

  eye = vec2(400, 300)
  target = vec2(400, 150)
  eye_direction = vec2(300, 300)

  draggables = {eye, target, eye_direction}
end

function love.update(dt)

  if love.mouse.isDown(1) then
    mp = vec2(love.mouse.getPosition())

    for i, v in pairs(draggables) do
      if distance(mp, v) <= radius then
        v[1] = mp[1]
        v[2] = mp[2]
      end
    end
  end

  looking = normalize( vec_to(eye, eye_direction) )

  a_to_b = vec_to(eye, target)
end

function love.draw()
  draw_circle(eye, radius, {0, 255, 0})
  draw_circle(target, radius, {100, 100, 255})
  draw_circle(eye_direction, radius/2, {255, 255, 0})

  draw_vector(eye, a_to_b, 30, {255, 0, 0})
  draw_vector(eye, looking, 30, {0, 0, 255})

  love.graphics.setColor(0, 255, 0)
  love.graphics.rectangle('fill', 5, screen[2]-15, screen[1]-10, 10)
  love.graphics.setColor(0, 0, 255)
  love.graphics.rectangle('fill', map(project(looking, a_to_b), 0, 1, 5, screen[1]-5), screen[2]-15, 10, 10)
end

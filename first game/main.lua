size = 650

function love.load()
  love.graphics.setBackgroundColor(104, 136, 248)

  love.physics.setMeter(50)
  world = love.physics.newWorld(0, 9.81*50, true)

  objects = {}
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, size/2, size-25)
  objects.ground.shape = love.physics.newRectangleShape(650, 50)
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

  objects.block = {}
  objects.block.body = love.physics.newBody(world, size/2, size/2, "dynamic")
  objects.block.shape = love.physics.newRectangleShape(100, 50)
  objects.block.fixture = love.physics.newFixture(objects.block.body, objects.block.shape, 1)
end

multiplier = 0
function love.update(dt)
  world:update(dt*multiplier)

  if love.keyboard.isDown("right") then
    multiplier = multiplier+.01
  elseif love.keyboard.isDown("left") then
    multiplier = multiplier-.01
  elseif love.keyboard.isDown("c") then
    print(collectgarbage("count"))
  elseif love.keyboard.isDown("space") then
    collectgarbage("collect")
  end
end

function love.draw()
  love.graphics.setColor(72, 160, 14)
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))

  love.graphics.setColor(200, 160, 80)
  love.graphics.polygon("fill", objects.block.body:getWorldPoints(objects.block.shape:getPoints()))

  love.graphics.setColor(0, 0, 0)

  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

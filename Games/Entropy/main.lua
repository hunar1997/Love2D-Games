love.window.setMode(1366, 768)
love.window.setFullscreen(true)
sw, sh = love.graphics.getDimensions()
math.randomseed(os.time())
radius=sw*0.005
speed=500
ice=5
function circle(x, y, r, ph)
    c = {}
    c.x=x
    c.y=y
    c.r=r
    c.red=math.random(0, 255)
    c.green=math.random(0, 255)
    c.blue=math.random(0, 255)

    c.body=love.physics.newBody(ph, x, y, "dynamic")
    c.shape=love.physics.newCircleShape(r)
    c.fixture=love.physics.newFixture(c.body, c.shape, 1)

    c.fixture:setRestitution(1)
    c.fixture:setFriction(0)
    c.fixture:setDensity(1)
    c.body:setMass(0)



    function c:draw()
        love.graphics.setColor(self.red, self.green, self.blue)
        love.graphics.push()
        love.graphics.translate(self.body:getX(), self.body:getY())
        love.graphics.rotate(self.body:getAngle())
        love.graphics.circle("fill", 0, 0, self.r, 16)
        love.graphics.pop()
    end
    return c
end

function rectangle(x, y, w, h, rot, ph)
    r = {}
    r.x=x+w/2
    r.y=y+h/2
    r.w=w
    r.h=h
    r.rot=math.rad(rot)

    r.body=love.physics.newBody(ph, r.x, r.y)
    r.shape=love.physics.newRectangleShape(r.w, r.h)
    r.fixture=love.physics.newFixture(r.body, r.shape, 1)

    r.body:setAngle(r.rot)

    function r:draw()
        love.graphics.push()
        love.graphics.translate(self.body:getX(), self.body:getY())
        love.graphics.rotate(self.rot)
        love.graphics.translate(-self.w/2, -self.h/2)
        love.graphics.rectangle("fill", 0, 0, self.w, self.h, 30)
        love.graphics.pop()
    end
    return r
end

function love.load()
    world=love.physics.newWorld(0, 0, true)

    circles={}
    walls={
           rectangle(0, 0, sw, 10, 0, world),
           rectangle(0, sh-10, sw, 10, 0, world),
           rectangle(0,-sh,10, sh*2, 0, world),
           rectangle(sw-10, -sh, sw-10, sh*2, 0, world),
           rectangle(0, sh*0.25, sw*0.8, 10, 0, world),
           rectangle(sw*0.2, sh*0.5, sw*0.8, 10, 0, world),
           rectangle(0, sh*0.8, sw*0.8, 10, 0, world)}
end

multiplier = 1
function love.update(dt)
    world:update(dt*multiplier)
    if love.keyboard.isDown("right") then
      multiplier = multiplier+.005
    elseif love.keyboard.isDown("left") then
      multiplier = multiplier-.005
      if multiplier<0 then multiplier=0 end
    end

    if love.keyboard.isDown("up") then
      multiplier = multiplier+.05
    elseif love.keyboard.isDown("down") then
      multiplier = multiplier-.05
      if multiplier<0 then multiplier=0 end
    end

    if love.keyboard.isDown("s") then
      for i, v in ipairs(circles) do
          v.body:setLinearVelocity(math.random(-speed,speed), math.random(-speed,speed))
      end
    end
end

function mag(x,y)
  return math.sqrt(x^2+y^2)
end

function distance(x1,y1,x2,y2)
  return math.sqrt((x2-x1)^2+(y2-y1)^2)
end

trace=false
selected=nil
function love.mousereleased(x, y, button, isTouch)
  if button==1 then
    circles[#circles+1]=circle(x, y, radius, world)
  end
  if button==2 then
    x,y = love.mouse.getPosition()
    found=false
    for i,v in pairs(circles) do
      px, py = v.body:getPosition()
      if distance(x, y, px, py) < radius then
        selected = v
        if not trace then trace=true end
        found=true
        break
      end
    end
    if not found then
      selected=nil
      trace=false
    end
  end
end


function love.keyreleased(key)
  x, y = love.mouse.getPosition()
  if key=='b' then
    for i=-ice/2, ice/2 do
      for j=-ice/2, ice/2 do
        circles[#circles+1]=circle(x+i*radius*2, y+j*radius*2, radius, world)
      end
    end
  end
  if key=='v' then
    for i,v in pairs(circles) do
      v.red = 255
      v.blue = 0
      v.green = 0
      if i>50 then break end
    end
  end
  if key=='t' then
    if multiplier==0 then multiplier=1 else multiplier=0 end
  end
end

function love.draw()
    if trace then
      px, py = selected.body:getPosition()
      love.graphics.setColor(0, 255, 255)
      love.graphics.line(0, py, sw, py)
      love.graphics.line(px, 0, px, sh)
    end
    love.graphics.setColor(0, 255, 0)
    for i, v in ipairs(walls) do
        v:draw()
    end
    for i, v in ipairs(circles) do
        v:draw()
    end
    love.graphics.setColor(255,255,255)
    string=""
    temp = 0
    index = 0
    for i,v in pairs(circles) do
      vx, vy = circles[1].body:getLinearVelocity()
      temp = temp + mag(vx,vy)
      index = index + 1
      if index>50 then break end
    end
    temp = math.floor(100*(temp/index))/100
    if index==0 then temp="Error" end
    string = "Temperature [" .. temp .. "] "
    string = string .. #circles .. "  speed: "..math.floor(multiplier*100).."%" .. "   memory: " .. collectgarbage("count")
    string = string .. "\nt:toggle speed between 100% and 0%\nv:make first 50 balls red\n"
    string = string .. "s:start applying random velocity\narrow keys: slow down and speed up simulation\nb:place ice"
    love.graphics.print(string, 50, 50)
end

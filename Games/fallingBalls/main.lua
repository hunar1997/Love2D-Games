love.window.setMode(1366, 768)
love.window.setFullscreen(true)
sw, sh = love.graphics.getDimensions()
math.randomseed(os.time())
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

    c.fixture:setRestitution(0.5)
    c.fixture:setFriction(0.5)
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
    world=love.physics.newWorld(0, 9.8*100, true)

    circles={}

    r1=rectangle(sw*.1, sh*.6, sw*.5, 10, 20, world)
    r2=rectangle(sw*.5, sh*.6, sw*.3, 10, -20, world)
    floor=rectangle(0, sh-10, sw, 10, 0, world)
    wall1=rectangle(0,-sh,10, sh*2, 0, world)
    wall2=rectangle(sw-10, -sh, sw-10, sh*2, 0, world)
end

el=3
multiplier = 1
function love.update(dt)
    world:update(dt*multiplier)
    if love.keyboard.isDown("right") then
      multiplier = multiplier+.005
    elseif love.keyboard.isDown("left") then
      multiplier = multiplier-.005
      if multiplier<0 then multiplier=0 end
    end
    el=el+dt
    if el>3 then
        el=0
        for i=1, 50 do
            radius = math.random(sh*.007, sh*.015)
            if math.random(1,100)==1 then
              radius = sh*0.04
            end
            if math.random(1,200)==1 then
              radius = sh*0.1
            end
            circles[#circles+1]=circle(math.random(30, sw-30), math.random(-1000, -100), radius, world)
        end
    end
end

function love.draw()
    r1:draw()
    r2:draw()
    floor:draw()
    wall1:draw()
    wall2:draw()
    for i, v in ipairs(circles) do
        v:draw()
    end
    love.graphics.setColor(255,255,255)
    love.graphics.print(#circles .. "  speed: "..math.floor(multiplier*100).."%" .. "   memory: " .. collectgarbage("count"), 50, 50)
end

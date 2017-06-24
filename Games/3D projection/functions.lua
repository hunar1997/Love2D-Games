function vec2(x, y)
  return {x, y}
end

function normalize(v)
  l = math.sqrt(v[1]^2 + v[2]^2)
  v1 = v[1]/l
  v2 = v[2]/l
  return {v1, v2}
end

function vec_to(v1, v2)
  i = v2[1] - v1[1]
  j = v2[2] - v1[2]
  v = normalize(vec2(i, j))
  return v
end

function dot (v1, v2)
  nv1 = normalize(v1)
  nv2 = normalize(v2)
  return nv1[1]*nv2[1] + nv1[2]*nv2[2]
end

function draw_vector(pos, dir, multiplier, color)
  love.graphics.setColor(color)
  love.graphics.line(pos[1], pos[2], pos[1]+dir[1]*multiplier, pos[2]+dir[2]*multiplier)
end

function draw_circle(pos, radius, color)
  love.graphics.setColor(color)
  love.graphics.circle('fill', pos[1], pos[2], radius)
end

function distance(p1, p2)
  return math.sqrt( (p2[1]-p1[1])^2 + (p2[2]-p1[2])^2 )
end

function magnitude(v)
  return math.sqrt( v[1]^2 + v[2]^2 )
end

function map(value, istart, istop, ostart, ostop)
  return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
end

function project(v1, v2)
  diff = math.atan2(v2[2],v2[1]) - math.atan2(v1[2],v1[1])

  if v1[1]<0 and v2[1]<0 and v1[2]*v2[2]<0 then
    diff = -diff
  end

  sign = 0
  d = dot(v1, v2)
  if d <= 0 then return -1000 end
  if d > 0 then
    if v1[2] == 0 then
      diff = -v2[2]
    elseif v2[2] == 0 then
      diff = v1[2]
    end
    if diff < 0 then
      sign = -1
    else
      sign = 1
    end
  end
  angle = math.acos(d/(magnitude(v1)*magnitude(v2)))
  return ((angle * sign)+math.pi/2)/math.pi
end

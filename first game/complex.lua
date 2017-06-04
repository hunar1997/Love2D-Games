local complex = {}

function complex:new(r, i)
    return setmetatable({r, i},
        {
            __mul=function(a, b)
                return { a[1]*b[1]-a[2]*b[2], a[1]*b[2]+b[1]*a[2] }
            end,
            __add=function(a, b)
                return { a[1]+b[1], a[2]+b[2] }
            end
        }
    )
end

return complex
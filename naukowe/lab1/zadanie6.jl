function f(x::Float64)
    return sqrt((x * x) + 1) - 1
end

function g(x::Float64)
    return (x * x) / (sqrt(x * x + 1) + 1)
end

for i=1:10
    println(f(8.0^(-i)))
    println(g(8.0^(-i)))
    println()
end

# Marcin Wilk 261722
"""
    derivative(func, x, h)

Calculates derivative with precision given by `h`.
"""
function derivative(func::Function , x::Float64, h::Float64)
    return (func(x + h) - func(x)) / h;
end

"""
    exactValue(x)

Calculates exact value for derivative of sin(x) - sin(3x).
"""
function exactValue(x::Float64)
    return cos(x) - 3*sin(3*x);
end

for i=0:54
    println("\$2^{-$i}\$     & \$$(derivative((x) -> sin(x) + cos(3x), 1.0, 2.0^(-i)))\$     & \$$(exactValue(1.0))\$ \\\\");
    println("$(bitstring(1.0 + 2.0^(-i)))");
    println("\\hline");
end

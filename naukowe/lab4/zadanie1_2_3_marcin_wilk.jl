module Algorytmy

using Plots

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    fCopy = [y for y in f]
    result = [fCopy[1]]

    for i in 1:length(f)-1
        for j in 1:length(x)-i
            fCopy[j] = (fCopy[j+1] - fCopy[j]) / (x[j+i] - x[j])
        end

        result = [result; fCopy[1]]
    end

    return result
end

function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    w = Vector{Float64}(undef, length(x))
    w[end] = fx[end]

    for i in length(x)-1:-1:1
        w[i] = w[i+1] * (t - x[i]) + fx[i]
    end

    return w[1]
end

function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    a = [fx[end]]

    for i in length(x)-1:-1:1
        # shifting coefficients one to the right
        pushfirst!(a, 0.0)

        # adding coefficients multiplied by -x[i] (j+1 because its shifted from previous step)
        for j in 1:length(a)-1
            a[j] -= x[i] * a[j+1]
        end

        # adding fx[i] to first coefficient
        a[1] += fx[i]
    end

    return a
end

function rysujNnfx(f, a::Float64, b::Float64, n::Int)
    h = (b - a) / n
    xs = [a + k * h for k in 0:n]
    ys = [f(x) for x in xs]
    ilorazy = ilorazyRoznicowe(xs, ys)

    n *= 100
    h = (b - a) / n

    printxs = [a + k * h for k in 0:n]
    printys = [f(x) for x in printxs]
    polynomialValues = [warNewton(xs, ilorazy, x) for x in printxs]

    plot(printxs, [printys, polynomialValues], label=["f(x)" "Nn(x)"])

    savefig(string(a, b, n, "plot.png"))
end

function testFunctions()
    x = [3.0, 1.0, 5.0, 6.0]
    f = [1.0, -3.0, 2.0, 4.0]
    fx = ilorazyRoznicowe(x, f)
    a = naturalna(x, fx)

    println("Wartość wielomianu w punkcie 4.0: ", warNewton(x, fx, 4.0))
    println("Wartość wielomianu w punkcie 4.0: ", a[1] + a[2] * 4.0 + a[3] * 4.0^2 + a[4] * 4.0^3)
end

function main()
    # testFunctions()
    # rysujNnfx(x -> ℯ^x, 0.0, 1.0, 5)
    # rysujNnfx(x -> ℯ^x, 0.0, 1.0, 10)
    # rysujNnfx(x -> ℯ^x, 0.0, 1.0, 15)

    # rysujNnfx(x -> x^2*sin(x), -1.0, 1.0, 5)
    # rysujNnfx(x -> x^2*sin(x), -1.0, 1.0, 10)
    # rysujNnfx(x -> x^2*sin(x), -1.0, 1.0, 15)

    # rysujNnfx(x -> abs(x), -1.0, 1.0, 5)
    # rysujNnfx(x -> abs(x), -1.0, 1.0, 10)
    # rysujNnfx(x -> abs(x), -1.0, 1.0, 15)

    rysujNnfx(x -> 1.0 / (1 + x^2), -5.0, 5.0, 5)
    rysujNnfx(x -> 1.0 / (1 + x^2), -5.0, 5.0, 10)
    rysujNnfx(x -> 1.0 / (1 + x^2), -5.0, 5.0, 15)
end

main()

end

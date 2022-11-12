using Plots

function recursive(x0::Float64, c::Float64, n::Int)
    xs = zeros(2n)
    resultarray = zeros(2n)
    result = x0
    for i in 1:n
        println(result)
        xs[2i - 1] = result
        result = result * result + c
        resultarray[2i - 1] = result

        xs[2i] = result
        resultarray[2i] = result
    end
    println(result)

    return [xs, resultarray]
end

function plotRecursive(c::Float64)
    arraybounds = round(Int, 100 * c)
    x = [i / 100.0 for i in arraybounds:(-1 * arraybounds)]
    y = [[i * i + c, i] for i in x]

    y = reshape(collect(Iterators.flatten(y)), 2, length(x))'

    plot(x, y, legend = false)
end

function doAll(x0::Float64, c::Float64, n::Int)
    plotRecursive(c)
    results = recursive(x0, c, n)

    plot!(results[1], results[2])

    # for r in recursive(x0, c, n)
    #     push!(plt, 3, r, r * r + c)
    # end

    savefig("plot7.png")
end

# doAll(1.0, -2.0, 40)
# doAll(2.0, -2.0, 40)
# doAll(1.99999999999999, -2.0, 40)
# doAll(1.0, -1.0, 40)
# doAll(-1.0, -1.0, 40)
# doAll(0.75, -1.0, 40)
doAll(0.25, -1.0, 40)

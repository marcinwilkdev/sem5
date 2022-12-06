module Algorytmy

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    fCopy = [y for y in f]
    result = [fCopy[1]]

    for i in 1:length(f)-1
        println(result)

        for j in 1:length(x)-i
            fCopy[j] = (fCopy[j+1] - fCopy[j]) / (x[j+i] - x[j])
        end

        result = [result; fCopy[1]]
    end

    println(result)

    return fCopy
end

function main()
    x = [3.0, 1.0, 5.0, 6.0]
    f = [1.0, -3.0, 2.0, 4.0]

    ilorazyRoznicowe(x, f)
end

main()

end

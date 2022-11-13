function population(p0::AbstractFloat, r::AbstractFloat, n::Int)
    result = p0

    for _ in 1:n
        result = result + r * result * (one(Float32) - result)
    end

    return result
end

function populationWithModification(p0::AbstractFloat, r::AbstractFloat, n::Int)
    result = p0

    for i in 1:n
        if i == 11
            result = floor(result; digits=3)
        end
        result = result + r * result * (one(Float32) - result)
    end

    return result
end

function populationDifference(p0::AbstractFloat, r::AbstractFloat, n::Int)
    println(population(p0, r, n))
    println(populationWithModification(p0, r, n))
end

populationDifference(Float32(0.01), Float32(3.0), 40)

using LinearAlgebra
using Statistics
using Printf

function matcond(n::Int, c::Float64)
    # Function generates a random square matrix A of size n with
    # a given condition number c.
    # Inputs:
    #	n: size of matrix A, n>1
    #	c: condition of matrix A, c>= 1.0
    #
    # Usage: matcond(10, 100.0)
    #
    # Pawel Zielinski
    if n < 2
        error("size n should be > 1")
    end
    if c < 1.0
        error("condition number  c of a matrix  should be >= 1.0")
    end
    (U, S, V) = svd(rand(n, n))
    return U * diagm(0 => [LinRange(1.0, c, n);]) * V'
end

function hilb(n::Int)
    # Function generates the Hilbert matrix  A of size n,
    #  A (i, j) = 1 / (i + j - 1)
    # Inputs:
    #	n: size of matrix A, n>=1
    #
    #
    # Usage: hilb(10)
    #
    # Pawel Zielinski
    if n < 1
        error("size n should be >= 1")
    end
    return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end

function genResults()
    for matrixSize in 2:20
        hilbertMatrix = hilb(matrixSize)
        x = ones(Float64, matrixSize)
        b = hilbertMatrix * x

        firstX = map((a) -> abs(a - 1.0), hilbertMatrix \ b)
        secondX = map((a) -> abs(a - 1.0), inv(hilbertMatrix) * b)

        println("Gauss: ", mean(firstX))
        println("Inverse: ", mean(secondX))
    end

    println()

    for matrixSize in [5, 10, 20]
        for conditionNumber in [0, 1, 3, 7, 12, 16]
            conditionNumber = 10.0^conditionNumber
            randomMatrix = matcond(matrixSize, conditionNumber)
            x = ones(Float64, matrixSize)
            b = randomMatrix * x

            firstX = map((a) -> abs(a - 1.0), randomMatrix \ b)
            secondX = map((a) -> abs(a - 1.0), inv(randomMatrix) * b)

            println("Gauss (): ", mean(firstX))
            println("Inverse (): ", mean(secondX))
        end

    println()
    end
end

genResults()

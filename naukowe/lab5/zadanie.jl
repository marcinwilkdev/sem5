using LinearAlgebra
using SparseArrays

struct MyMatrix
    buf::Matrix{Float64}
    n::Int
    l::Int
    width::Int
    height::Int
end

function createMyMatrix(n::Int, l::Int)
    return MyMatrix(zeros(n, 3l + 1), n, l, 3l + 1, n)
end

function createMyIdentityMatrix(n::Int, l::Int)
    matrix = MyMatrix(zeros(n, 3l + 1), n, l, 3l + 1, n)

    for row in 1:n
        matrix.buf[row, l+1] = 1.0
    end

    return matrix
end

function Base.getindex(A::MyMatrix, row::Int, col::Int)
    return A.buf[row, col-row+A.l+1]
end

function Base.setindex!(A::MyMatrix, val::Float64, row::Int64, col::Int64)
    A.buf[row, col-row+A.l+1] = val
end

# works only for (1, 1, 1, ...) vectors XD
function Base.:(*)(A::MyMatrix, x::Vector{Float64})
    y = zeros(length(x))

    for row in 1:A.height
        for col in 1:A.width
            y[row] += A.buf[row, col]
        end
    end

    return y
end

function readMatrixDimensions(matrixFile::IOStream)
    line = readline(matrixFile)
    dimensions = split(line, ' ')

    return (parse(Int, dimensions[1]), parse(Int, dimensions[2]))
end

function readVectorDimension(vectorFile::IOStream)
    line = readline(vectorFile)

    return parse(Int, line)
end

function readMatrix(n::Int, matrixFile::IOStream)
    lines = readlines(matrixFile)
    coords = [split(line, ' ') for line in lines]

    parsedXCoordinates = [parse(Int, coord[1]) for coord in coords]
    parsedYCoordinates = [parse(Int, coord[2]) for coord in coords]
    parsedValues = [parse(Float64, coord[3]) for coord in coords]

    return sparse(parsedXCoordinates, parsedYCoordinates, parsedValues, n, n)
end

function readMyMatrix(myMatrix::MyMatrix, matrixFile::IOStream)
    lines = readlines(matrixFile)
    coords = [split(line, ' ') for line in lines]

    parsedCoords = [(parse(Int, coord[1]), parse(Int, coord[2]), parse(Float64, coord[3])) for coord in coords]

    for coord in parsedCoords
        myMatrix[coord[1], coord[2]] = coord[3]
    end

    println("Matrix read")
end

function readVector(vectorFile::IOStream)
    lines = readlines(vectorFile)
    coords = [parse(Float64, line) for line in lines]

    return coords
end

function reduceColumn(A::MyMatrix, L::MyMatrix, b::Vector{Float64}, noOfRowsBelow::Int, diagCellIdx::Int, dividerBottom::Float64, maxColOffset::Int)
    for rowOffset in 1:noOfRowsBelow
        rowIdx = diagCellIdx + rowOffset
        dividerTop = A[rowIdx, diagCellIdx]

        divider = dividerTop / dividerBottom

        L[rowIdx, diagCellIdx] = divider

        for colOffset in 0:maxColOffset
            colIdx = diagCellIdx + colOffset
            A[rowIdx, colIdx] -= A[diagCellIdx, colIdx] * divider
        end

        b[rowIdx] -= b[diagCellIdx] * divider
    end
end

function reduceChunk(A::MyMatrix, L::MyMatrix, b::Vector{Float64}, n::Int, l::Int, colBeforeChunkIdx::Int, lastChunk::Bool)
    for diagCellOffset = 1:l-1
        diagCellIdx = colBeforeChunkIdx + diagCellOffset
        dividerBottom = A[diagCellIdx, diagCellIdx]
        noOfRowsBelow = lastChunk ? (l - diagCellOffset) : (l - diagCellOffset + 1)
        maxColOffset = lastChunk ? n - diagCellIdx : l

        reduceColumn(A, L, b, noOfRowsBelow, diagCellIdx, dividerBottom, maxColOffset)
    end
end

function reduceColumnWithChoice(A::MyMatrix, L::MyMatrix, b::Vector{Float64}, noOfRowsBelow::Int, diagCellIdx::Int, maxColOffset::Int)
    pivotIdx = diagCellIdx

    for rowOffset in 1:noOfRowsBelow
        rowIdx = diagCellIdx + rowOffset

        if abs(A[rowIdx, diagCellIdx]) > abs(A[pivotIdx, diagCellIdx])
            pivotIdx = rowIdx
        end
    end

    for colOffset in 0:maxColOffset
        colIdx = diagCellIdx + colOffset

        tmp = A[pivotIdx, colIdx]
        A[pivotIdx, colIdx] = A[diagCellIdx, colIdx]
        A[diagCellIdx, colIdx] = tmp
    end

    tmp = b[pivotIdx]
    b[pivotIdx] = b[diagCellIdx]
    b[diagCellIdx] = tmp

    dividerBottom = A[diagCellIdx, diagCellIdx]

    for rowOffset in 1:noOfRowsBelow
        rowIdx = diagCellIdx + rowOffset
        dividerTop = A[rowIdx, diagCellIdx]

        divider = dividerTop / dividerBottom

        # we have to also permute L
        L[rowIdx, diagCellIdx] = divider

        for colOffset in 0:maxColOffset
            colIdx = diagCellIdx + colOffset
            A[rowIdx, colIdx] -= A[diagCellIdx, colIdx] * divider
        end

        b[rowIdx] -= b[diagCellIdx] * divider
    end
end

function reduceChunkWithChoice(A::MyMatrix, L::MyMatrix, b::Vector{Float64}, n::Int, l::Int, colBeforeChunkIdx::Int, lastTwoChunks::Bool, lastChunk::Bool)
    for diagCellOffset = 1:l-1
        diagCellIdx = colBeforeChunkIdx + diagCellOffset
        noOfRowsBelow = lastChunk ? (l - diagCellOffset) : (l - diagCellOffset + 1)
        maxColOffset = lastTwoChunks ? n - diagCellIdx : 2 * l

        reduceColumnWithChoice(A, L, b, noOfRowsBelow, diagCellIdx, maxColOffset)
    end
end

function gaussWithChoice(A::MyMatrix, L::MyMatrix, b::Vector{Float64}, n::Int, l::Int)
    chunkCount = n ÷ l

    for chunkNumber = 0:chunkCount-2
        colBeforeChunkIdx = chunkNumber * l

        reduceChunkWithChoice(A, L, b, n, l, colBeforeChunkIdx, chunkNumber == chunkCount - 2, false)

        lastDiagCellIdx = colBeforeChunkIdx + l

        reduceColumnWithChoice(A, L, b, l, lastDiagCellIdx, l)
    end

    chunkNumber = chunkCount - 1
    colBeforeChunkIdx = chunkNumber * l

    reduceChunkWithChoice(A, L, b, n, l, colBeforeChunkIdx, true, true)
end

function gauss(A::MyMatrix, L::MyMatrix, b::Vector{Float64}, n::Int, l::Int)
    chunkCount = n ÷ l

    for chunkNumber = 0:chunkCount-2
        colBeforeChunkIdx = chunkNumber * l

        reduceChunk(A, L, b, n, l, colBeforeChunkIdx, false)

        lastDiagCellIdx = colBeforeChunkIdx + l
        dividerBottom = A[lastDiagCellIdx, lastDiagCellIdx]

        reduceColumn(A, L, b, l, lastDiagCellIdx, dividerBottom, l)
    end

    chunkNumber = chunkCount - 1
    colBeforeChunkIdx = chunkNumber * l

    reduceChunk(A, L, b, n, l, colBeforeChunkIdx, true)
end

function calculateX(A::MyMatrix, b::Vector{Float64}, n::Int, l::Int)
    x = zeros(n)

    for row in n:-1:1
        x[row] = b[row]

        maxColOffset = n - row > 2l ? 2l : n - row

        for colOffset in 1:maxColOffset
            x[row] -= A[row, row+colOffset] * x[row+colOffset]
        end

        x[row] /= A[row, row]
    end

    return x
end

function main()
    matrixFile = ARGS[1]

    open(matrixFile, "r") do mf
        (n, l) = readMatrixDimensions(mf)
        A = createMyMatrix(n, l)
        L = createMyIdentityMatrix(n, l)

        readMyMatrix(A, mf)

        if length(ARGS) > 1
            vectorFile = ARGS[2]

            open(vectorFile, "r") do vf
                _ = readVectorDimension(vf)
                b = readVector(vf)

                gauss(A, L, b, n, l)

                x = calculateX(A, b, n, l)

                for xCoord in x
                    println(xCoord)
                end
            end
        else
            x = ones(Float64, n)
            b = A * x

            @time begin
                gauss(A, L, b, n, l)
            end

            x = calculateX(A, b, n, l)

            errorVec = [abs(1.0 - xCoord) for xCoord in x]
            println(norm(errorVec) / norm(ones(n)))

            for xCoord in x
                # println(xCoord)
            end
        end

        println(L.buf)
    end
end

main()

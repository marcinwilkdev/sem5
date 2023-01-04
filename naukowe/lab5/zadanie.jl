using SparseArrays

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

function readVector(vectorFile::IOStream)
    lines = readlines(vectorFile)
    coords = [parse(Float64, line) for line in lines]

    return coords
end

function chatGauss(A::SparseMatrixCSC{Float64,Int64}, b::Vector{Float64})
    n, m = size(A)
    for i = 1:n
        # # Select pivot row
        # pivot = i
        # for j = i+1:n
        #     if abs(A[j, i]) > abs(A[pivot, i])
        #         pivot = j
        #     end
        # end
        # # Swap pivot row
        # A[[i, pivot]] = A[[pivot, i]]

        # Eliminate
        for j = i+1:n
            factor = A[j, i] / A[i, i]
            A[j, i:m] = A[j, i:m] - factor * A[i, i:m]
            b[j] = b[j] - factor * b[i]
        end
    end

    x = zeros(n)

    for row in n:-1:1
        x[row] = b[row]
        for colOffset in 1:n-row
            x[row] -= A[row, row+colOffset] * x[row+colOffset]
        end
        x[row] /= A[row, row]
    end

    return A
end

function reduceColumn(A::SparseMatrixCSC{Float64,Int64}, b::Vector{Float64}, noOfRowsBelow::Int, diagCellIdx::Int, dividerBottom::Float64, maxColOffset::Int, startRowOffset::Int)
    for rowOffset in startRowOffset:noOfRowsBelow
        rowIdx = diagCellIdx + rowOffset
        dividerTop = A[rowIdx, diagCellIdx]

        divider = dividerTop / dividerBottom

        for colOffset in 0:maxColOffset
            colIdx = diagCellIdx + colOffset
            A[rowIdx, colIdx] -= A[diagCellIdx, colIdx] * divider
        end

        b[rowIdx] -= b[diagCellIdx] * divider
    end
end

function reduceChunk(A::SparseMatrixCSC{Float64,Int64}, b::Vector{Float64}, n::Int, l::Int, colBeforeChunkIdx::Int, lastChunk::Bool)
    for diagCellOffset = 1:l
        diagCellIdx = colBeforeChunkIdx + diagCellOffset
        dividerBottom = A[diagCellIdx, diagCellIdx]
        noOfRowsBelow = lastChunk ? (l - diagCellOffset) : (l - diagCellOffset + 1)
        maxColOffset = lastChunk ? n - diagCellIdx : l

        reduceColumn(A, b, noOfRowsBelow, diagCellIdx, dividerBottom, maxColOffset, 1)
    end
end

function reduceColumnWithChoice(A::SparseMatrixCSC{Float64,Int64}, b::Vector{Float64}, noOfRowsBelow::Int, diagCellIdx::Int, dividerBottom::Float64, maxColOffset::Int, startRowOffset::Int)
    for rowOffset in startRowOffset:noOfRowsBelow
        rowIdx = diagCellIdx + rowOffset
        dividerTop = A[rowIdx, diagCellIdx]

        divider = dividerTop / dividerBottom

        for colOffset in 0:maxColOffset
            colIdx = diagCellIdx + colOffset
            A[rowIdx, colIdx] -= A[diagCellIdx, colIdx] * divider
        end

        b[rowIdx] -= b[diagCellIdx] * divider
    end
end

function reduceChunkWithChoice(A::SparseMatrixCSC{Float64,Int64}, b::Vector{Float64}, n::Int, l::Int, colBeforeChunkIdx::Int, lastTwoChunks::Bool, lastChunk::Bool)
    for diagCellOffset = 1:l
        diagCellIdx = colBeforeChunkIdx + diagCellOffset
        dividerBottom = A[diagCellIdx, diagCellIdx]
        noOfRowsBelow = lastChunk ? (l - diagCellOffset) : (l - diagCellOffset + 1)
        maxColOffset = lastTwoChunks ? n - diagCellIdx : 2 * l

        reduceColumnWithChoice(A, b, noOfRowsBelow, diagCellIdx, dividerBottom, maxColOffset, 1)
    end
end

function gaussWithChoice(A::SparseMatrixCSC{Float64,Int64}, b::Vector{Float64}, n::Int, l::Int)
    chunkCount = n ÷ l

    for chunkNumber = 0:chunkCount-2
        colBeforeChunkIdx = chunkNumber * l

        reduceChunkWithChoice(A, b, n, l, colBeforeChunkIdx, chunkNumber == chunkCount - 2, false)

        lastDiagCellIdx = colBeforeChunkIdx + l
        dividerBottom = A[lastDiagCellIdx, lastDiagCellIdx]

        reduceColumnWithChoice(A, b, l, lastDiagCellIdx, dividerBottom, n - lastDiagCellIdx, 2)
    end

    chunkNumber = chunkCount - 1
    colBeforeChunkIdx = chunkNumber * l

    reduceChunkWithChoice(A, b, n, l, colBeforeChunkIdx, true, true)
end

function gauss(A::SparseMatrixCSC{Float64,Int64}, b::Vector{Float64}, n::Int, l::Int)
    chunkCount = n ÷ l

    for chunkNumber = 0:chunkCount-2
        colBeforeChunkIdx = chunkNumber * l

        reduceChunk(A, b, n, l, colBeforeChunkIdx, false)

        lastDiagCellIdx = colBeforeChunkIdx + l
        dividerBottom = A[lastDiagCellIdx, lastDiagCellIdx]

        reduceColumn(A, b, l, lastDiagCellIdx, dividerBottom, n - lastDiagCellIdx, 2)
    end

    chunkNumber = chunkCount - 1
    colBeforeChunkIdx = chunkNumber * l

    reduceChunk(A, b, n, l, colBeforeChunkIdx, true)
end

function calculateX(A::SparseMatrixCSC{Float64,Int64}, b::Vector{Float64}, n::Int)
    x = zeros(n)

    for row in n:-1:1
        x[row] = b[row]

        for colOffset in 1:n-row
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
        A = readMatrix(n, mf)

        if length(ARGS) > 1
            vectorFile = ARGS[2]

            open(vectorFile, "r") do vf
                _ = readVectorDimension(vf)
                b = readVector(vf)

                gauss(A, b, n, l)

                x = calculateX(A, b, n)

                for xCoord in x
                    println(xCoord)
                end
            end
        else
            x = ones(Float64, n)
            b = A * x

            gauss(A, b, n, l)

            x = calculateX(A, b, n)

            errorVec = [abs(1.0 - xCoord) for xCoord in x]
            println(sum(errorVec))

            for xCoord in x
                println(xCoord)
            end
        end
    end
end

main()

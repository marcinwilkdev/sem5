function findSmallestNumber()
    correctNumber = 1.0

    while correctNumber * (1.0 / correctNumber) == 1.0
        correctNumber = nextfloat(correctNumber)
    end

    return correctNumber
end

println(findSmallestNumber())

# Marcin Wilk 261722
"""
    checkSpacing()

Finds smallest number in range 1.0 - 2.0 such that
x * (1/x) != x.
"""
function findSmallestNumber()
    correctNumber = 1.0

    while correctNumber * (1.0 / correctNumber) == 1.0
        correctNumber = nextfloat(correctNumber)
    end

    return correctNumber
end

println(findSmallestNumber())

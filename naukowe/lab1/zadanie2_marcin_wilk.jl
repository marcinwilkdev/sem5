# Marcin Wilk 261722
"""
    checkEps(float)

Get calculated macheps value for `float` type.
"""
function checkEps(float)
    return abs(float(3) * ((float(4) / float(3)) - float(1)) - 1)
end

"""
    compareEps(float)

Compares calculated macheps value for `float` type with actual value.
"""
function compareEps(float)
    calculatedEps = checkEps(float)
    macheps = eps(float)
    print("($float) 3(4/3 - 1) - 1: $calculatedEps eps: $macheps\n")
end

compareEps(Float16)
compareEps(Float32)
compareEps(Float64)

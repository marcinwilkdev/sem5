function getMacheps(float)
    addition = one(float)

    while one(float) + (addition / Float16(2.0)) > one(float)
        addition /= Float16(2.0)
    end

    return addition
end

function compareMacheps(float)
    ourMacheps = getMacheps(float)
    macheps = eps(float)

    print(string("($float) Smallest number bigger than 1.0: $ourMacheps Eps: $macheps\n"))
end

function getEta(float)
    addition = one(float)

    while (addition / Float16(2.0)) > zero(float)
        addition /= Float16(2.0)
    end

    return addition
end

function compareEta(float)
    ourEta = getEta(float)
    eta = nextfloat(zero(float))

    print(string("($float) Smallest number bigger than 0.0: $ourEta eta: $eta\n"))

end

function getMax(float)
    maxValue = one(float) * Float16(2.0);

    while ~isinf(maxValue * Float16(2.0))
        maxValue *= Float16(2.0)
    end

    power = maxValue

    while ~isinf(nextfloat(maxValue))
        while isinf(maxValue + power)
            power /= Float16(2.0)
        end

        maxValue += power
    end

    return maxValue
end

function compareMax(float)
    ourMax = getMax(float)
    maxValue = floatmax(float)

    print(string("($float) Biggest number: $ourMax MAX: $maxValue\n"))

end

compareMacheps(Float16)
compareMacheps(Float32)
compareMacheps(Float64)

print('\n')

compareEta(Float16)
compareEta(Float32)
compareEta(Float64)

print('\n')

compareMax(Float16)
compareMax(Float32)
compareMax(Float64)

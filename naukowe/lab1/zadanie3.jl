function checkSpacing(float)
    firstFloat = float(1.0)
    lastFloat = float(2.0)
    delta = float(0x1p-52);

    iter = 0

    while firstFloat < lastFloat
        if firstFloat + delta != nextfloat(firstFloat)
            return false
        end

        firstFloat += delta
        iter += 1

        if iter % 1000000 == 0
            println("$(iter / 1000000)")
        end
    end

    return true
end

if checkSpacing(Float64)
    println("It works")
end

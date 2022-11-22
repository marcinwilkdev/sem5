include("zadanie1_2_3_marcin_wilk.jl")

import .MetodyIteracyjne

function f6(x)
    ℯ^(1 - x) - 1
end

function pf6(x)
    -ℯ^(1 - x)
end

function f7(x)
    x * ℯ^(-x)
end

function pf7(x)
    ℯ^(-x) - x * ℯ^(-x)
end

# adjust parameters

# create plots
MetodyIteracyjne.test_mbisekcji(f6, 0.0, 5.0, 10^(-5), 10^(-5))
MetodyIteracyjne.test_mstycznych(f6, pf6, 0.0, 10^(-5), 10^(-5), 1000)
MetodyIteracyjne.test_msiecznych(f6, 0.0, 5.0, 10^(-5), 10^(-5), 1000)

println()

# create plots
MetodyIteracyjne.test_mbisekcji(f7, -1.0, 2.0, 10^(-5), 10^(-5))
MetodyIteracyjne.test_mstycznych(f7, pf7, 2.0, 10^(-5), 10^(-5), 1000)
MetodyIteracyjne.test_msiecznych(f7, -1.0, 2.0, 10^(-5), 10^(-5), 1000)

println()

# create plots
MetodyIteracyjne.test_mstycznych(f6, pf6, 2.0, 10^(-5), 10^(-5), 1000)
MetodyIteracyjne.test_mstycznych(f7, pf7, 10.0, 10^(-5), 10^(-5), 1000)
# Nie można, ponieważ pochodna będzie równa 0.0.
MetodyIteracyjne.test_mstycznych(f7, pf7, 1.0, 10^(-5), 10^(-5), 1000)

include("zadanie1_2_3_marcin_wilk.jl")

import .MetodyIteracyjne

function f4(x)
    sin(x) - (1 / 2 * x)^2
end

function pf4(x)
    cos(x) - x
end

# create plots
MetodyIteracyjne.test_mbisekcji(f4, 1.5, 2.0, 1 / 2 * 10^(-5), 1 / 2 * 10^(-5))
MetodyIteracyjne.test_mstycznych(f4, pf4, 1.5, 1 / 2 * 10^(-5), 1 / 2 * 10^(-5), 1000)
MetodyIteracyjne.test_msiecznych(f4, 1.0, 2.0, 1 / 2 * 10^(-5), 1 / 2 * 10^(-5), 1000)

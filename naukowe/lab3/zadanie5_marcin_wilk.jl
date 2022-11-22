include("zadanie1_2_3_marcin_wilk.jl")

import .MetodyIteracyjne

function f5(x)
    x - log(3x)
end

# create plots
MetodyIteracyjne.test_mbisekcji(f5, 0.0, 1.0, 10^(-4), 10^(-4))
MetodyIteracyjne.test_mbisekcji(f5, 1.0, 2.0, 10^(-4), 10^(-4))

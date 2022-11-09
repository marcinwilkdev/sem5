using Plots

x = -50:50;
y = map(a -> ℯ^a * log(1 + ℯ^(-a)), x)

plot(x, y)
savefig("plot.png")

for a in 0:50
    println(ℯ^a, " ", log(1 + ℯ^(-a)), " ", ℯ^(-a))
end

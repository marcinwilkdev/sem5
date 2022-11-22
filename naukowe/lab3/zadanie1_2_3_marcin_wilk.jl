module MetodyIteracyjne

f1(x) = x + 8.0
f2(x) = (x + 1.0) * (x - 3.0)
f3(x) = (x - 8.0) * (x + 3.0) * (x - 1.0)

function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    xs = empty([0.0])
    ys = empty([0.0])

    if f(a) * f(b) > 0.0
        return (0, 0, 0, 1)
    end

    u = f(a)
    v = f(b)
    e = b - a

    iterations = 0

    while true
        e = e / 2.0
        c = a + e
        w = f(c)

        push!(xs, c)
        push!(ys, w)

        if abs(e) <= delta || abs(w) <= epsilon
            return (c, w, iterations, 0)
        end

        if w * u < 0.0
            b = c
            v = w
        else
            a = c
            u = w
        end

        iterations += 1
    end
end

function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    v = f(x0)

    if abs(v) < epsilon
        return (x0, v, 0, 0)
    end

    for k in 1:maxit
        p = pf(x0)

        if abs(p) < epsilon
            return (x0, v, k, 2)
        end

        x1 = x0 - v / p
        v = f(x1)

        if abs(x1 - x0) <= delta || abs(v) <= epsilon
            return (x1, v, k, 0)
        end

        x0 = x1
    end

    return (x0, v, maxit, 1)
end

function msiecznych(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    fa = f(a)
    fb = f(b)

    for k in 1:maxit
        if abs(fa) < abs(fb)
            a, b = b, a
            fa, fb = fb, fa
        end

        s = (b - a) / (fb - fa)
        b = a
        fb = fa
        a = a - s * fa
        fa = f(a)

        if abs(fa) < epsilon || abs(b - a) < delta
            return (a, fa, k, 0)
        end
    end

    return (a, fa, maxit, 1)
end

function test_mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    (c, w, iterations, error) = mbisekcji(f, a, b, delta, epsilon)

    if error == 1
        println("Error: f(a) * f(b) > 0.0")
    else
        println("c = $c, w = $w, iterations = $iterations")
    end
end

function test_mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    (c, w, iterations, error) = mstycznych(f, pf, x0, delta, epsilon, maxit)

    if error == 1
        println("Error: maxit exceeded")
    elseif error == 2
        println("Error: pf(x0) == 0.0")
    else
        println("c = $c, w = $w, iterations = $iterations")
    end
end

function test_msiecznych(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    (c, w, iterations, error) = msiecznych(f, a, b, delta, epsilon, maxit)

    if error == 1
        println("Error: maxit exceeded")
    else
        println("c = $c, w = $w, iterations = $iterations")
    end
end

function test_iterative_methods()
    println("Metoda bijekcji")
    test_mbisekcji(f1, -10.0, 10.0, eps(), eps())
    test_mbisekcji(f2, 0.0, 10.0, eps(), eps())
    test_mbisekcji(f3, 3.0, 10.0, eps(), eps())

    println("Metoda stycznych")
    test_mstycznych(f1, x -> 1.0, 10.0, eps(), eps(), 1000)
    test_mstycznych(f2, x -> 2.0 * x - 4.0, 1.0, eps(), eps(), 1000)
    test_mstycznych(f3, x -> 3.0 * x^2 - 11.0 * x + 8.0, 10.0, eps(), eps(), 1000)

    println("Metoda siecznych")
    test_msiecznych(f1, -10.0, 10.0, eps(), eps(), 1000)
    test_msiecznych(f2, 0.0, 1.0, eps(), eps(), 1000)
    test_msiecznych(f3, 3.0, 10.0, eps(), eps(), 1000)
end

# test_iterative_methods()

end

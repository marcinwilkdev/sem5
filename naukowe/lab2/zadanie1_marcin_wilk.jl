# Marcin Wilk 261722
"""
    scalarProductAhead(x, y)

Calculates scalar product of two arrays by multiplying
and adding values in given order.
"""
function scalarProductAhead(x::Array{T}, y::Array{T}) where {T<:AbstractFloat}
  product = zero(Float16)

  for vectorIdx = eachindex(x)
    product += x[vectorIdx] * y[vectorIdx]
  end

  return product
end

"""
    scalarProductReverse(x, y)

Calculates scalar product of two arrays by multiplying
and adding values in reversed order.
"""
function scalarProductReverse(x::Array{T}, y::Array{T}) where {T<:AbstractFloat}
  product = zero(Float16)

  for vectorIdx = eachindex(x)
    product += x[reverseind(x, vectorIdx)] * y[reverseind(y, vectorIdx)]
  end

  return product
end

"""
    scalarProductBiggestFirst(x, y)

Calculates scalar product of two arrays by multiplying
and adding values after sorting them in descending order.
"""
function scalarProductBiggestFirst(x::Array{T}, y::Array{T}) where {T<:AbstractFloat}
  products = Array{T,1}(undef, length(x))

  for i = eachindex(x)
    products[i] = x[i] * y[i]
  end

  sort!(products)

  productPositive = zero(Float16)
  productNegative = zero(Float16)

  for productIdx = eachindex(products)
    if products[reverseind(products, productIdx)] > zero(Float16)
      productPositive += products[reverseind(products, productIdx)]
    end

    if products[productIdx] < zero(Float16)
      productNegative += products[productIdx]
    end
  end

  product = productPositive + productNegative

  return product
end

"""
    scalarProductBiggestFirst(x, y)

Calculates scalar product of two arrays by multiplying
and adding values after sorting them in ascending order.
"""
function scalarProductSmallestFirst(x::Array{T}, y::Array{T}) where {T<:AbstractFloat}
  products = Array{T,1}(undef, length(x))

  for i = eachindex(x)
    products[i] = x[i] * y[i]
  end

  sort!(products)

  positiveIdx = 1
  negativeIdx = length(products)

  product = zero(Float16)

  while positiveIdx < length(products) && products[positiveIdx] <= 0
    positiveIdx += 1
  end

  while negativeIdx > 1 && products[negativeIdx] >= 0
    negativeIdx -= 1
  end

  while positiveIdx <= length(products) || negativeIdx >= 1
    if positiveIdx <= length(products) && negativeIdx >= 1
      if abs(products[positiveIdx]) < abs(products[negativeIdx])
        product += products[positiveIdx]
        positiveIdx += 1
      else
        product += products[negativeIdx]
        negativeIdx -= 1
      end
    elseif positiveIdx <= length(products)
      product += products[positiveIdx]
      positiveIdx += 1
    else
      product += products[negativeIdx]
      negativeIdx -= 1
    end
  end

  return product
end

x = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995];
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049];
expected = -1.00657107000000e-11;

x32 = [Float32(2.718281828), Float32(-3.141592654), Float32(1.414213562), Float32(0.577215664), Float32(0.301029995)];
y32 = [Float32(1486.2497), Float32(878366.9879), Float32(-22.37492), Float32(4773714.647), Float32(0.000185049)];

println(scalarProductAhead(x, y))
println(scalarProductReverse(x, y))
println(scalarProductBiggestFirst(x, y))
println(scalarProductSmallestFirst(x, y))
println(expected)

println()

println(scalarProductAhead(x32, y32))
println(scalarProductReverse(x32, y32))
println(scalarProductBiggestFirst(x32, y32))
println(scalarProductSmallestFirst(x32, y32))
println(expected)

# 7.1
## 7.1.3
x = (foo=42, bar="hi")

(; foo, bar) = x
x = (foo=42, bar="hi", f=2)
(; foo, bar) = x
foo
bar
x

# 7.2
## 7.2.2

x = 42

module Sub
x = 421
end

x == Sub.x
x === Sub.x

x = 42
module Sub
println(x)
end

module Sub
println(Main.x)
end

## 7.2.3

for _ in 1:9
    const xx = 4
end

## 7.2.4
let
    x = 421
    println(x)
end

println(x)

if true
    x = "1"
end

print(x)

begin
    y = "begin"
end

print(y)

## 7.2.5
module Foo

x = 42
let
    x = 57
    println(x)
end
println(x)

end

let
    x = 42
    let
        x = 57
        println(x)
    end
    println(x)
end

function minimum(xs)
    res = xs[begin]
    for i in firstindex(xs)+1:lastindex(xs)
        res = min(xs[i], res)
    end
    return res
end

## 7.2.6
let
    x = 57
    let x = 42
        println(x)
    end
    println(x)
end

let
    x = 57
    let x = 2 * x
        println(x)
    end
    println(x)
end

## 7.2.7
@time begin
    using Statistics
    using LinearAlgebra
    using SparseArrays
end

## 7.2.8
x = 42
isdefined(Main, :x)
isdefined(Main, :xxx)

@isdefined x
@isdefined y

let
    xxx = 57
    @isdefined x
    @isdefined xxx
end

## 7.2.9

x = 42
let
    global x
    x = 57
    println(x)
end


x = 42
begin
    local x
    x = 57
    println(x)
end
println(x)

function lastitem(xs)
    local last
    for x in xs
        last = x
    end
    return @isdefined(last) ? last : nothing
end

lastitem(1:3)
lastitem(1:0)

# 7.3
## 7.3.2
findfirst(!isdigit, "1Q84")

map(titlecase ∘ strip, [" foo", " bar "])

1 |> exp |> inv

1 / exp(1)

## 7.4.2
true ? print('T') : print('F')
ifelse(true, print('T'), print('F'))

# 7.5
## 7.5.1
i = 1
while i < 5
    global i
    @show i
    i += 1
end

i = 1
while i < 5
    @show i
    i += 1
end

## 7.5.2
for i in 1:4
    @show i
end

for i in 1:2, j in 1:3
    @show i, j
end

let
    i = 0
    for i in 1:9
    end
    @show i

    i = 0
    for outer i in 1:9
    end
    @show i
end

## 7.5.3
for i in 1:9
    if iseven(i)
        continue
    end
    print(i)
end

for i in 1:9
    if i > 5
        break
    end
    print(i)
end

for i in 1:9, j in 1:9
    if j > 3
        break
    end
    @show i, j
end

[@show i, j for i in 1:9, j in 1:9]
[@show i, j for i in 1:9 for j in 1:9]

# 7.6
## 7.6.1
try
    println("エラー前")
    error("エラー!")
    println("エラー後")
catch
    println("catch")
end

try
    error("error")
catch ex
    @warn ex
end

## 7.6.3
try
    println("try")
catch
    println("catch")
else
    println("else")
end

## 7.6.4
try
    println("try")
    error()
finally
    println("finally")
catch
    println("catch")
end

# 7.7
function fib(n)
    if n <= 2
        return 1
    else
        return fib(n - 1) + fib(n - 2)
    end
end

fib(30)

fib2(n) = n <= 2 ? 1 : fib2(n - 1) + fib2(n - 2)
fib2(30)

foo((x, y)) = @show x y
foo((1, 2))

## 7.7.2
min(3)
min(3, 2)
min(3, 1, 2)

function mymin(x1, xs...)
    ret = x1
    for x in xs
        if isless(x, ret)
            ret = x
        end
    end
    return ret
end

mymin(3, 2)
mymin(3, 2, 1)

## 7.7.3
increment(x, d = 1) = x + d
increment(2)
increment(2, 1)
increment(2, 2)
increment(2, d = 3)

## 7.7.4
increment(x; d = 1) = x + d
increment(2)
increment(2, d = 1)

increment(x; d) = x + d
increment(2, 1)

inc(x, d = 1) = x + d
inc(1, 2)
inc(1, d = 2)

increment(2; :d => 2)

d = 2
increment(2; d)

function print_kwargs(; kwargs...)
    for (key, val) in kwargs
        println(key, "=", val)
    end
end

print_kwargs(; d = 3, a = 4, :b => 5)

## 7.7.5
args = ("Area", ' ', 51)
println(args...)
println.(args)

f(; x = 1, y = 2, z = 3) = (x = x, y = y, z = z)
f(; (;)...)
f(; (x = 10,)...)
f(; (x = 10, y = 20)...)
f(; (x = 10,)..., (z = 30,)...)

## 7.7.6
f(x = rand(); y = rand()) = (; x, y)

f()
f(; y = 1)
f(1.; y = 2.)

g(x, y = x + 1; z = y + 1) = (; x, y, z)
g(1)
g(2)
g(1, 5)
g(1, z = 5)

h(x = print('x'); y = print('y')) = nothing
h()
h(0)
h(y = 10)

## 7.7
function makeadder(x)
    adder(y) = x + y
    return adder
end

adder1 = makeadder(1)
adder5 = makeadder(5)

adder1(1)
adder5(1)

function makecounter()
    n = 0
    function counter()
        n += 1
        return n
    end
    return counter
end

cnt = makecounter()
cnt()

cnt2 = makecounter()
cnt2()

## 7.7.8
(x -> x > 3)(1)
(x -> x > 3)(5)

((x, y) -> x > y)(2, 3)
((x, y) -> x > y)(3, 2)

filter(x -> count_ones(x) == 2, 1:9)

ff = x -> 3 * x ^ 2 - x + 2

ff(10)

## 7.7.9
filter(x -> x > 0, [-1, 2, -3, 5, 0])
filter(>(0), [-1, 2, -3, 5, 0])

# 7.8
(2 * 21)::Int

(2. * 4)::Int

let
    x::Int = 42
    x += 0.1
end

## 7.8.3
greet(name::String) = println("hello! ", name)

greet("test")
greet(3.14)

function f64(x)::Float64
    return x
end

f64(1)
f64("foo")

module America greet() = println("Hi!") end

module Sweden greet() = println("Hej!") end

America.greet()

Sweden.greet()

module A
    module B x = 42 end
    
    module B2 x = 57 end
end

A.B.x
A.B2.x

## 7.9.2
println(@__MODULE__)
module Child println(@__MODULE__) end

Child


max = nothing
Base.max(1, 3, 2)
Base.max = nothing

## 7.9.3
using Base.MathConstants

e
golden
eulergamma

using Base.MathConstants: e, golden


using Base.MathConstants: golden as GOLDEN_RATIO

GOLDEN_RATIO

using Statistics: Statistics

Statistics.mean
Statistics.max



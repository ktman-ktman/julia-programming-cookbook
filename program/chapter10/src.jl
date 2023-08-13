# 10.1
## 10.1.2
Meta.parse("42")
Meta.parse("x + 3")
x = 2
eval(:(x + 3))
eval(42)
eval(3.14)
eval("foo")

module A
x = 'a'
end

module B
x = 'b'
end

A.eval !== B.eval
A.eval(:(x == 'a'))
B.eval(:(x == 'a'))

module C end

C.eval(:(hello() = "hello"))
C.hello()

# 10.2
## 10.2.1

Symbol("foo", "_", "bar")
Symbol(:x, 128)
Symbol("# symbol!")

## 10.2.2
ex = :(x + 3)
ex.head
ex.args

dump(:(2 + 3 * 4^5))

dump(ex)

ex = :(cond ? x : y)
ex.head
ex.args

dump(:(x >= 0 ? println("non-negative") : println("negative")))

## 10.2.3
n = 42
:(x + $n)
:(x + $(n))

ex = :(y - 1)
:(x + $ex)
:(x + $(ex))

eval(ex)

:(max($([:x, :y, :z]...)))

:(f($(:x)))
:(f($(QuoteNode(:x))))

## 10.2.4
Expr(:call, :+, :x, 1)
Expr(:call, :max, :x, :y, :z)

cond = Expr(:call, :>, :x, 0)
blk1 = Expr(:call, :println, "x is positive")
blk2 = Expr(:call, :println, "x is not positive")
Expr(:if, cond, blk1, blk2)

:(x = 42; println(x))

quote
    x = 42
    println(x)
end

n = 42
quote
    x = $(n)
    println(x)
end

# 10.3
const FLAG_A = 0x00000001
const FLAG_B = 0x00000002
const FLAG_C = 0x00000004
const FLAG_D = 0x00000008

eval(:(const FLAG_A = 0x00000001))
eval(:(const FLAG_B = 0x00000002))
eval(:(const FLAG_C = 0x00000004))
eval(:(const FLAG_D = 0x00000008))

for (name, bits) in [
    :FLAG_A => 0x00000001,
    :FLAG_B => 0x00000002,
    :FLAG_C => 0x00000004,
    :FLAG_D => 0x00000008,
]
    eval(:(const $name = $bits))
end

for (i, suffix) in enumerate([:A, :B, :C, :D])
    name = Symbol(:FLAG__, suffix)
    bits = 0x00000001 << i - 1
    eval(:(const $name = $bits))
end

for (i, suffix) in enumerate([:A, :B, :C, :D])
    name = Symbol(:FLAG___, suffix)
    bits = 0x00000001 << i - 1
    @eval const $name = $bits
end

FLAG___D

for T in [UInt8, UInt16, UInt32, UInt64, UInt128]
    @eval msb(x::$T) = x >>> (sizeof($T) * 8 - 1)
end

# 10.4
x = 42
@show(iseven(x), 2x)
@show iseven(x) 2x

for i in 1:9
    @show i
end

for i in 1:9
    println("i = ", repr(i))
end

big"1234"
@big_str "1234"

## 10.4.2
@macroexpand @show x

@less sin(0.5)
@edit sin(0.5)
@which sin(0.5)
@functionloc sin(0.5)

@__DIR__
@__FILE__
@__LINE__
@__MODULE__

## 10.4.3
macro check(ex)
    code = string(ex)
    quote
        print($code, " -> ")
        if $ex
            println("GOOD")
        else
            println("BAD")
        end
    end
end

x = 42
@check x > 0
@check isodd(x)

@macroexpand @check x > 0

## 10.5.1
@generated function genfun(x)
    if x <: Real
        return :(println("$(repr(x)) is real."))
    else
        return :(println("$(repr(x)) is not real."))
    end
end

genfun(42)
genfun(-2im)

function genpoly(n)
    @assert n >= 1
    ex = :(a[1])
    for k in 2:n
        ex = :(fma($(ex), x, a[$(k)]))
    end
    return ex
end

@generated polynominal(
    x::Number,
    a::NTuple{n, Number},
) where n = genpoly(n)

genpoly(1)
genpoly(2)
genpoly(3)


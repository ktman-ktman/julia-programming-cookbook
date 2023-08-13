# 9

## 9.1
### 9.1.1
length(methods(*))
length(methods(+))
length(methods(/))
length(methods(max))

### 9.1.3
===

## 9.2
foo() = "foo()"
foo()
length(methods(foo))

### 9.2.1
foo(x) = "foo($(x))"
length(methods(foo))
foo(1)

foo(1, 2)

foo(x, y) = "foo($(x), $(y))"
length(methods(foo))
foo(1, 2)

foo(x, y, z, args...) = "foo($(x), $(y), $(join((z, args...), ", ")))"
foo(1, 2, 3)
foo(1, 2, 3, 4)
foo(1, 2, 3, 4, 5)
foo(1, 2, 3, [4, 5])

### 9.2.2
bar(x::Int) = "bar($(repr(x))::Int)"
bar(1)
bar(1.0)
bar(x) = "bar($(repr(x)))"
bar(1.2)
bar('a')

bar(x::Int, y::Char) = "bar($(repr(x)), $(repr(y)))"

bar(1, 'a')
bar(1, "AA")

### 9.2.3
baz(x::Any) = "baz($(repr(x))::Any)"
baz(x::Integer) = "baz($(repr(x))::Integer)"
baz(x::Int) = "baz($(repr(x))::Int)"

baz('a')
baz(0x01)
baz(1)

baz(x::Int, y::AbstractFloat) = "baz($(repr(x))::Int, $(repr(y))::AbstractFloat)"
baz(x::Integer, y::Float64) = "baz($(repr(x))::Integer, $(repr(y))::Float64)"
baz(1, 1.2f0)
baz(0x11, 1.2)
baz(0x11, 1.2f0)


baz(x::UInt8, y::Float32) = "baz($(repr(x))::Integer, $(repr(y))::Float64)"
baz(0x11, 1.2f0)

### 9.2.4
qux(x::T, y::T) where {T} = "qux($(repr(x))::$(T), $(repr(y))::$(T))"
qux(1, 2)
qux(1.1, 2.2)
qux('a', 'b')

qux(x::T, y::Vector{T}) where {T} = "qux($(repr(x))::$(T), $(repr(y))::Vector{$(T)})"
qux(1, [1, 2])
qux(1.1, [1.1, 1.2, 1.3])

### 9.2.5
quux(::Type{Int}) = "quux(::Type{Int})"
quux(::Type{Float64}) = "quux(::Type{Float64})"
quux(Int)
quux(Float64)
quux(3)

### 9.2.6
function foobar end
length(methods(foobar))

foobar

## 9.3
### 9.3.1
struct Circle
    r::Float64
    cx::Float64
    cy::Float64

    function Circle(r::Real, cx::Real, cy::Real)
        r >= 0 || throw(ArgumentError("r must be a non-negative!"))
        return new(r, cx, cy)
    end
end
Circle(1, 0, -2)
Circle(-1, 0, -2)

### 9.3.2
struct RGB
    r::UInt8
    g::UInt8
    b::UInt8

    function RGB(r::Integer, g::Integer, b::Integer)
        0 <= r <= 255 && 0 <= g <= 255 && 0 <= b <= 255 || throw(ArgumentError("value must be between 0 and 255."))
        return new(r, g, b)
    end
end

RGB(0, 71, 171)

RGB(x::Integer) = RGB(x, x, x)

RGB(128)

### 9.3.3
struct Normal{T<:Real}
    μ::T
    σ::T

    function Normal{T}(μ::Real=0, σ::Real=1) where {T<:Real}
        σ > 0 || throw(ArgumentError("σ must be positive."))
        return new{T}(μ, σ)
    end
end

function Normal(μ::Real=0, σ::Real=1)
    μ, σ = promote(float(μ), float(σ))
    return Normal{typeof(μ)}(μ, σ)
end

function pdf(dist::Normal, x::Real)
    μ, σ = dist.μ, dist.σ
    return (σ * oftype(σ, √(2π))) \ exp(-2 \ ((x - μ) / σ)^2)
end

Normal{Float32}()
Normal{Float32}(2, 0.5)
Normal()
Normal(2, 0.5)

pdf(Normal(), 1.0)

### 9.3.4
mutable struct Node
    index::Int
    parent::Node

    Node(index::Integer) = new(index)
    Node(index::Integer, parent::Node) = new(index, parent)
end

root = Node(1)
child = Node(2, root)

root.parent

isdefined(root, :parent)
isdefined(child, :parent)

## 9.4
### 9.4.2
mutable struct Stack{T}
    data::Vector{T}
    size::Int

    function Stack{T}(; capasity::Integer=4) where {T}
        data = Vector{T}(undef, capasity)
        return new{T}(data, 0)
    end
end

Stack(; capasity::Integer=4) = Stack{Any}(; capasity)

Base.eltype(::Type{Stack{T}}) where {T} = T
Base.length(stack::Stack) = stack.size
Base.isempty(stack::Stack) = stack.size == 0

function Base.push!(stack::Stack, item)
    item = convert(eltype(stack), item)
    if stack.size == length(stack)
        resize!(stack.data, max(2 * stack.size, 4))
    end
    newsize = stack.size + 1
    stack.data[newsize] = item
    stack.size = newsize
    return stack
end

function Base.pop!(stack::Stack)
    isempty(stack) && throw(ArgumentError("cannot pop! an empty stack"))
    item = stack.data[stack.size]
    stack.size -= 1
    return item
end

stack = Stack{Char}()
eltype(stack)
length(stack)
isempty(stack)

push!(stack, 'a')
push!(stack, 'b')
length(stack)
isempty(stack)

pop!(stack)
pop!(stack)
length(stack)
pop!(stack)
isempty(stack)

## 7.4.3

struct ShortString
    data::UInt64
end

ShortString(s::String) = convert(ShortString, s)

function Base.convert(::Type{ShortString}, s::String)
    n = ncodeunits(s)
    if n > 7 || !isascii(s) || '\0' in s
        throw(InexactError(:ShortString, ShortString, s))
    end
    data = zero(UInt64)
    for i in n:-1:1
        data = (data << 8) | codeunit(s, i)
    end
    return ShortString(data)
end

names = ShortString[]
push!(names, "H")
push!(names, "He")

struct ChemElem
    number::Int
    symbol::ShortString
end

ChemElem(1, "H")
ChemElem(2, "He")

## 7.4.4

show("foo")
print("foo")

Base.convert(::Type{String}, s::ShortString) = sprint(print, s)
Base.show(out::IO, s::ShortString) = show(out, convert(ShortString, s))

function Base.print(out::IO, s::ShortString)
    data = s.data
    while data & 0xff != 0
        write(out, data & Uint8)
        data >> 8
    end
end

ShortString("He")
print(ShortString("He"))

### 9.4.5
struct BitRotator{T<:Base.BitInteger}
    bits::T
end

Base.iterate(rot::BitRotator) = (rot.bits, 1)

function Base.iterate(rot::BitRotator, k::Int)
    x = rot.bits
    nbits = sizeof(x) * 8
    if k >= nbits
        return nothing
    end
    return bitrotate(x, k), k + 1
end

Base.length(rot::BitRotator) = sizeof(rots.bits) * 8

for x in BitRotator(0b00001000)
    println(bitstring(x))
end

### 9.4.6
struct Composition{T<:Real} <: AbstractVector{T}
    data::Vector{T}
    function Composition(x)
        c = x ./ sum(x)
        return new{eltype(c)}(c)
    end
end

Base.:*(α::Real, x::Composition) = Composition(x .^ α)
Base.:*(x::Composition, α::Real) = Composition(x .^ α)

Base.:+(x::Composition, y::Composition) = Composition(x .* y)

Base.:-(x::Composition) = Composition(inv.(x))
Base.:-(x::Composition, y::Composition) = x + (-y)

Base.size(x::Composition) = size(x.data)
Base.getindex(x::Composition, i::Integer) = x.data[i]

x = Composition([1, 3, 4])
2x
x + Composition([1, 1, 2])

# 9.5

abstract type Trait end
struct TraitA <: Trait end
struct TraitB <: Trait end

f(x) = _f(Trait(typeof(x)), x)
_f(::TraitA, x) = "Trait A"
_f(::TraitB, x) = "Trait B"

struct Foo end
Trait(::Type{Foo}) = TraitA()
struct Bar end
Trait(::Type{Bar}) = TraitB()
struct Baz end
Trait(::Type{Baz}) = TraitB()

f(Foo())
f(Bar())
f(Baz())

Base.IteratorSize(Set)
Base.IteratorSize(Vector)
Base.IteratorSize(Base.EachLine)

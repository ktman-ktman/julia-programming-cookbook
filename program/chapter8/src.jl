# 8.1
supertype(Int32)
supertype(Int64)

subtypes(Real)
subtypes(Integer)
subtypes(Signed)

1 isa Int64
1 isa Signed
1.0 isa Int64
1.0 isa Signed

Int64 <: Integer
Int64 <: AbstractFloat
Float64 <: Integer
Float64 <: AbstractFloat

Int64 <: Any

## 8.2.1
Complex{Float32}
Complex{Float64}

x = 3.1 - 2.4im
typeof(real(x))
typeof(imag(x))

Vector{Int}
Vector{Integer}
Dict{String,Int}

## 8.2.3
Vector{Int64} <: Vector{T} where {T}
Vector{String} <: Vector{T} where {T}

Vector{String} <: Vector{T} where {T<:Real}

Vector{<:Real} <: Vector{T} where {T<:Real}
(Vector{T} where {T<:Real}) <: Vector{<:Real}

Vector{<:Real} == Vector{T} where {T<:Real}
Vector == Vector{T} where {T}

Dict{K,V} where {K} where {V}
Dict{K,V} where {K,V}

Dict{K,V} where {K,V<:Real}

Dict{String}
Dict{String,V} where {V}
Dict{K,Int} where {K}

Dict{String,Int64} <: (Dict{String,V} where {V})
Dict{String,Int64} <: (Dict{K,Int64} where {K})

Vector{Int64} <: Vector{Integer}
Vector{Int64} <: Vector{<:Integer}

Tuple{Int64} <: Tuple{Integer}
Tuple{Int64,Float64} <: Tuple{Integer,AbstractFloat}

NTuple{2,Int} == Tuple{Int,Int}
NTuple{3,Int} == Tuple{Int,Int,Int}

# 8.3

Union{Int64,Float64}

42 isa Union{Int64,Float64}
1.0 isa Union{Int64,Float64}
0x0a isa Union{Int64,Float64}
b = Union{Int64,Float64}

1.9 isa b
b

Int32 <: b
Int64 <: b
Float32 <: b
Float64 <: b

cities = Union{String,Missing,Nothing}[]
push!(cities, "Tokyo")
push!(cities, "Osaka")
push!(cities, missing)
push!(cities, nothing)

typeof(cities)

typeof([])

const IEEE754Float = Union{Float16,Float32,Float64}

IEEE754Float

# 8.5
abstract type Name <: Any end
abstract type My end

typeof(Name)

abstract type Number end
abstract type Real <: Number end

abstract type AbstractNode2{X,Y,Z} end
abstract type AbstractNode3{X,Y,Z<:Real} end

# 8.6
z = 3.1 - 2.4im
z.re
z.im

struct MyName
    field1::String
    field2::String
end

## 8.6.2
struct ChemElem
    number::Int
    symbol::String
end

hydrogen = ChemElem(1, "H")
helium = ChemElem(2, "He")
lithium = ChemElem(3, "Li")

println(hydrogen)

hydrogen.number
hydrogen.symbol

## 8.6.3
struct Point2D{T}
    x::T
    y::T
end

p1 = Point2D(1, 2)
typeof(p1)

p2 = Point2D(1.2, 3.4)
typeof(p2)

p3 = Point2D{Float32}(1, 2)

struct Point2D2{T<:Real}
    x::T
    y::T
end

Point2D2(1, 2)
Point2D2(1.0, 2.0)
Point2D2('a', 2.0)

## 8.6.4
struct Singleton end
const SINGLETON = Singleton()

SINGLETON == Singleton()
SINGLETON == Singleton()
SINGLETON == Singleton()
SINGLETON == Singleton()

SINGLETON === Singleton()
SINGLETON === Singleton()
SINGLETON === Singleton()

abstract type NucleicAcid end
primitive type DNA <: NucleicAcid 8 end

reinterpret(DNA, 0x03)

reinterpret(DNA, 0x11)

@enum DNA2::UInt8 DNA_A DNA_C DNA_G DNA_T

DNA_A
DNA_C
DNA_G
DNA_T

struct PeriodicTable
    elements::Vector{ChemElem}
    groups::Vector{Int}
    periods::Vector{Int}
end

table = PeriodicTable(
    [ChemElem(1, "H"), ChemElem(2, "He"), ChemElem(3, "Li"), ChemElem(4, "Be"), ChemElem(5, "B"), ChemElem(6, "C")],
    [1, 18, 3, 4, 13, 14],
    [1, 1, 2, 2, 2, 2]
)

push!(table.elements, ChemElem(7, "N"))
push!(table.groups, 15)
push!(table.periods, 2)

table.elements = ChemElem[]

empty!(table.elements)
isempty(table.elements)

## 8.9.1
isabstracttype(Signed)
isabstracttype(Int)

isconcretetype(Signed)
isconcretetype(Int)

isconcretetype(Vector)
isconcretetype(Vector{Int})

ismutable((42,))
ismutable([42,])

isbitstype(Complex{Float64})
isbitstype(Vector{Float64})

## 8.9.2
function reportfields(T)
    println(T)
    for i in 1:fieldcount(T)
        name = fieldname(T, i)
        type = fieldtype(T, i)
        println(" [$(i)] $(name) :: $(type)")
    end
end

reportfields(Complex{Float64})
reportfields(ChemElem)

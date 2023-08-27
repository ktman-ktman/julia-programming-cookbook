# 18.2
xs = rand(10000)
@time sort(xs)
@time sort(xs)
sort(xs[1:9])
@time(sort(xs))
@elapsed sort(xs)
@allocated sort(xs)

using BenchmarkTools

xs = rand(100_000)
@btime sort(xs);

@btime sort(rand(1000));
@btime sort($(rand(1000)));

x = 1.23
@btime sincos(x)
@btime sincos($(x))

xs = rand(100_000)
@benchmark sort($xs)

xs = rand(100_000)
alg = InsertionSort
@btime sort!($(xs); alg=$alg)
issorted(xs)

xs = rand(100_000)

@btime sort!(ys; alg=$alg) setup = (ys = copy($xs)) evals = 1;

issorted(xs)

# 18.3
using LinuxPerf
xs = rand(100_000)
sort(xs)
@pstats sort(xs)

# 18.4
xs = rand(100_000)
ys = [];
for x in xs
    push!(ys, x)
end;
@btime sum($xs)
@btime sum($ys)

f() = fetch(@async 2 + 3)::Int

A = zeros(10)

for i in firstindex(A):2:lastindex(A)
    @inbounds A[i] = i
end

@inbounds for i in firstindex(A):2:lastindex(2)
    A[i] = i
end

@inline function mod5p1(n)
    return mod(n, 5) + 1
end

@inline mod5p1(n) = mod(n, 5) + 1

# 18.5
struct Vec4{T}
    x::T
    y::T
    z::T
    w::T
end

norm(v::Vec4) = sqrt(abs2(v.x) + abs2(v.y) + abs2(v.z) + abs2(v.w))

function norm(v::AbstractArray)
    s = zero(eltype(v))
    for x in v
        s += abs(x)
    end
    return sqrt(s)
end

v = randn(4)
vec = fill(v, 1000)
@btime sum(norm, $vec)
vec4 = fill(Vec4(v...), 1000)
@btime sum(norm, $vec4)

using StaticArrays

v = @SVector Float64[0, 1, 2, 3, 4, 5, 6, 7]
typeof(v)
A = @SMatrix [1.0 2.0; 3.0 4.0]
typeof(v)

using LinearAlgebra

A = Diagonal(randn(1000))
B = randn(1000)

@btime A * B;

a = Matrix(A)

@btime a * B;

# 18.6

foo() = [2, 3, 5, 7]

@time foo()

A = randn(1000, 1000)
@btime sum($A[:, 1:500], dims=1)
@btime sum(@view($A[:, 1:500]), dims=1)

A = randn(1000, 1000)
B = randn(1000, 1000)

@btime A * B

using LinearAlgebra
C = similar(A * B)
@allocated C
@btime mul!($C, $A, $B)

A = randn(1000, 1000)
B = randn(1000)
C = similar(A)
@btime $C .= $A .+ $B

a = randn(1000);
b = randn(1000);
c = similar(a);
@btime $c .= 2 .* $a .+ abs2.($b);
@btime @. $c = 2 * $a + abs2($b);
@btime $c .= 2 .* $a + abs2.($b);

function summ(A, idx)
    s = 0.0
    for i in idx
        @inbounds s += A[i]
    end
    return s
end

using Random: shuffle

A = randn(10_000_000)
serial = collect(1:length(A))
@btime summ($A, $serial)

random = shuffle(serial)
@btime summ($A, $random)

# 11.1
## 11.1.2

zeros(Int, (4, 3))
zeros(Int, 4, 3)
zeros(4, 3)

fill(0xff, 4)

[1, 2, 3]
[1, 2, 3,]
[
    1 2 3
    4 5 6
]

[1 2 3; 4 5 6]

eltype([1, 0x02, 3.0])
eltype([])

eltype(Int16[1, 0x02, 3.0])
eltype([])

Array{UInt8}(undef, 4096)

A = zeros(3, 4)
B = similar(A)

vcat([1, 2, 3], [4, 5, 6])

hcat([1, 2, 3], [4, 5, 6])

[1, 2, 3]

repeat([1, 2], 3)

repeat([1, 2], 2, 5)

cat(A, B; dims=1) == vcat(A, B)
cat(A, B; dims=2) == hcat(A, B)

A = zeros(2, 2)
B = ones(2, 2)
[A; B]
[A;; B]
[A;;; B]

stack([[1, 2, 3], [4, 5, 6]])

## 11.4.1
a = [1:12;]
reshape(a, 3, 4)

reshape(a, 2, 6)

A = reshape(a, 3, 4)
A[1, 1] = 100
A

## 11.1.5
A = [
    1 2 3;;;
    4 5 6;;;
    7 8 9;;;
    9 10 11
]

idx = CartesianIndex(1, 1, 1)
A[idx]

## 11.1.6
A = zeros(3, 4)
firstindex(A)
lastindex(A)

firstindex(A, 1)
firstindex(A, 2)
lastindex(A, 1)
lastindex(A, 2)
A

A[begin+1]
A[end]

## 11.1.7
A = [
    1 2 3
    4 5 6
    7 8 9
]

A[2:3, [1, 3]]

A[2:end, [1, 3]]

A[:, [1, 3]]

A = [
    1 2 3 4 5
    6 7 8 9 10
]

A[:, [1, 2, 2, 5, 3]]

A = [
    1 2 3
    4 5 6
]

A[:, [false, true, true]]

v = [-1, 3, 0, -2, 5]
v[v.>0]

## 11.1.8
A = [
    1 2 3
    4 5 6
]

A[2, 3]

A[2, 2:3]

A[2:2, 3]

A[2:2, 3:3]

A[2:2, 2:3]

A = [
    1 2 3
    4 5 6
]

v = A[2, :]
v[1] = 100
A
v

## 11.1.9
A = [
    1 2 3
    4 5 6
    7 8 9
]

view(A, 3, 1:2)

view(A, :, 2)
view(A, :, [3, 1])

x = view(A, :, 2)
x[1] = 200

A

@view A[2:end, 2:end]

x = view(A, :, 3)
sum(x)

## 11.1.10
x = [0.0, 1.0, 2.0]
exp.(x)

log.([1.0 2.0; 3.0 4])

log.((1, 2, 3))

x = [1.0, 3.8, -2.1]
y = [2.0, 1.1, -1.4]

max.(x, y)

x ./ y
x .+ y
x + y
x - y

x / y

z = [true, false, true]
.!z

## 11.1.11
1 .+ [1, 2, 3]
1 .+ [1 2 3]

[1 2 3]

A = [1, 2, 3]
B = [10 20]
size(A)
size(B)

A .+ B
## 11.1.12

α = 2.1
x = [0.0, 1.0, 2.0]
y = [3.0, 4.0, 5.0]

z = α * x + y

z = α .* x .+ y

y .= α .* x .+ y
y .+= α .* x

@. exp(-x^2 / 2)
@. y = α * x + y

## 11.1.13
B = falses(4, 4)
B[3, 4]
B[3, 4] = true
B[3, 4]
B

[-1, 1, 3, -2, 4] .> 0

sz = (1024, 1024)
Base.summarysize(sz)
Base.summarysize(falses(sz))

Base.summarysize(falses(sz)) / Base.summarysize(fill(false, sz))

# 11.2
rand()

rand(2, 3)
rand(0:255)
rand(Bool)
rand(Bool)

rand([2, 3, 5, 7, 11], 4)

randn()
randn(4)

σ = 0.2
μ = 0.05

randn() * σ + μ

randn(10) .* σ .+ μ

using Random

x = zeros(5)

rand!(x)

m, n = 100, 5

X = randn(m, n)

X[shuffle(1:m), :]

X[:, shuffle(1:n)]

ix = shuffle(1:m)
X1 = X[ix[1:m÷2], :]
X2 = X[ix[m÷2+1:m], :]

rand()
rand()

Random.seed!(1234)
rand()
rand()

Random.seed!(1234)
rand()
rand()

Random.seed!(4321)
rand()
rand()

rng = MersenneTwister(1234)
rand(rng)
rand(rng)

rng = MersenneTwister(1234)
rand(rng)
rand(rng)

## 11.3
Vector <: AbstractVector
Matrix <: AbstractMatrix

1:9 isa AbstractArray
1:9 isa AbstractVector
1:9 isa AbstractMatrix


## 11.3
using LinearAlgebra

Diagonal([1.0, 2.0, 3.0])

A = [
    1.0 2.0
    1.0 1
]

U = UpperTriangular(A)
U[2, 1]
U.data[2, 1]
U.data == A

S = Symmetric(A)

S[2, 1]
S.data[2, 1]
S.data == A

x = [1.0, 2.0, 3.0]
y = [2.0, 1.0, -2.0]

dot(x, y)

x ⋅ y
x'y

A = [
    1.0 2.0
    1.0 1.0
]

x = [3.0, -1.0]

A * x

A * A

A = [
    1.0 2.0
    3.0 4
]

diag(A)

A[diagind(A)] .+= 1 / 8

A

x = [3.0, -1.0]
x'

A = [
    1.0 2.0
    3.0 4.0
]
A'

x'X

A'x

A * x

A' * x

x = [1.0, 2.0, 3.0]'
y = [1.0 2.0 3]
z = [1.0, 1.0, 1.0]

x * z
y * z

A = [
    1.0 2.0
    1.0 1.0
]

B = [
    3.0 -2
    -1 4
]

A \ B
B / A

A = [
    -0.7 0.7
    0.3 -0.3
]

exp(A)

A = [
    1.0 -2.0
    3.0 1.0
]

F = qr(A)
F.Q

F.R

F.Q * F.R
A

Q, R = qr(A)
Q * R

A

Matrix(F.Q)

S = [
    2.0 1.0+eps()
    1.0 3
]

issymmetric(S)
cholesky(S)
cholesky(Symmetric(S))
cholesky(Symmetric(S, :U))
cholesky(Symmetric(S, :L))

Symmetric
Hermitian

Hermitian <: Symmetric


## 11.4
using SparseArrays

spzeros(10)
spzeros(5, 10)

function mysparse(I, J, V, m=maximum(I), n=maximum(J))
    M = spzeros(m, n)
    for (i, j, v) in zip(I, J, V)
        M[i, j] = v
    end
    return M
end

sprand(100, 100, 0.05)
sprandn(100, 100, 0.05)

x = spzeros(4)
x[1] = 1.0
x[3] = 2.0
nnz(x)
nonzeros(x)

S = sparse(1:3, 1:3, 0:2)
nnz(S)

S = dropzeros(S)
nnz(S)

A = sprand(100, 100, 0.01)
nnz(A)

Base.summarysize(A) / Base.summarysize(Matrix(A))

A = sparse([
    0 3 0 4 0
    1 0 0 5 8
    2 0 0 6 0
    0 0 0 7 9
])

A.colptr
A.rowval
A.nzval

## 11.5
heights = [150, 158, 150.5, 147, 163, 158, 164.5, 155.5, 149]
sum(heights)
minimum(heights)
maximum(heights)
extrema(heights)

using Statistics

mean(heights)
median(heights)
var(heights)
std(heights)

x = rand(10_000)
mean(x -> -log(x), x)

X = [
    90.2 23.0
    88.5 21.1
    89.0 25.6
    98.4 30.1
]

μ = mean(X, dims=1)
σ = std(X, dims=1)

(X .- μ) ./ σ

cov(X)
cov(X, dims=2)

sin(missing)
missing + 1.2
missing | true
missing & false

1.2 == missing
missing == missing
missing === missing
ismissing(1.2)
ismissing(missing)

x = [1.1, 3.0, missing, 5.9, missing]
mean(x)
mean(skipmissing(x))

coalesce(x, 0.0)
fillzero(x) = coalesce(x, 0.0)
fillzero(x)
coalesce(x, 1)

fillzero(missing)


# 5

## 5.1
### 5.1.1
(3, -2.4, "foo")

(foo=3, bar=-2.4, baz="foo")

(3,)
()

(foo=3,)
(;)

x = (2, 3, 4)

(x...,)

(1, x...)

(1, x..., 5)

x = (bar=-2.4,)

(foo=3, x...)

x, y = 3, -2.4

(; x, y)

x = (3, -2.4, "foo")

x[1]
x[2]
x[3]

x[begin]
x[end]

x[end-1]
x[begin+1]

x = (foo=3, bar=-2.4, baz="foo")

x.foo
x.:foo
x[:foo]

1:9
1:2:9
9:-1:1

0.0:0.1:1.0

'a':'z'

### 5.1.2
range(0, stop=1)
range(0, length=101)

range(0, length=101, step=0.1)
range(0, stop=1, length=51)
range(0, 1, length=51)

0:typemax(Int)

## 5.1.3

[1]
[1,]

[1, 2, 3]
[1, 2, 3,]

[
    1 2 3
    4 5 6
]

a = [10, 20, 30]
a[1]
a[2]

A = [
    1 2 3
    4 5 6
]

A[1, 2]
A[2, 3]

zeros(UInt8, 8)
ones(UInt8, 8)
fill(0xff, 8)

ndims(a)
ndims(A)

size(a)
size(A)
size(a, 1)
size(A, 2)

length(a)
length(A)

a = [10, 20, 30]
a[1] = 100
a[1]

a[2] += 1
a[2]

a[4]

a = [1, 2]
push!(a, 3)
pushfirst!(a, 0)
pop!(a)
popfirst!(a)
append!(a, 3:4)
prepend!(a, -1:0)

### 5.1.4

Dict("one" => 1, "two" => 2, "three" => 3)

Dict(["one" => 1, "two" => 2, "three" => 3])
Dict([("one", 1), ("two", 2), ("three", 3,)])

Dict()

Dict{String,Int}()

d = Dict("one" => 1, "two" => 2, "three" => 3)
d["one"]
d["two"]

d["zero"]

haskey(d, "zero")
haskey(d, "one")
d["zero"] = 0
haskey(d, "zero")

delete!(d, "zero")

d = Dict("one" => 1, "two" => 2, "three" => 3)
get(d, "one", 0)
get(d, "zero", 0)

haskey(d, "zero")
get!(d, "zero", 0)
haskey(d, "zero")

### 5.1.5
Set([2, 3, 5])
Set(1:9)
Set(["one", "two", "three"])

s = Set()
s = Set{Int}()
s = Set(Int[])

push!(s, 1)
push!(s, 2, 3)
union(s, 3:5)
intersect(s, 3:5)

### 5.1.6
(i for i in 1:9)
(2^k for k in 0:9)
(i for i in 1:typemax(Int))

[i for i in 1:9 if isodd(i)]
(i for i in 1:9 if isodd(i))

((i, j) for i in 1:2 for j in 1:3)
((i, j) for i in 1:2, j in 1:3)

sum(sin(i) / i for i in 1:1000)

[i for i in 1:9]
[i for i in 1:9 if isodd(i)]

[(i, j) for i in 1:2 for j in 1:3]
[(i, j) for i in 1:2, j in 1:3]

[(i, j, k) for i in 1:2 for j in 1:2 for k in 1:2]
[(i, j, k) for i in 1:2, j in 1:2, k in 1:2]

Tuple(i for i in 1:9)
Dict(string(i) => i for i in 1:9)
Set(i for i in 1:9)

## 5.2
### 5.2.1

A = [0, 1, 2, 3, 2, 1]
counter = Dict{Int,Int}()
for x in A
    count = get!(counter, x, 0)
    counter[x] += 1
end
counter[0]
counter[1]

r = range(0, 1, length=5)
eltype(r)
length(r)
collect(r)

foreach(println, 'A':'C')

### 5.2.2
findall([true, false, true])

findall(isodd, 11:19)
findall(>(16), 11:19)

f(x) = 2x
A = [3, 1, -1, 5]
argmin(f, A)
findmin(f, A)

### 5.2.3
filter(isodd, 11:19)
map(x -> 2x, 1:5)

A = [2, 4, 1, 3]
sort(A)
sort(A, rev=true)

### 5.2.4
reduce(+, 1:9)
reduce(|, 1:9)

1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16

reduce(-, 1:9)
foldr(-, 1:9)
foldl(-, 1:9)
mapreduce(f, -, 1:9)

### 5.2.5
A = [1, 2, 3]
B = copy(A)

A[1] = 100
A[1]
B[1]

A = [[1], [2]]
B = copy(A)
A[1] === B[1]
A[1][1] = 100
B[1][1]

A = [[1], [2]]
B = deepcopy(A)
A[1] === B[1]
A[1][1] = 100
B[1][1]

## 5.3
x = ("foo", "bar")
x[2], x[1] = x[1], x[2]

t = ([1,],)
push!(t[1], 2)
t
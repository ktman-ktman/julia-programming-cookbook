# 15.1
using BenchmarkTools

ptr = cglobal((:message, "./program/chapter15/libvoyager.so"), Cstring)
unsafe_string(unsafe_load(ptr))
ccall((:say_hello, "./program/chapter15/libvoyager.so"), Cvoid, ())

zlibver = ccall((:zlibVersion, "libz"), Cstring, ())

unsafe_string(zlibver)

unsafe_load(cglobal(:jl_any_type, Any))

unsafe_string(ccall(:jl_ver_string, Cstring, ()))

ccall(:exp, Cdouble, (Cdouble,), 1.0)

s = "foobar"
c = 'a'
p = ccall(:strchr, Ptr{Char}, (Cstring, Cint), s, c)
p - pointer(s)

@ccall exp(1::Cdouble)::Cdouble
@ccall strchr(s::Cstring, c::Cint)::Ptr{Char}

x1 = "bar"
x2 = "foobar"
memcmp(x1, 0, x2, 0)

function csort!(xs::Vector{Float64})
    ccall(
        (:sort, "./program/chapter15/libsort.so"),
        Cvoid,
        (Ref{Cdouble}, Csize_t),
        xs, length(xs),
    )
    return xs
end

xs = randn(1000)
issorted(xs)
csort!(xs)
issorted(xs)

@benchmark sort!(randn(10000))
@benchmark csort!(randn(10000))

using PyCall

PyCall.pyversion

PyCall.python

PyCall.libpython

divmod = pybuiltin(:divmod)
divmod(42, 8)

int = pybuiltin(:int)
int("deadbeef", base=16)

set = pybuiltin(:set)
len = pybuiltin(:len)
primes = set([2, 5, 7, 11])
typeof(primes)
len(primes)
pycall(len, PyObject, primes)
@pycall len(primes)::PyObject

math = pyimport("math")
math.sin(1.0)
math.cos(1.0)
math.exp(1.0)

stats = pyimport("scipy.stats")

py"divmod"(42, 8)
py"divmod(42, 8)"

m, n = 42, 8
py"divmod($(m), $(n))"

py"""
import textwrap
def wraptext(text, width=5):
    return "\n".join(textwrap.wrap(text, width=width))
"""
wrap = py"wraptext"

println(wrap("this is a pen. this is a pen."))

py"""
import numpy
def make_matrix(m, n):
    return numpy.arange(m * n).reshape(m, n)
"""
make_matrix = py"make_matrix"

make_matrix(4, 3)

@pycall make_matrix(3, 4)::PyArray

using RCall

R"c(1, 2, c(3, 4))"

R"sum(c(1, 2, 3))"

R"sum($([1.0, 2.4, 1.3]))"

rsum = R"sum"
rsum([1.0, 2.0, 3])

rcopy(R"c(1, 2, 3)")

X = Float64[1 2 3; 4 5 6]
R"colSums($X)"

using DataFrames
using RDatasets

iris = dataset("datasets", "iris")
size(iris)

names(iris)

R"library(randomForest); set.seed(1234)"

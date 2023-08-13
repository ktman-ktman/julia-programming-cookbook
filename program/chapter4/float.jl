#!/usr/bin/evn julia

function fl1(M, beta, e, p)
    @assert abs(M) < beta^p
    return M * beta^(e - p + 1.0)
end

M = 123
beta = 10
e = 1
p = 3
fl1(M, beta, e, p)

[fl1(M, beta, e, p) for e in -2:3]

[fl1(M, beta, 1, p) for M in 123:124]

[fl1(M, beta, 2, p) for M in 123:124]

[fl1(M, beta, 0, p) for M in 123:124]

[fl1(M, beta, 3, p) for M in 123:124]

# 4.4.2


function fl2(s, m, e, beta)
    return (-1)^s * m * beta^2
end

0 == 0.0

1 === 1

0 === 0.0

0 == -0

0 === -0

0.0 == -0.0

0.0 === -0.0

Inf
NaN

0.1

using Printf

@printf "%.30f" 0.1

@sprintf "%.6f" 0.123

@sprintf "%.6e" 0.123

0.0 == -0.0

NaN == NaN

isequal(0.0, -0.0)

isequal(NaN, NaN)

iszero(0.0)

iszero(-0.0)

iszero(1.0)

isnan(NaN)

isnan(1.0)

-0.0 < 0

-0.0 > 0

1.0 > NaN
1.0 < NaN

isless(0.0, -0)
isless(-0.0, 0)
isless(0.0, 0.0)
isless(0.0, -0.0)

isapprox(1.0, 1.0 - 1e-8)
isapprox(1.0, 1.0 - 1e-7)

1.0 ≈ 1.0 - 1e-8

isapprox(0, 5e-324)
isapprox(0, 5e-324, atol=1e-30)

eps()

eps

eps(Float16)

eps(1.0)
eps(2.0)

x = big"0.1"
y = BigFloat(0.1)
@printf "%f" abs(x - y) / x / eps()

precision(BigFloat)

T = Int
zero(T)
one(T)

function split_sub(isprefix, s)
    pos = findfirst(!isprefix, s)
    pos === nothing && return SubString(s), SubString("")
    return @view(s[begin:prevind(s, pos)]), @view(s[pos:end])
end

function split_str(isprefix, s)
    pos = findfirst(!isprefix, s)
    pos === nothing && return s, ""
    return s[begin:prevind(s, pos)], s[pos:end]
end

using Random
using BenchmarkTools

strs = [randstring(30) for _ in 1:1000]
@btime for s in $strs
    split_sub($isletter, s)
end
@btime for s in $strs
    split_str($isletter, s)
end
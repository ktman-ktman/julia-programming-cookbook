mutable struct Record{T}
    serial::Int
    data::T
end

struct Database{T}
    records::Vector{Record{T}}
end

Database{T}() where {T} = Database{T}(Record{T}[])

function Base.push!(db::Database{T}, item) where {T}
    serial = length(db.records)
    record = Record(serial, convert(T, item))
    push!(db.records, record)
    return db
end

using BenchmarkTools

items = randn(1_000_000)
@btime for item in $items
    push!(db, item)
end setup = (db = Database{Float64}())


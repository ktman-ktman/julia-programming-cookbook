using Test

include("calccircle.jl")

@testset "circle" begin
    r = 2.1
    @test diameter(r) ≈ 4.2
    @test circumference(r) ≈ 13.194689
    @test area(r) ≈ 13.8544236
end
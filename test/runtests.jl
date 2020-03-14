using TestMarkov
using Test
using PyPlot
@testset "Running Simulation" begin
    X,Y,A=simulate(0.0)
    X,Y,B=simulate(0.9)

    try
        pygui(false)
        figure(figsize=(7,7))
        imshow(tanh.((A.+B)./100),cmap="inferno")
        savefig(joinpath(@__DIR__, "paths.png"),bbox_inches_tight=true)
    catch
        println("Something went wrong during plotting")
        @test false
    end
    @test true
end

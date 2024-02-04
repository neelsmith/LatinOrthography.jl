
@testset "Test Latin24" begin
    latin = latin24()
    @test typeof(latin) == Latin24
    @test supertype(Latin24) == LatinOrthographicSystem

    ttypes = tokentypes(latin)
    @test length(ttypes) == 3

    @test validcp("i", latin)
    @test validcp("j", latin) == false
    @test validcp("v", latin)
    @test validcp("u", latin)

    @test validstring("vocauit", latin)
    @test validstring("Juno", latin) == false
end


@testset "Test Latin25" begin
    latin = latin25()
    @test typeof(latin) == Latin25
    @test supertype(Latin25) == LatinOrthographicSystem

    ttypes = tokentypes(latin)
    @test length(ttypes) == 3

    @test validcp("i", latin)
    @test validcp("j", latin)
    @test validcp("v", latin)
    @test validcp("u", latin)

    @test validstring("vocauit", latin)
    @test validstring("Juno", latin)
end
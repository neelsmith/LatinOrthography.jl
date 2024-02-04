
@testset "Test supertype of orthography" begin
    latin = latin24()
    @test typeof(latin) == Latin24
    @test supertype(Latin24) == LatinOrthographicSystem


    
end

@testset "Test supertype of orthography" begin
    latin = latin23()
    @test typeof(latin) == Latin23
    @test supertype(Latin23) == OrthographicSystem
end

@testset "Test token types" begin
    latin = latin23()
    ttypes = tokentypes(latin)
    @test length(ttypes) == 2
end

@testset "Test valid character test" begin
    latin = latin23()
    @test validchar(latin, "i")
    @test validchar(latin, "j") == false
end

@testset "Test valid string test" begin
    latin = latin23()
    @test validstring(latin, "Hercules")
end

@testset "Test punctuation classification" begin
    @test LatinOrthography.isPunctuation(":")
    @test LatinOrthography.isPunctuation("a:") == false
end

@testset "Test alphabetic classification" begin
    @test LatinOrthography.isAlphabetic("Hercules")
    @test LatinOrthography.isAlphabetic("Hercules?") == false
end


@testset "Test tokenization" begin
    latin = latin23()    
    tkns = latin.tokenizer("Hercules Deianiram uxorem duxit.")
    @test length(tkns) == 5
    @test tkns[1].text == "Hercules"
    @test tkns[1].tokencategory == Orthography.LexicalToken()
    @test tkns[end].text == "."
    @test tkns[end].tokencategory == Orthography.PunctuationToken()
end



@testset "Test supertype of orthography" begin
    latin = latin23()
    @test typeof(latin) == Latin23
    @test supertype(Latin23) == LatinOrthographicSystem
end

@testset "Test token types" begin
    latin = latin23()
    ttypes = tokentypes(latin)
    @test length(ttypes) == 2
end

@testset "Test valid character test" begin
    latin = latin23()
    @test_broken validchar(latin, "i")
    @test_broken validchar(latin, "j") == false
end

@testset "Test valid string test" begin
    latin = latin23()
    @test validstring("Hercules", latin)
end

@testset "Test punctuation classification" begin
    @test LatinOrthography.isPunctuation(":", latin23())
    @test LatinOrthography.isPunctuation("a:", latin23()) == false
end

@testset "Test alphabetic classification" begin
    @test LatinOrthography.isAlphabetic("Hercules", latin23())
    @test LatinOrthography.isAlphabetic("Hercules?", latin23()) == false
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


@testset "Test tokenizing a CitablePassage" begin
    ortho = latin23()

    urn = CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:30pr.1")
    txt = "Infans cum esset, dracones duos duabus manibus necauit, quos Iuno miserat, unde primigenius est dictus."
    cn = CitablePassage(urn,txt)
    tkns = tokenize(cn, ortho)
    @test length(tkns) == 19
end

@testset "Test tokenizing a CitableTextCorpus" begin
    urn = CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:30pr.1")
    txt = "Infans cum esset, dracones duos duabus manibus necauit, quos Iuno miserat, unde primigenius est dictus."
    cn1 = CitablePassage(urn,txt)
    cn2 = CitablePassage(CtsUrn("urn:cts:latinLit:stoa1263.stoa001.hc:30pr.2"), "Leonem Nemeum, quem Luna nutrierat in antro amphistomo atrotum, necauit, cuius pellem pro tegumento habuit.")
    c = CitableTextCorpus([cn1, cn2])


    ortho = latin23()
    tkns = tokenize(c, ortho)
    @test length(tkns) == 38
end
#
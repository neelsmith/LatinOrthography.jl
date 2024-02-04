
"""
An orthographic system for encoding Latin with a 25-character alphabet.
`i` and `u`  represents both vocalic values whie `j` and `v` are used for consonantal values.
"""    
struct Latin25 <: LatinOrthographicSystem
    codepoints
    tokencategories
    tokenizer
end

OrthographyTrait(::Type{Latin25}) = IsOrthographicSystem()

"""Implement Orthography's tokenize function for `Latin25`.

$(SIGNATURES)    
"""    
function tokenize(s::AbstractString, o::Latin25)
    tokenizeLatin25(s)
end

"""Implement `codepoints` function of MID `OrthographicSystem` interface.

$(SIGNATURES)
"""
function codepoints(ortho::Latin25)
    ortho.codepoints
end

"""Implement `tokentypes` function of MID `OrthographicSystem` interface.

$(SIGNATURES)
"""
function tokentypes(ortho::Latin25)
    ortho.tokencategories
end

"""Define range of alphabetic character for Latin25 orthography.

$(SIGNATURES)
"""
function alphabetic(ortho::Latin25) 
   latinalphabet() 
end


"""Define range of alphabetic character for Latin25 orthography.

$(SIGNATURES)
"""
function latin25alphabet()
    ranges = [
        'a':'j' ; 'k':'v'; 'x':'z';
        'A':'J' ; 'K':'V'; 'X':'Z';
    ]
    join(ranges,"")
end





"""Define recognized punctuation characters for Latin orthographies.

$(SIGNATURES)
"""
function whitespace(ortho::Latin25)
    latinwhitespace()
end



"""Instantiate a Latin25 with correct code points and token types.

$(SIGNATURES)
"""
function latin25()

    cps = latin25alphabet() * latinpunctuation() *  latinwhitespace() * "+"
    ttypes = [
        Orthography.LexicalToken,
        #Orthography.NumericToken,
        Orthography.PunctuationToken,
        EncliticToken
    ]
    Latin25(cps, ttypes, tokenizeLatin25)
end

"""Define recognized punctuation characters for Latin orthographies.

$(SIGNATURES)
"""
function punctuation(ortho::Latin25)
    latinpunctuation()
end


"""Tokenize Latin text.

$(SIGNATURES)
"""
function tokenizeLatin25(s::AbstractString)
    wsdelimited = split(s)
    
    depunctuated = map(nows -> splitPunctuation(nows, latin25()), wsdelimited) |> Iterators.flatten |>  collect 
    
    tknstrings = []
    for depunctedstr in depunctuated
        parts = split(depunctedstr, "+")
        if length(parts) == 2
            push!(tknstrings, parts[1])
            push!(tknstrings, string("+", parts[2]))
        else
            push!(tknstrings, depunctedstr)
        end
      
    end
    tkns = map(t -> tokenforstring(t, latin25()), tknstrings)
end

"""True if all characters in s are alphabetic.

$(SIGNATURES)
"""
function isAlphabetic(s::AbstractString, ortho::Latin25) 
    #chlist = split(s,"")
    alphas =  alphabetic(ortho)
    tfs = []
    for i in collect(eachindex(s)) 
        push!(tfs, occursin(s[i], alphas))
    end
    nogood = false in tfs
   
    !nogood
end

"""True if all characters in s are punctuation.
$(SIGNATURES)

"""
function isPunctuation(s::AbstractString, ortho::Latin25)::Bool
    #chlist = split(s,"")
    puncts =  punctuation(ortho)
    tfs = []
    for i in collect(eachindex(s)) 
        push!(tfs, occursin(s[i], puncts))
    end
    nogood = false in tfs
   
    !nogood
end


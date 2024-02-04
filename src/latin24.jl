
"""
An orthographic system for encoding Latin with a 24-character alphabet.
`i`  represents both vocalic and semi-vocalic or consonantal values.
"""    
struct Latin24 <: LatinOrthographicSystem
    codepoints
    tokencategories
    tokenizer
end

OrthographyTrait(::Type{Latin24}) = IsOrthographicSystem()

"""Implement Orthography's tokenize function for `Latin24`.

$(SIGNATURES)    
"""    
function tokenize(s::AbstractString, o::Latin24)
    tokenizeLatin24(s)
end

"""Implement `codepoints` function of MID `OrthographicSystem` interface.

$(SIGNATURES)
"""
function codepoints(ortho::Latin24)
    ortho.codepoints
end

"""Implement `tokentypes` function of MID `OrthographicSystem` interface.

$(SIGNATURES)
"""
function tokentypes(ortho::Latin24)
    ortho.tokencategories
end

"""Define range of alphabetic character for Latin24 orthography.

$(SIGNATURES)
"""
function alphabetic(ortho::Latin24) 
   latin24alphabet() 
end


"""Define range of alphabetic character for Latin24 orthography.

$(SIGNATURES)
"""
function latin24alphabet()
    ranges = [
        'a':'i' ; 'k':'v'; 'x':'z';
        'A':'I' ; 'K':'V'; 'X':'Z';
    ]
    join(ranges,"")
end





"""Define recognized punctuation characters for Latin orthographies.

$(SIGNATURES)
"""
function whitespace(ortho::Latin24)
    latinwhitespace()
end



"""Instantiate a Latin24 with correct code points and token types.

$(SIGNATURES)
"""
function latin24()

    cps = latin24alphabet() * latinpunctuation() *  latinwhitespace() * "+"
    ttypes = [
        Orthography.LexicalToken,
        #Orthography.NumericToken,
        Orthography.PunctuationToken,
        EncliticToken
    ]
    Latin24(cps, ttypes, tokenizeLatin24)
end

"""Define recognized punctuation characters for Latin orthographies.

$(SIGNATURES)
"""
function punctuation(ortho::Latin24)
    latinpunctuation()
end


"""Tokenize Latin text.

$(SIGNATURES)
"""
function tokenizeLatin24(s::AbstractString)
    wsdelimited = split(s)
    
    depunctuated = map(nows -> splitPunctuation(nows, latin24()), wsdelimited) |> Iterators.flatten |>  collect 
    
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
    tkns = map(t -> tokenforstring(t, latin24()), tknstrings)
end

"""True if all characters in s are alphabetic.

$(SIGNATURES)
"""
function isAlphabetic(s::AbstractString, ortho::Latin24) 
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
function isPunctuation(s::AbstractString, ortho::Latin24)::Bool
    #chlist = split(s,"")
    puncts =  punctuation(ortho)
    tfs = []
    for i in collect(eachindex(s)) 
        push!(tfs, occursin(s[i], puncts))
    end
    nogood = false in tfs
   
    !nogood
end


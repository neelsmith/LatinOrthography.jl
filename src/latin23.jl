
"""
An orthographic system for encoding Latin with a 23-character alphabet.
`i` and `u` represent both vocalic and semi-vocalic or consonantal values.
"""    
struct Latin23 <: LatinOrthographicSystem
    codepoints
    tokencategories
    tokenizer
end

OrthographyTrait(::Type{Latin23}) = IsOrthographicSystem()

"""Implement Orthography's tokenize function for `Latin23`.

$(SIGNATURES)    
"""    
function tokenize(s::AbstractString, o::Latin23)
    tokenizeLatin23(s)
end

"""Implement `codepoints` function of MID `OrthographicSystem` interface.

$(SIGNATURES)
"""
function codepoints(ortho::Latin23)
    ortho.codepoints
end

"""Implement `tokentypes` function of MID `OrthographicSystem` interface.

$(SIGNATURES)
"""
function tokentypes(ortho::Latin23)
    ortho.tokencategories
end

"""Define range of alphabetic character for Latin23 orthography.

$(SIGNATURES)
"""
function alphabetic(ortho::Latin23) 
   latin23alphabet() 
end


"""Define range of alphabetic character for Latin23 orthography.

$(SIGNATURES)
"""
function latin23alphabet()
    ranges = [
        'a':'i' ; 'k':'u'; 'x':'z';
        'A':'I' ; 'K':'U'; 'X':'Z';
    ]
    join(ranges,"")
end

"""Define recognized punctuation characters for Latin23 orthography.

$(SIGNATURES)
"""
function latin23punctuation()
    ".,;:?"
end

"""Define recognized punctuation characters for Latin23 orthography.

$(SIGNATURES)
"""
function punctuation(ortho::Latin23)
    latin23punctuation()
end



"""Define recognized punctuation characters for Latin23 orthography.

$(SIGNATURES)
"""
function whitespace(ortho::Latin23)
    latin23whitespace()
end

"""Define recognized punctuation characters for Latin23 orthography.

$(SIGNATURES)
"""
function latin23whitespace()
    " \n\t"
end


"""Instantiate a Latin23 with correct code points and token types.

$(SIGNATURES)
"""
function latin23()

    cps = latin23alphabet() * latin23punctuation() *  latin23whitespace() * "+"
    ttypes = [
        Orthography.LexicalToken,
        #Orthography.NumericToken,
        Orthography.PunctuationToken,
        EncliticToken
    ]
    Latin23(cps, ttypes, tokenizeLatin23)
end


"""Tokenize Latin text.

$(SIGNATURES)
"""
function tokenizeLatin23(s::AbstractString)
    wsdelimited = split(s)
    
    depunctuated = map(nows -> splitPunctuation(nows, latin23()), wsdelimited) |> Iterators.flatten |>  collect 
    
    tknstrings = []
    for depunctedstr in depunctuated
        parts = split(depunctedstr, "+")
        if length(parts) == 2
            push!(tknstrings, parts[1])
            push!(tknstrings, string("+", parts[2]))
        else
            push!(tknstrings, depuncted)
        end
      
    end
    tkns = map(t -> tokenforstring(t, latin23()), tknstrings)
end

"""True if all characters in s are alphabetic.

$(SIGNATURES)
"""
function isAlphabetic(s::AbstractString, ortho::Latin23) 
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
function isPunctuation(s::AbstractString, ortho::Latin23)::Bool
    #chlist = split(s,"")
    puncts =  punctuation(ortho)
    tfs = []
    for i in collect(eachindex(s)) 
        push!(tfs, occursin(s[i], puncts))
    end
    nogood = false in tfs
   
    !nogood
end


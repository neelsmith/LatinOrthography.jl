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




"""Define range of alphabetic characters.

$(SIGNATURES)
"""
function alphabetic() 
    ranges = [
        'a':'i' ; 'k':'u'; 'x':'z';
        'A':'I' ; 'K':'U'; 'X':'Z';
    ]
    join(ranges,"")
end


"""Define recognized punctuation characters.

$(SIGNATURES)
"""
function punctuation()
    ".,;:?"
end



"""Define recognized whitespace characters.

$(SIGNATURES)
"""
function whitespace()
    " \n\t"
end

"""Split off any trailing punctuation and return an Array of leading strim + trailing punctuation.

$(SIGNATURES)
"""
function splitPunctuation(s::AbstractString)
    punct = Orthography.collecttail(s, LatinOrthography.punctuation())
    trimmed = Orthography.trimtail(s, LatinOrthography.punctuation())
    filter(s -> ! isempty(s), [trimmed, punct])
end


"""Instantiate a Latin23 with correct code points and token types.

$(SIGNATURES)
"""
function latin23()
    cps = alphabetic() * punctuation() *  whitespace()
    ttypes = [
        Orthography.LexicalToken,
        #Orthography.NumericToken,
        Orthography.PunctuationToken,
    ]
    Latin23(cps, ttypes, tokenizeLatin23)
end


"""Create correct `OrthographicToken` for a given string.


$(SIGNATURES)
"""
function tokenforstring(s::AbstractString)
    #if isNumeric(s)
    #    OrthographicToken(s, NumericToken())
    if isAlphabetic(s)
        OrthographicToken(s, LexicalToken())
    elseif isPunctuation(s)
        OrthographicToken(s, PunctuationToken())
    else
        OrthographicToken(s, Orthography.UnanalyzedToken())
    end
end

"""Tokenize Latin text.

$(SIGNATURES)
"""
function tokenizeLatin23(s::AbstractString)
    wsdelimited = split(s)
    depunctuated = map(s -> splitPunctuation(s), wsdelimited)
    tknstrings = collect(Iterators.flatten(depunctuated))
    tkns = map(t -> tokenforstring(t), tknstrings)
end


"""True if all characters in s are alphabetic.

$(SIGNATURES)
"""
function isAlphabetic(s::AbstractString)
    chlist = split(s,"")
    alphas =  alphabetic()
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
function isPunctuation(s::AbstractString)::Bool
    chlist = split(s,"")
    puncts =  punctuation()
    tfs = []
    for i in collect(eachindex(s)) 
        push!(tfs, occursin(s[i], puncts))
    end
    nogood = false in tfs
   
    !nogood
end


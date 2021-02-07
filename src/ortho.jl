

"""
An orthographic system for encoding Latin with a 23-character alphabet.
`i` and `u` represent both vocalic and semi-vocalic or consonantal values.
"""    
struct Latin23 <: OrthographicSystem
    codepoints
    tokencategories
    tokenizer
end

function alphabetic() 
    ranges = [
        'a':'i' ; 'k':'u'; 'x':'z';
        'A':'I' ; 'K':'U'; 'X':'Z';
    ]
    join(ranges,"")
end

function punctuation()
    ".,;:?"
end



"Split off any trailing punctuation and return an Array of leading strim + trailing punctuation."
function splitPunctuation(s::AbstractString)
    punct = Orthography.collecttail(s, Latin.punctuation())
    trimmed = Orthography.trimtail(s, Latin.punctuation())
    filter(s -> ! isempty(s), [trimmed, punct])
end


"Instantiate a Latin23 with correct code points and token types."
function latin23()
    cps = alphabetic() * punctuation()
    ttypes = [
        Orthography.LexicalToken,
        #Orthography.NumericToken,
        Orthography.PunctuationToken,
    ]
    Latin23(cps, ttypes, tokenizeLatin)
end


"Create correct `OrthographicToken` for a given string."
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

"Tokenize Latin text."
function tokenizeLatin(s::AbstractString)
    wsdelimited = split(s)
    depunctuated = map(s -> splitPunctuation(s), wsdelimited)
    tknstrings = collect(Iterators.flatten(depunctuated))
    tkns = map(t -> tokenforstring(t), tknstrings)
end


"True if all characters in s are alphabetic."
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

"True if all characters in s are punctuatoin."
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


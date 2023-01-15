
"""Abstract type for orthographic systems implementing  functions specific to Latin orthography, in addition to the requirements of the Orthography.jl package's OrthographicSystem.
"""
abstract type LatinOrthographicSystem <: OrthographicSystem end
    

"""Define recognized alphabetic characters for a `LatinOrthographicSystem`.

$(SIGNATURES)
"""
function alphabetic(ortho::T) where {T <: LatinOrthographicSystem}
    throw(DomainError("Function 'alphabetic' not implemnted for type $(typeof(ortho))"))
end


"""Define recognized punctuation characters for a `LatinOrthographicSystem`.

$(SIGNATURES)
"""
function punctuation(ortho::T) where {T <: LatinOrthographicSystem}
    throw(DomainError("Function 'punctuation' not implemnted for type $(typeof(ortho))"))
end


"""Define recognized whitespace characters for all implementations of `LatinOrthographicSystem`.

$(SIGNATURES)
"""
function whitespace(ortho::T) where {T <: LatinOrthographicSystem}
    throw(DomainError("Function 'whitespace' not implemnted for type $(typeof(ortho))"))
end




"""Split off any trailing punctuation and return an Array of leading strim + trailing punctuation.

$(SIGNATURES)
"""
function splitPunctuation(s::AbstractString, ortho::T) where {T <: LatinOrthographicSystem}
    punctchars = punctuation(ortho)
    punct = Orthography.collecttail(s, punctchars)
    trimmed = Orthography.trimtail(s, punctchars)
    filter(s -> ! isempty(s), [trimmed, punct])
end



"""Create correct `OrthographicToken` for a given string.


$(SIGNATURES)
"""
function tokenforstring(s::AbstractString, ortho::T)  where {T <: LatinOrthographicSystem}
    #if isNumeric(s)
    #    OrthographicToken(s, NumericToken())
    if startswith(s, "+")
        OrthographicToken(s[2:end], EncliticToken())
    elseif isAlphabetic(s, ortho)
        OrthographicToken(s, LexicalToken())
    elseif isPunctuation(s, ortho)
        OrthographicToken(s, PunctuationToken())
    else
        OrthographicToken(s, Orthography.UnanalyzedToken())
    end
end
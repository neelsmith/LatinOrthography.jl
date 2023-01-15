module LatinOrthography

using Documenter, DocStringExtensions
using Orthography
import Orthography: OrthographyTrait
import Orthography: tokentypes 
import Orthography: codepoints 
import Orthography: tokenize

export LatinOrthographicSystem

export Latin23, latin23
export codepoints, tokentypes, tokenize
export alphabetic, punctuation, whitespace

"Category of enclitic tokens."
struct EncliticToken <: TokenCategory end
export EncliticToken


include("orthography.jl")
include("latin23.jl")

end # module

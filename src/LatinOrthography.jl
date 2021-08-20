module LatinOrthography


using Documenter, DocStringExtensions
using Orthography
import Orthography: codepoints, tokentypes, tokenize

export Latin23
export latin23
export codepoints, tokentypes, tokenize

include("latin23.jl")

end # module

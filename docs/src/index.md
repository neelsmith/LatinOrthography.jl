# `LatinOrthography.jl`: documentation

*Implementations of the HCMID `OrthographicSystem` interface for Latin texts*


## Latin23

`Latin23` is an orthography for Latin texts with 23 alphabetic characters — that is, orthographies with a single character for vocalic/consonantal `i/j` and a single character for vocalic/consonantal  `u/v`.  The function `latin23` creates an instance of this orthography.  It is a subtype of the HCMID `OrthographicSystem`.

```@example intro
using LatinOrthography
ortho  =  latin23()
typeof(ortho) |> supertype
```


### Valid characters and token types

The `Latin23` type implements the basic functions of the `OrthographicSystem` interface:

- `codepoints`: returns a complete list of codepoints allowed in this orthography
- `tokentypes`: enumeration of the types of tokens recognized in this orthography


```@example intro
codepoints(ortho)
```
```@example intro
tokentypes(ortho)
```

These give us (for free!) implementations of the `OrthographicSystem`'s `validchar` and `validstring` functions.

```@example intro
using Orthography
validchar(ortho, "a")
```

```@example intro
validchar(ortho, "β")
```

```@example intro
validstring(ortho, "Nunc est bibendum.")
```

```@example intro
validstring(ortho, "μῆνιν ἄειδε")
```


### Tokenizing a string

The `tokenize` function returns an array of `OrthographicTokens`, each of which has a string value and a token type from the set of token types possible for this orthography.


```@example intro
tkns = tokenize(ortho, "Nunc est bibendum.")
```

```@example intro
tkns[1].text
```

```@example intro
tkns[1].tokencategory
```

```@example intro
tkns[4].text
```

```@example intro
tkns[4].tokencategory
```
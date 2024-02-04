# `LatinOrthography.jl`: documentation

*Implementations of the HCMID `OrthographicSystem` interface for Latin texts*


## Latin23

`Latin23` is an orthography for Latin texts with 23 alphabetic characters — that is, texts with a single character for vocalic/consonantal `i/j` and a single character for vocalic/consonantal  `u/v`.  The function `latin23` creates an instance of this orthography.  It is a subtype of the HCMID `OrthographicSystem`.

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
validcp("a", ortho)
```

```@example intro
validcp("β", ortho)
```

```@example intro
validstring( "Nunc est bibendum.", ortho)
```

```@example intro
validstring( "μῆνιν ἄειδε", ortho)
```


### Tokenizing a string

The `tokenize` function returns an array of `OrthographicTokens`, each of which has a string value and a token type from the set of token types possible for this orthography.


```@example intro
tkns = tokenize("Nunc est bibendum.", ortho)
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




## Latin24

`Latin24` is an orthography for Latin texts with 24 alphabetic characters — that is, texts with a single character for vocalic/consonantal `i/j` but distinguishing consonantal  `v` from vocalic `u`.  The function `latin24` creates an instance of this orthography.  It is a subtype of the HCMID `OrthographicSystem`.

```@example intro

ortho24  =  latin24()
validcp("v", ortho24)

```

```@example intro
validcp("j", ortho24)
```



## Latin25

`Latin25` is an orthography for Latin texts with 25 alphabetic characters. It distinguishes vocalic/consonantal `i` and `u` from consonantal  `j` and `v`.  The function `latin25` creates an instance of this orthography.  It is a subtype of the HCMID `OrthographicSystem`.

```@example intro

ortho25  =  latin25()
validcp("v", ortho25)

```

```@example intro
validcp("j", ortho25)
```
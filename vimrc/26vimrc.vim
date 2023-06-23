echom "Hello"

" 0
echom "Hello" + "world"

" 5
echom "3 mice " + "2 cats"

" 20
echom  10 + "10.10"

" string concatenation
echom "3 mice " . "2 cats"

echom "Hello, " . "world"

" 10foo
echom 10 . "foo"

" error using float as string
echom 10.1 . "foo"

" string literals
echom 'That''s enough'

" no. vim coerced to int then evaluated
if "foo"
    echo "yes"
else
    echo "no"
endif

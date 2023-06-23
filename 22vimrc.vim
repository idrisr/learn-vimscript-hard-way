" comparisons

" foo
if 10 > 1
    echom "foo"
endif

" nothing
if 10 > 2001
    echom "bar"
endif

" second
if 10 == 11
    echom "first"
elseif 10 == 10
    echom "second"
endif

" two
if "foo" == "bar"
    echom "one"
elseif "foo" == "foo"
    echom "two"
endif

set noignorecase
" vim is case sensitive
if "foo" == "FOO"
    echom "vim is case insensitive"
elseif "foo" == "foo"
    echom "vim is case sensitive"
endif

" no, it couldn't be
set ignorecase
if "foo" == "FOO"
    echom "no, it couldn't be"
elseif "foo" == "foo"
    echom "this must be the one"
endif

" ==? always case insensitive
set noignorecase
if "foo" ==? "FOO"
    echom "first"
elseif "foo" ==? "foo"

    echom "second"
endif

" ==? always case sensitive
set ignorecase
if "foo" ==# "FOO"
    echom "one"
elseif "foo" ==# "foo"
    echom "two"
endif

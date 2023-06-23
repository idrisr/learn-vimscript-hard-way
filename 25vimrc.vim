" numbers
echomsg 100
echomsg 010
echomsg 017

" invalid octal
" vim prints 19
echomsg 019

echomsg 100.1
echomsg 5.45e+3

" coercion to float
echomsg 2*2.0

" integer division
echomsg 3 / 2

" float division
echomsg 3.0 / 2
echomsg 3 / 2.0

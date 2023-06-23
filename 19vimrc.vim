" variables
let foo="bar"
echo foo
let foo=42
echo foo

" options as variables
set textwidth=80
echo &textwidth
let &textwidth=100
set textwidth?

let &textwidth=&textwidth+10
set textwidth?

" registers as variables
let @a = "fuck yeah!"
echo @a

" unnamed register
echo @"

" last search pattern register
echo @/

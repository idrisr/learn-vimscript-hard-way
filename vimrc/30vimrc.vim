" move to the top of the file
    " search for the first occurrence of foo, and
    " delete the line that contains it

execute "normal! gg/foo\<cr>dd"


" mq: store the current location in mark q
" A: move to the end of the current line and
    " enter insert mode after the last character
" ;: put a literal semicolon in the file
" \<esc>: a string escape sequence
    " resolves to a press of the escape key, which
    " takes us out of insert mode
" ‘q: return to the exact location of mark q

execute "normal! mqA;\<esc>`q"

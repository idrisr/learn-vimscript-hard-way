" define the mapping to insert the unicode character
let mapleader=";"
nnoremap <leader>t :<c-u>call InsertUnicodeCharacter('0AA4')<cr>

" function to insert a unicode character at the current cursor position
function! InsertUnicodeCharacter(codepoint)
    let a = str2nr('0x' . a:codepoint, 16)
    let b = nr2char(a)
    execute "normal! i" . b
endfunction

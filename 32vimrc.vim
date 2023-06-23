let mapleader=";"

" doesnt escape shell chars to grep
" nnoremap <leader>g :grep -R <cword> .<cr>

noremap <leader>g :silent execute
            \ "grep! -R ".
            \ shellescape(expand("<cWORD>"))
            \ . " ."<cr>:copen<cr>

noremap <script> <buffer> <silent> [[ <nop>
noremap <script> <buffer> <silent> ]] <nop>
noremap <script> <buffer> <silent> [] <nop>
noremap <script> <buffer> <silent> ][ <nop>

noremap <script> <buffer> <silent> ]] :call <SID>NextSection(1, 0)<cr>
noremap <script> <buffer> <silent> [[ :call <SID>NextSection(1, 1)<cr>
noremap <script> <buffer> <silent> ][ :call <SID>NextSection(2, 0)<cr>
noremap <script> <buffer> <silent> [] :call <SID>NextSection(2, 1)<cr>

function! s:NextSection(type, backwards)
    if a:backwards
        let dir = '?'
    else
        let dir = '/'
    endif
    execute 'silent normal! ' . dir . 'foo' . "\r"
endfunction

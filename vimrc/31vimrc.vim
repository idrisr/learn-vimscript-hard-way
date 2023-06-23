set hlsearch
set incsearch

execute "normal! gg/print\<cr>n"

" single quotes sends raw data
"   usefor for slashes
"   but doesnt interpret special chars like <cr>
"   so use " for that
"   then concat
execute "normal! gg" . '/\vfor .+ in .+:' . "\<cr>"

command! -bang CheckBang :call CheckBang(<bang>0)
function! CheckBang(force)
  if a:force
    echo "Bang was used!"
  else
    echo "Bang was not used."
  endif
endfunction

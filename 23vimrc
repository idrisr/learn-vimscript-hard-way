" functions
function Meow()
    echom "Meow!"
    " implicit return value 0 aka false
endfunction

function GetMeow()
    return "Meow String!"
endfunction

" return value thrown away
call Meow()

" passes return value to echom
echomsg GetMeow()

function TextwidthIsTooWide()
    if &l:textwidth ># 80
        return 1
    endif
    " implicit return value 0 aka false
endfunction

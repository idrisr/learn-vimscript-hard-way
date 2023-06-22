function DisplayName(name)
    echomsg "Hello!, My name is:"
    echomsg a:name
endfunction

call DisplayName("WOT")

function Varg(...)
    echom a:0
    echom a:1
    echom a:000
endfunction
call Varg("a", "b")

function Varg2(foo, ...)
    echom a:foo
    " argc
    echom a:0
    echom a:1
    " extra args
    echom a:000
endfunction
call Varg2("a", "b", "c")

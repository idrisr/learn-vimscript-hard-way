echo ['foo', 3, 'bar']
echo ['foo', [3, 'bar']]
echo [0, [1, 2]][1]
echo [0, [1, 2]][-2]
echo ['a', 'b', 'c', 'd', 'e'][0:2]
echo ['a', 'b', 'c', 'd', 'e'][:1]
echo ['a', 'b', 'c', 'd', 'e'][3:]
echo "abcd"[0:2]

let foo=['a']
call add(foo, 'b')
echo foo
echo get(foo, 0, 'default')
echo get(foo, 100, 'default')

echom expand('%')
echom expand('%:p')
echom fnamemodify('foo.txt', ':p')

echo globpath('.', '*')
echo split(globpath('.', '*'), '\n')

echo split(globpath('.', '*.txt'), '\n')
echo split(globpath('.', '**'), '\n')

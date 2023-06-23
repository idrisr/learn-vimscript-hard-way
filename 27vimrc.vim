" identical when using strings
echomsg strlen("foo")
echomsg len("foo")

echomsg split("one two three")
echomsg split("one,two,three", ",")
echomsg join(["foo", "bar"], "...")
echomsg join(split("foo bar"), ";")

echomsg tolower("Foo")
echomsg toupper("Foo")
echo split('1 2')
echo split('1,,,2', ',')

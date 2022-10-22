ls pics/cards/ | get name | each {|x| basename $x |str replace "\\..*" '"'| str trim | '"' + $in}| str collect "\n     , " |  $"module HasPicList exposing \(..)\npList : List String\npList = [ " + $in + "\n    ]"| save -r src/HasPicList.elm

ls pics/characters/ | get name | each {|x| basename $x | str replace "\\..*" '"' | str trim|  '"' + $in} | str collect "\n    , " | "\ncList : List String \ncList = [ " + $in + "\n    ]" | save -r --append src/HasPicList.elm 

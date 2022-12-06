
def as_name [name:string] {
    basename $name |str replace "\\..*" '"'| str trim | '"' + $in
}

def named [l] {each {|x| as_name $x}}

def as_elm_list [l] {
    $l | str collect "\n    , " |  "[ " + $in + "\n    ]"
}

let mod_head = "module HasPicList exposing (..)\n"

def folder_list [fpath lname] {
    ls $fpath | get name | named $in | as_elm_list $in | $lname + ": List String\n" + $lname + " = " + $in + "\n"
}

let res = $mod_head + (folder_list pics/cards/ pList) + (folder_list pics/characters/ cList)

$res | save -rf src/HasPicList.elm



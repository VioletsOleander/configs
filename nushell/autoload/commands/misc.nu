# Sort the 'words' field in 'cspell.json'
export def sort-cspell-words [] {
    let f = 'cspell.json'

    if ($f | path exists) {
        let content = open $f
        let sorted_words = $content | get words | sort

        $content
        | update words $sorted_words
        | save -f $f

        print $'Successfully sorted ($f).'
    } else {
        print $'Error: ($f) not found under current working directory.'
    }
}

export def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    ^yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != $env.PWD and ($cwd | path exists) {
        cd $cwd
    }
    rm -fp $tmp
}

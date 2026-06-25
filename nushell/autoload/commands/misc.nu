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

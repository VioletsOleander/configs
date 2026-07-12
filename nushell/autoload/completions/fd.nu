def types [] {
    [
        {value: 'f', description: 'regular files'}
        {value: 'd', description: 'directories'}
        {value: 'l', description: 'symbolic links'}
        {value: 's', description: 'socket'}
        {value: 'p', description: 'named pipe (FIFO)'}
        {value: 'b', description: 'block device'}
        {value: 'c', description: 'character device'}
        {value: 'x', description: 'executables'}
        {value: 'e', description: 'empty files or directories'}
    ]
}

export extern main [ 
    --hidden (-H) # Include hidden directories and files in the search results (default: hidden files and directories are skipped).
    --no-ignore (-I) # Show search results from files and directories that would otherwise be ignored by '.gitignore', '.ignore', '.fdignore', or the global ignore file, The flag can be overridden with --ignore.
    --case-sensitive (-s) # Perform a case-sensitive search. By default, fd uses case-insensitive searches, unless the pattern contains an uppercase character (smart case).
    --type (-t): string@types
]

export extern main [
    pattern?: string # A regular expression used for searching.
    ...path: path # A file or directory to search. Directories are searched recursively. File paths specified on the command line override glob and ignore rules.
    --ignore-case (-i) # When this flag is provided, all patterns will be searched case insensitively.
    --glob (-g): string # Include or exclude files and directories for searching that match the given glob. Precede a glob with a ! to exclude it.
    --debug # Show debug messages.
]

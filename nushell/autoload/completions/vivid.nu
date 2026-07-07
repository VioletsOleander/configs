use _utils.nu filter-block

# Subcommands for vivid
def commands [] {
    ^vivid --help
    | lines
    | filter-block 'Commands:'
    | parse --regex '\s+(?<value>\S+)\s+(?<description>.+)'
}

def themes [] {
    ^vivid themes
    | lines
}

export extern main [
    --version (-V)
    command?: string@commands
]

export extern 'vivid generate' [
    theme: string@themes
]

export extern 'vivid preview' [
    theme: string@themes
]

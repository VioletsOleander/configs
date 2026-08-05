use _utils.nu filter-block

# Subcommands for dprint
def commands [] {
    ^dprint --help
    | lines
    | filter-block 'SUBCOMMANDS:'
    | parse --regex '\s+(?<value>\S+)\s+(?<description>.+)'
}

export extern main [
    --version (-V)
    command?: string@commands
]

export extern 'dprint fmt' [
    --staged # Format only the staged files.
]

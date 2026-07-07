use _utils.nu filter-block

# Subcommands for rustup
def commands [] {
    ^rustup --help
    | lines
    | filter-block 'Commands:'
    | parse --regex '\s+(?<value>\S+)\s+(?<description>.+)'
}

# Subcommands for rustup toolchain
def toolchain-commands [] {
    ^rustup toolchain --help
    | lines
    | filter-block 'Commands:'
    | parse --regex '\s+(?<value>\S+)\s+(?<description>.+)'
}

# Subcommands for rustup show
def show-commands [] {
    ^rustup show --help
    | lines
    | filter-block 'Commands:'
    | parse --regex '\s+(?<value>\S+)\s+(?<description>.+)'
}

def installed-toolchains [] {
    ^rustup toolchain list --quiet
    | lines
}

export extern main [
    --version (-V)
    command?: string@commands
]

export extern 'rustup help' [
    command?: string@commands
]

export extern 'rustup toolchain' [
    command?: string@toolchain-commands
]

export extern 'rustup toolchain list' [
    --verbose (-v)
    --quiet (-q) # Force the output to be a single column.
]

export extern 'rustup default' [
    toolchain?: string@installed-toolchains
]

export extern 'rustup show' [
    --verbose (-v)
    command?: string@show-commands
]

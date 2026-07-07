use _utils.nu filter-block

# Subcommands for gh
def commands [] {
    let lines = ^gh --help | lines

    mut commands = $lines | filter-block 'CORE COMMANDS'
    $commands ++= $lines | filter-block 'GITHUB ACTIONS COMMANDS'
    $commands ++= $lines | filter-block 'ALIAS COMMANDS'
    $commands ++= $lines | filter-block 'ADDITIONAL COMMANDS'

    $commands
    | parse --regex '\s+(?<value>\S+):\s+(?<description>.+)'
}

# Subcommands for gh pr
def pr-commands [] {
    let lines = ^gh pr --help | lines

    mut commands = $lines | filter-block 'GENERAL COMMANDS'
    $commands ++= $lines | filter-block 'TARGETED COMMANDS'

    $commands
    | parse --regex '\s+(?<value>\S+):\s+(?<description>.+)'
}

# Fields for gh pr view --json
def json-fields [] {
    let lines = ^gh pr view --json e>| lines # gh pr --json prints output to stderr

    $lines
    | slice 1..
    | parse --regex '\s+(?<value>\S+)'
}

export extern main [
    --version
    command?: string@commands
]

export extern 'gh pr' [
    command?: string@pr-commands

]

export extern 'gh pr view' [
    --comments (-c) # View pull request comments.
    --json: string@json-fields # Output JSON with the specified fields
    --jq (-q): string # Filter JSON output using a jq expression
    --web (-w) # Open a pull request in the browser
    target?: string
]

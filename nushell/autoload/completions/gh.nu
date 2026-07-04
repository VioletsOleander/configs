# Filter the lines after the 'title' line and before a blank line
def filter-commands [title: string]: list<string> -> list<string> {
    let lines = $in

    mut start_idx = 0
    mut end_idx = 0

    for $line in ($lines | enumerate) {
        if $line.item == $title {
            $start_idx = $line.index + 1
        }
        if $start_idx > 0 and ($line.item | str trim) == '' {
            $end_idx = $line.index - 1
            break
        }
    }

    $lines
    | slice $start_idx..$end_idx
}

# Subcommands for gh
def commands [] {
    let lines = ^gh --help | lines

    mut commands = $lines | filter-commands 'CORE COMMANDS'
    $commands ++= $lines | filter-commands 'GITHUB ACTIONS COMMANDS'
    $commands ++= $lines | filter-commands 'ALIAS COMMANDS'
    $commands ++= $lines | filter-commands 'ADDITIONAL COMMANDS'

    $commands
    | parse --regex '\s+(?<value>\S+):\s+(?<description>.+)'
}

# Subcommands for gh pr
def pr-commands [] {
    let lines = ^gh pr --help | lines

    mut commands = $lines | filter-commands 'GENERAL COMMANDS'
    $commands ++= $lines | filter-commands 'TARGETED COMMANDS'

    $commands
    | parse --regex '\s+(?<value>\S+):\s+(?<description>.+)'
}

export extern main [
    --version
    command?: string@commands
]

export extern 'gh pr' [
    command?: string@pr-commands

]

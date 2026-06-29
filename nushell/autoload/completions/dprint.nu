# Subcommands for dprint
def commands [] {
    let lines = ^dprint --help | lines

    # Start from the row after 'SUBCOMMANDS:' and end with a blank row
    mut start_idx = 0
    mut end_idx = 0
    for $line in ($lines | enumerate) {
        if $line.item == 'SUBCOMMANDS:' {
            $start_idx = $line.index + 1
        }
        if $start_idx > 0 and ($line.item | str trim) == '' {
            $end_idx = $line.index - 1
            break
        }
    }

    $lines
    | slice $start_idx..$end_idx
    | parse --regex '\s+(?<value>\S+)\s+(?<description>.+)'
}

export extern main [
    --version (-V)
    command?: string@commands
]

export extern 'dprint fmt' [
    --staged # Format only the staged files.
]

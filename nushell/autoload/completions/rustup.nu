# Subcommands for rustup
def commands [] {
    let lines = ^rustup --help | lines

    # Start from 'Commands:' row and end with a blank row
    mut start_idx = 0
    mut end_idx = 0
    for $line in ($lines | enumerate) {
        if $line.item == 'Commands:' {
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

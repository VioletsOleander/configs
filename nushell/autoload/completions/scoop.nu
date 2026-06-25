# Subcommands for scoop
def commands [] {
    let lines = ^scoop help | lines

    # Start from the row after '-------' and end with a blank row
    mut start_idx = 0
    mut end_idx = 0
    for $line in ($lines | enumerate) {
        if ($line.item | str starts-with '-------') {
            $start_idx = $line.index + 1
        }
        if $start_idx > 0 and ($line.item | str trim) == '' {
            $end_idx = $line.index - 1
            break
        }
    }

    $lines
    | slice $start_idx..$end_idx
    | parse --regex '(?<value>\S+)\s+(?<description>.+)'
}

export extern main [
    command?: string@commands
]

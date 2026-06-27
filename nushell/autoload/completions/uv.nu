# Subcommands for uv
def commands [] {
    let lines = ^uv help --color never | lines

    # Start from the row after 'Commands:' and end with a blank row
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

export extern 'uv add' [
    --dev # Add the requirements to the development dependency group [env: UV_DEV=].
    --upgrade (-U) # Allow package upgrades, ignoring pinned versions in any existing output file. Implies `--refresh`.
]

export extern 'uv remove' [
    --dev # Remove the packages from the development dependency group [env: UV_DEV=]
]

# Subcommands for cargo
def commands [] {
    ^cargo --list --color never
    | lines
    | parse --regex '\s+(?<value>\S+)\s+(?<description>.+)'
}

export extern main [
    --version (-V)
    --list # List installed commands.
    --explain # Provide a detailed explanation of a rustc error message.
    command?: string@commands
]

export extern 'cargo add' [
    --features (-F): string # Space or comma separated list of features to activate.
    --dry-run (-n) # Don't actually write the manifest.
]

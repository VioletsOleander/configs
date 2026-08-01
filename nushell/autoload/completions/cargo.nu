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
    --dev # Add as development dependency.
    --no-default-features # Disable the default features.
    --default-features # Re-enable the default features
]

export extern 'cargo install' [
    --path: path # Filesystem path to local crate to install from.
    --list # List all installed packages and their versions.
]

export extern 'cargo clean' [
    --doc # Whether or not to clean just the documentation directory.
    --dry-run (-n) # Display what would be deleted without deleting anything.
    --verbose (-v) # Use verbose output (-vv very verbose/build.rs output).
]

export extern 'cargo doc' [
    --open # Opens the docs in a browser after building pacakge's documentation.
]

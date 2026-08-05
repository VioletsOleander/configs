use _utils.nu filter-block

# Subcommands for uv
def commands [] {
    ^uv help --color never
    | lines
    | filter-block 'Commands:'
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

export extern 'uv version' [
    --bump: string@['major' 'minor' 'patch' 'stable' 'alpha' 'beta' 'rc' 'post' dev] # Update the project version using the given semantics.
    --dry-run # Don't write a new version to the `pyproject.toml`.
    --short # Only show the version
]

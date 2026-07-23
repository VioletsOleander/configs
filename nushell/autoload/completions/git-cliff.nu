export extern main [
    --unreleased (-u) # Processes the commits that do not belong to a tag.
    --bump: string@['auto' 'major' 'minor' 'patch'] # Bumps the version for unreleased changes.
]

# Create a new pull request with HEAD
#
# The pull request title will be the the commit message title of HEAD, and description will be the commit message body
# of HEAD
export def new-pull-request [] {
    gh pr new --title (git log -1 --format=%s) --body (git log -1 --format=%b)
}

# Create a new branch on HEAD
#
# The branch name will be <name> appended with unique timestamp
export def new-branch [name: string] {
    let timestamp = date now | format date "%Y%m%d-%H%M%S"
    let branch = $name + "/" + $timestamp

    git switch --create $branch
}

export alias new-pr = new-pull-request
export alias new-b = new-branch

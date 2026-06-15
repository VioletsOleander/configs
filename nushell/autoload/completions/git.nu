# Tips: Do not add `--help` flag, since it will let nushell take over the help display

# A problem is that non-defined extern will use the completer of `git` for completion

const state_descriptions = [
    {state: ' [A]', desc: 'Not updated'} # use [A] instead of [AMD] here, since [MD] case is covered by later states
    {state: 'M[ MTD]', desc: 'Updated in index'}
    {state: 'T[ MTD]', desc: 'Type changed in index'}
    {state: 'A[ MTD]', desc: 'Added to index'}
    {state: 'D ', desc: 'Deleted from index'}
    {state: 'R[ MTD]', desc: 'Renamed in index'}
    {state: 'C[ MTD]', desc: 'Copied in index'}
    {state: '[MTARC] ', desc: 'Index and work tree matches'}
    {state: '[ MTARC]M', desc: 'Modified but not staged'} # Work changed since index
    {state: '[ MTARC]T', desc: 'Type changed in work tree since index'}
    {state: '[ MTARC]D', desc: 'Deleted in work tree'}
    {state: ' R', desc: 'Renamed in work tree'}
    {state: ' C', desc: 'Copied in work tree'}
    {state: 'DD', desc: 'Unmerged, both delted'}
    {state: 'AU', desc: 'Unmerged, added by us'}
    {state: 'UD', desc: 'Unmerged, deleted by them'}
    {state: 'UA', desc: 'Unmerged, added by them'}
    {state: 'DU', desc: 'Unmerged, deleted by us'}
    {state: 'AA', desc: 'Unmerged, both added'}
    {state: 'UU', desc: 'Unmerged, both modified'}
    {state: '\?\?', desc: 'Untracked'}
    {state: '!!', desc: 'Ignored'}
]

const diffstate_descriptions = {
    "A": "Added"
    "C": "Copied"
    "M": "Modified"
    "D": "Deleted"
    "R": "Renamed"
}

# Subcommands for git
def commands [] {
    ^git help --all
    | lines
    | where {|line| $line | str starts-with "   " }
    | parse --regex '\s+(?<value>\w+)\s+(?<description>.+)'
}

# Files in current working directory
def files [] {
    ^git status -u --porcelain=1
    | lines
    | parse --regex '(?<state>[ MTADRCU?!]{2}) (?<value>.+)'
    | insert "description" {|line| $state_descriptions | where {|it| $line.state like $it.state} | get 0.desc}
}

# Files changed
def diff-files [context: string] {
    let segments = $context | split row " "
    let entries = if ("--cached" in $segments) or ("--staged" in $segments) {
        ^git diff --cached --name-status
    } else {
        ^git diff --name-status
    }

    $entries
    | lines
    | parse --regex '(?<state>[ACDMRTUXB])\s+(?<value>.+)'
    | update "value" {|row| $'`($row.value)`' }
    | insert "description" {|row| $diffstate_descriptions | get $row.state}
}

# Branches in current repository
def branches [context: string] {
    let segments = $context | split row " "
    let branches = if ("-r" in $segments) or ("--remotes" in $segments) {
        ^git branch --list --remotes --format='%(refname:lstrip=2)'
    } else {
        ^git branch --list --format='%(refname:lstrip=2)'
    }

    $branches | lines
}

# Subcommands for git config
def config-commands [] {
    [
        {value: "list", description: "List all variables set in config file, along with their values."}
        {value: "get", description: "Emits the value of the specified key."}
        {value: "set", description: "Set value for one or more config options."}
        {value: "unset", description: "Unset value for one or more config options."}
    ]
}

export extern main [
    --version (-v)
    command?: string@commands 
]

export extern "git add" [
    --all (-A) # Add changes from all tracked and untracked files.
    --dry-run (-n) 
    --verbose (-v)
    ...pathspec: path@files 
]

export extern "git branch" [
    --delete (-d) # Delete a branch.
    -D # Shortcut for --delete --force.
    --copy (-c) # Copy a branch, together with its config and reflog.
    -C # Shortcut for --copy --force
    --force (-f) # Reset <branch-name> to <start-point>, even if <branch-name> exists already.  In combination with -d (or --delete), allow deleting the branch irrespective of its merged status.
    --list (-l) # List branches.
    --remotes (-r) # List or delete (if used with -d) the remote-tracking branches.
    --all (-a) # List both remote-tracking branches and local branches.
    ...branch: string@branches
]

export extern "git switch" [
    --create (-c): string # Create a new branch named <new-branch> starting at current branch.
    --force (-f) # An alias for --discard-changes
    --discard-changes # Proceed even if the index or the working tree differs from HEAD.
    branch?: string@branches 
]

export extern "git diff" [
    --name-only # Show only the name of each changed file in the post-image tree.
    --name-status # Show only the name(s) and status of each changed file. 
    --cached # Compare index to HEAD.
    --staged # Synonym of --cached.
    ...pathspec: path@diff-files
]

export extern "git commit" [
    --message (-m): string # Use <msg> as the commit message. If multiple -m options are given, their values are concatenated as separate paragraphs.
    --amend # Replace the tip of the current branch by creating a new commit. 
    --edit (-e) # Let the user further edit the message taken from <file> with -F <file>, command line with -m <message>, and from <commit> with -C <commit>.
    --no-edit # Use the selected commit message without launching an editor.
    --no-verify (-n) # Bypass the pre-commit and commit-msg hooks.
    --allow-empty
]

export extern "git push" [
    --prune # Remove remote branches that don’t have a local counterpart. 
    --delete (-d) # All listed refs are deleted from the remote repository.
    --force (-f) 
    --set-upstream (-u) # For every branch that is up to date or successfully pushed, add upstream (tracking) reference, used by argument-less git-pull[1] and other commands. 
]

export extern "git pull" [
    --prune (-p) # Before fetching, remove any remote-tracking references that no longer exist on the remote. 
    --depth: int # Limit fetching to the specified number of commits from the tip of each remote branch history.
    --dry-run
]

export extern "git config" [
    --local # Write to or read from local .git/config file. This is the default behaviour.
    --global # Write to or read from global ~/.gitconfig file.
    command?: string@config-commands
]

export extern "git status" [
    --untracked-files (-u) # Show untracked files and individual files in untracked directories.
    --short (-s) # Give the output in the short-format.
    --verbose (-v) # In addition to the names of files that have been changed, also show the textual changes that are staged to be committed.
]

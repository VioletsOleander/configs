use completions\git.nu *
use completions\cargo.nu *
use completions\rustup.nu *
use completions\uv.nu *
use completions\rg.nu *
use completions\eza.nu *
use completions\vivid.nu *
use completions\dprint.nu *
use completions\gh.nu *
use completions\curl.nu *

const package_manager = if $nu.os-info.name == 'windows' { 'completions\scoop.nu' } else { null }
use $package_manager *

# Since autoload is executed after loading config.nu, some aliases should be put here for completions

alias g = git

alias "g s" = git status
alias 'g c' = git commit
alias 'g a' = git add
alias 'g p' = git push
alias 'g d' = git diff
alias 'g sw' = git switch
alias 'g b' = git branch
alias 'g bd' = git branch -D
alias 'g bdr' = git branch -D --remotes
alias 'g restore' = git restore

alias gs = git status
alias gc = git commit
alias ga = git add
alias gp = git push
alias gd = git diff
alias gsw = git switch
alias gb = git branch
alias gbd = git branch -D
alias gbdr = git branch -D --remotes

alias ez = eza

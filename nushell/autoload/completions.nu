use completions\git.nu *

# Since autoload is executed after loading config.nu, some aliases should be put here for completions

alias g = git

alias "git s" = git status
alias 'git c' = git commit
alias 'git a' = git add
alias 'git p' = git push
alias 'git d' = git diff
alias 'git b' = git branch
alias 'git bd' = git branch -D
alias 'git bdr' = git branch -D --remotes
alias 'git sw' = git switch

alias "g s" = git status
alias 'g c' = git commit
alias 'g a' = git add
alias 'g p' = git push
alias 'g d' = git diff
alias 'g b' = git branch
alias 'g bd' = git branch -D
alias 'g bdr' = git branch -D --remotes
alias 'g sw' = git switch

alias gs = git status
alias gc = git commit
alias ga = git add
alias gp = git push
alias gd = git diff

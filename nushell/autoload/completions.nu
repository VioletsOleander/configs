use completions\git.nu *

# Since autoload is executed after loading config.nu, some aliases should be put here for completions

alias g = git

alias 'git c' = git commit
alias 'git a' = git add
alias 'git b' = git branch
alias 'git bd' = git branch -D
alias 'git bdr' = git branch -D --remotes
alias 'git sw' = git switch

alias 'g c' = git commit
alias 'g a' = git add
alias 'g b' = git branch
alias 'g bd' = git branch -D
alias 'g bdr' = git branch -D --remotes
alias 'g sw' = git switch

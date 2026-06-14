use completions\git.nu *

# Since autoload is executed after loading config.nu, some aliases should be put here for completions

alias g = git
alias 'g a' = git add
alias 'g b' = git branch
alias 'g bd' = git branch -D
alias 'g bdr' = git branch -D --remotes
alias 'g sw' = git switch

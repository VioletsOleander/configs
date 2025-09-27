# source the global configuration
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# alias
alias ls='ls --color=auto'
alias ll='ls -al'
alias df='df -h'
alias du='du -h'
alias cls=clear
alias vi=vim

# functions
cl() {
    cd "$1" && ll
}

# environment variables
export CURRENT_UID=$(id -u)
export CURRENT_GID=$(id -g)
export CURRENT_NAME=$(whoami)
export CURRENT_GROUPS=$(groups)
export EDITOR=vim

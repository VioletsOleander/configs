# Equivalent to cd then ls
export def --env cl [p: path = "~"] {
    cd $p
    ls
}

# Equivalent to z then ls
export def --env zl [p: path = "~"] {
    __zoxide_z $p
    ls
}

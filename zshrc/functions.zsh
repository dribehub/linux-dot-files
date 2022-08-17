#!/bin/zsh

#======================== USER-DEFINED FUNCTIONS ========================#

h () { # Show 10 (or more) most recent executed commands
    history -"${1:-10}" | less
}

cdls () { # Navigate inside a directory and list its contents
    cd "$1" && ls -l
}

mkcd () { # Create a directory and navigate inside it
    mkdir -p -- "$1" && cd -P -- "$1"
}

rmcd () { # Delete current directory
    DIR_PATH=$(pwd) && cd -P .. && sudo rm -r "$DIR_PATH"
}

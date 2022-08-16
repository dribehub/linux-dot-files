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

uc () { # Parse unicodes to glyphs
    echo "\u$1" && echo -ne "\u$1" | xclip -selection clipboard
}

ddg () { # DuckDuckGo search
    URL="https://www.duckduckgo.com/"
    [[ $1 ]] && URL="$URL""?q=${@}&ia=web"
    $BROWSER "$URL"
}

reddit () { # Reddit search
    URL="https://www.reddit.com/"
    if [[ $1 ]]; then
        if [[ "$1" == r/* ]]; then
            URL="$URL""$1"
            if [[ $2 ]]; then
                shift
                URL="${URL}/search/?q=${@}&restrict_sr=1"
            fi
        else
            URL="${URL}search/?q=${@}"
        fi
    fi
    $BROWSER "$URL"
}

wiki () { # Wikipedia search
    ddg "\!w ${@}"
}

yaylink () { # Follow AUR upstream repo
    URL=$(yay -Si $1 | grep '^URL' | sed 's/.*: //')
    if [ ! "$URL" ]; then
        yay -Si $1
    else
        $BROWSER $URL
    fi
}

yaysort () { # Sort 10 (or more) most recent yay packages installed
    OUTPUT=$(expac -t "%Y-%m-%d %T" "%l\t%n" | sort | tail -n "${1:-10}")
    OUTPUT=("${(s/ /)OUTPUT}")
      # print "number of packages: ${#OUTPUT[@]}\n" | less
      # for i in $OUTPUT; do
      #
      # done
      # print -P "%F{5}$OUTPUT[1] %F{6}$OUTPUT[2] %F{7}$OUTPUT[3]"
    print $OUTPUT | less
}

extract () { # Extract compressed files
    if [ -f $1 ]; then
        case $1 in
            *.tar)      sudo tar xf $1;;
            *.tar.bz2)  sudo tar xjf $1;;
            *.tbz2)     sudo tar xjf $1;;
            *.tar.gz)   sudo tar xzf $1;;
            *.tgz)      sudo tar xzf $1;;
            *.bz2)      sudo bunzip2 $1;;
            *.gz)       sudo gunzip $1;;
            *.7z)       sudo 7z x $1;;
            *.Z)        sudo uncompress $1;;
            *.rar)      sudo unrar x $1;;
            *.zip)      sudo unzip $1;;
            *)          print -P "Invalid format: %F{9}.$(echo "${1##*\.}")";;
        esac
    else
        print -P "Could not find file: %F{9}$1"
    fi
}


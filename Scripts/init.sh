#!/bin/sh

#============================= FUNCTIONS =============================#

is_open() { # params: <application>
    [ -n "$(wmctrl -l | grep -i $1)" ]
}

desktop() { # params: (0|1|2|3|4)
    wmctrl -s $1
    # wait until you're at the specified desktop
    while [ ! -n "$(wmctrl -d | grep $1'  \*')" ]; do sleep 0.1; done
}

open() { # params: (cava|cmus|spotify|firefox)
    case $1 in
        cava) echo "xfce4-terminal --geometry 80x10+40+150 -x cava";;
        cmus) echo "xfce4-terminal --geometry 80x25+40+400 -x cmus";;
        spotify) echo "spotify";; #echo "LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify";;
        firefox) echo "firefox";;
    esac
}

resize() { # params: <application>, x, y, width, height
    wmctrl -r $1 -e 0,$2,$3,$4,$5 
}

launch() { # params: (cava|cmus|spotify|firefox)
    is_open $1 && return # if some instance is running, terminate
    $(open $1) & # else launch a new instance
    while ! is_open $1; do sleep 0.1; done # wait until it's opened
}

#=============================== SCRIPT ===============================#

sleep 2;
desktop 1 && 
    launch cava && 
    launch cmus && 
    launch spotify >/dev/null 2>&1 && 
    resize spotify 800 149 1093 755;
desktop 0 && 
    launch firefox >/dev/null 2>&1;

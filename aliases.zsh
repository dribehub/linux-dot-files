#!/bin/zsh

# general
alias   aliases="$EDITOR $ZSHRC/aliases.zsh"
alias      funx="$EDITOR $ZSHRC/functions.zsh"
alias  funstuff="$EDITOR $ZSHRC/fun-stuff.zsh"
alias     zshrc="$EDITOR $HOME/.zshrc"
alias      home="cd $HOME"
alias      back="cdls .."
alias       cat="bat -p --theme=ansi"
alias       top="gotop"
alias  yaystats="yay -Ps"
alias      idea="/opt/idea-IC-212.5457.46/bin/idea.sh"
alias    refnet="nmcli d connect wlp2s0 >/dev/null" # "nmcli c up EREMITI"
alias scrotwind="scrot '$HOME/Desktop/%y-%m-%d-%H:%M:%S.png' -shole"
alias    extend="xrandr --output eDP-1 --left-of HDMI-1"
alias duplicate="xrandr --output eDP-1 --same-as HDMI-1"

# default command options
alias       lsd="lsd --icon never" # -Al
alias        ls="lsd" # ls --color=auto
alias       lsl="ls -l"
alias      list="ls -Al"
alias      grep="grep --color=always"
alias       cli="xfce4-terminal"
alias        nf="neofetch-custom" # --backend off --col_offset 3
alias    tormix="transmission-daemon && tormix"
alias      ddgr="ddgr --colors mCmgxf --unsafe --noua -x"

# global pipe options
alias -g H="| head"
alias -g T="| tail"
alias -g G="| grep"
alias -g L="| less"
alias -g K="| lolcat"
alias -g C="| cowsay"
alias -g P="| pygmentize"
alias -g N=">/dev/null 2>&1"
alias -g Y="| xargs echo -n | xclip -selection c"
alias -g Yn="| xclip -selection c"
alias -g WC="| wc -l"

# fun stuff
alias        cv="cli --geometry 80x10+598+40 -x cava"
alias     music="cv && cmus"
alias      jrnl="jrnl --config-override editor 'vim'"
alias     clock="cli --geometry 39x9+10+10 -x tty-clock"
alias   weather="cli --geometry 125x41+400+150 -e 'bash -c \"wttr; read var\"'"
alias ibmvfetch="neofetch --ascii --source $HOME/Repos/ascii-art/neofetch/ibm-tp-v.txt --ascii_colors '7' '1' '2' '4'"
alias ibmhfetch="neofetch --ascii --source $HOME/Repos/ascii-art/neofetch/ibm-tp-h.txt --ascii_colors '7' '1' '2' '4'"
alias      runc="$EDITOR a.c && gcc a.c && ./a.out && rm a.c a.out"
alias      fwwm="echo -n \"^◇^\" | xclip -selection c"

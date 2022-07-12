#!/bin/zsh

# general
alias         v="$EDITOR"
alias      home="cd $HOME"
alias      back="cdls .."
alias       cat="bat -p --theme=ansi"
alias       top="gotop"
alias  yaystats="yay -Ps"
alias   storage="df -h"
alias    refnet="nmcli d connect wlp2s0 >/dev/null" # "nmcli c up EREMITI"
alias scrotwind="scrot '$HOME/Desktop/%y-%m-%d-%H:%M:%S.png' -shole"
alias    extend="xrandr --output eDP-1 --left-of HDMI-1"
alias duplicate="xrandr --output eDP-1 --same-as HDMI-1"

# vim shortcuts
alias   aliases="$EDITOR $ZSHRC/aliases.zsh"
alias      funx="$EDITOR $ZSHRC/functions.zsh"
alias  funstuff="$EDITOR $ZSHRC/cli-commands.sh"
alias     zshrc="$EDITOR $HOME/.zshrc"
alias     vimrc="$EDITOR $HOME/.vimrc"
alias awesomerc="$EDITOR $HOME/.config/awesome/rc.lua"
alias polybarrc="$EDITOR $HOME/.config/polybar/config.ini"

# default command options
alias        rm="rm -i"
alias       lsd="lsd --icon never" # -Al
alias        ls="lsd" # ls --color=auto
alias      list="ls -Al"
alias      grep="grep --color=always"
alias       cli="xfce4-terminal"
alias        nf="neofetch-custom" # --backend off --col_offset 3
alias    tormix="transmission-daemon && tormix"
alias      ddgr="ddgr --colors mCmgxf --unsafe --noua -x"
alias    wisdom="wisdom-tree"

# global pipe options
alias -g H="| head"
alias -g T="| tail"
alias -g S="| sort"
alias -g G="| grep"
alias -g Gi="| grep -i"
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

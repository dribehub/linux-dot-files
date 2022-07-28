#!/bin/zsh

# USER-DEFINED FUNCTIONS

h () {; history -"${1:-10}" | less ;}
edit () {; "${=EDITOR}" $1 ;}
cdls () {; cd "$1" && ls -l ;}
mkcd () {; mkdir -p -- "$1" && cd -P -- "$1" ;}
rmcd () {; DIR_PATH=$(pwd) && cd -P .. && rm -r "$DIR_PATH" ;}
#dl () {; transmission-cli -w $HOME/Videos $1 ;}
#pwd () {; ls -Ald ${1-PWD} ;}
wiki () {; ddg "\!w ${@}" ;}
uc () {; echo "\u$1" && echo -ne "\u$1" | xclip -selection clipboard ;}

yaylink () {
    URL=$(yay -Si $1 | grep '^URL' | sed 's/.*: //')
    if [ ! "$URL" ]; then
        yay -Si $1
    else
        $BROWSER $URL
    fi
}

reddit () {
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

ddg () {
  URL="https://www.duckduckgo.com/"
  [[ $1 ]] && URL="$URL""?q=${@}&ia=web"
  $BROWSER "$URL"
}

yaysort () {
  OUTPUT=$(expac -t "%Y-%m-%d %T" "%l\t%n" | sort | tail -n "${1:-10}")
  OUTPUT=("${(s/ /)OUTPUT}")
  # print "number of packages: ${#OUTPUT[@]}\n" | less
  # for i in $OUTPUT; do
  #
  # done
  # print -P "%F{5}$OUTPUT[1] %F{6}$OUTPUT[2] %F{7}$OUTPUT[3]"
  print $OUTPUT | less
}

extract () {
  if [ -f $1 ]; then
    case $1 in
      *.tar)      sudo tar xf      $1 ;;
      *.tar.bz2)  sudo tar xjf     $1 ;;
      *.tbz2)     sudo tar xjf     $1 ;;
      *.tar.gz)   sudo tar xzf     $1 ;;
      *.tgz)      sudo tar xzf     $1 ;;
      *.bz2)      sudo bunzip2     $1 ;;
      *.gz)       sudo gunzip      $1 ;;
      *.7z)       sudo 7z x        $1 ;;
      *.Z)        sudo uncompress  $1 ;;
      *.rar)      sudo unrar x     $1 ;;
      *.zip)      sudo unzip       $1 ;;
      *)          print -P "%F{5}'$1' %F{6}cannot be extracted via extract()" ;;
    esac
  else
    print -P "%F{5}'$1' %F{6}is not a valid file"
  fi
}

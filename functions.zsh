#!/bin/zsh

# USER-DEFINED FUNCTIONS

h () {; history -"${1:-10}" | less ;}
edit () {; "${=EDITOR}" $1 ;}
cdls () {; cd "$1" && ls -l ;}
mkcd () {; mkdir -p -- "$1" && cd -P -- "$1" ;}
rmcd () {; DIR_PATH=$(pwd) && cd -P .. && rm -r "$DIR_PATH" ;}
#tcl () {; print "$@" | trans -b | cowsay | lolcat ;}
#dl () {; transmission-cli -w /home/dribe/Videos $1 ;}
#pwd () {; ls -Ald ${1-PWD} ;}
wiki () {; ddg "\!w ${@}" ;}

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
  firefox "$URL"
}

ddg () {
  URL="https://www.duckduckgo.com/"
  [[ $1 ]] && URL="$URL""?q=${@}&ia=web"
  firefox "$URL"
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

wg () {
    echo "\n\t\t\t\tjanar" && wg1 $1 $2
    echo "\n\t\t\t\tprill" && wg2 $1 $2
}
wg1 () {; grep "$1 $2" /home/dribe/Documents/db/rrogat_janar_2021.csv ;}
wg2 () {; grep "$1 $2" /home/dribe/Documents/db/rrogat_prill_2021.csv ;}
tg () {; grep "$1,$2" /home/dribe/Documents/db/targat.csv ;}

spy () {
  ENT_COLOR="%F{3}" #yellow
  KEY_COLOR="%F{5}" #purple
  VAL_COLOR="%F{6}" #cyan
  FILE=/home/dribe/Documents/db/patronazh_2021.csv
  DATA=$(grep "$1,$2" "$FILE")
  VALUES=("${(@s/,/)DATA}")
  ENTRIES="${#VALUES[@]}"
  KEYS=("NID" "Emri" "Mbiemri" "Atesia" "Datelindja" "QV" "Lista Nr" "Tel"
        "Emigrant" "Vendi i Emigrimit" "I Sigurte" "Koment" "Patronazhisti"
        "Preferenca" "Census2013 Preferenca" "Census2013 Siguria" "Vendlindja"
        "Vendlindja" "Kompania" "Kodi i Baneses")
  if ((ENTRIES<=20)); then
    for i in {1..20}
      print -P "${KEY_COLOR}${KEYS[i]}: ${VAL_COLOR}${VALUES[i]}"
  else
    entryID=1
    for ((indexShift=0; indexShift<=ENTRIES; indexShift+=20)); do
      print -P "${ENT_COLOR}ENTRY $((entryID++)):"
      for i in {1..20}
        print -P "${KEY_COLOR}${KEYS[i]}: ${VAL_COLOR}${VALUES[i+indexShift]}"
    done
  fi
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

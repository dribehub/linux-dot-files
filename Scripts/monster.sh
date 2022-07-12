#/bin/sh

pctg() {
    printf "%.2f" $(echo "$1 * 100 / $2" | bc -l)
}

echo 'Monster Statistics'

if [ -d $HOME/Desktop/monster ]; then
    total=74
    remaining=$(ls -A $HOME/Desktop/monster | wc -l)
    remainingPctg=$(pctg $remaining $total)
    watched=$(( total - remaining ))
    watchedPctg=$(pctg $watched $total)
    echo "Total: $total series"
    echo "Watched: $watched series ($watchedPctg%)"
    echo "Remaining: $remaining series ($remainingPctg%)"
else
    echo "You've already finished it!"
fi

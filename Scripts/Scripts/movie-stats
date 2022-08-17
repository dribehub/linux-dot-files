#/bin/sh

pctg() {
    printf "%.2f" $(echo "$1 * 100 / $2" | bc -l)
}

DIR=$HOME/Videos/some-movie-series
TOTAL=74

echo '<some-movie-series> Statistics'

if [ -d $DIR ]; then
    remaining=$(ls -A $DIR | wc -l)
    remainingPctg=$(pctg $remaining $TOTAL)
    watched=$(( TOTAL - remaining ))
    watchedPctg=$(pctg $watched $TOTAL)
    echo "Total: $TOTAL series"
    echo "Watched: $watched series ($watchedPctg%)"
    echo "Remaining: $remaining series ($remainingPctg%)"
else
    echo "You've already finished it!"
fi

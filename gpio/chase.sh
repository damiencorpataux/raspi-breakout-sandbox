#!/bin/sh

PINS=$2
DELAY=$1

if [ -z "$2" ]; then
    echo "Chaser on the given GPIO pin(s) value with delay (seconds)"
    echo "$0 <delay> \"<pin-number-1> <pin-number-2> ... <pin-number-n>\""
else
    while [ true ]; do
        for N in $PINS; do
            # All to off
            ./set.sh "$PINS" 0
            # Enable next pin
            ./set.sh $N 1
            # Waits a little
            sleep $DELAY
        done
    done
fi

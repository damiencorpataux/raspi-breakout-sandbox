#!/bin/sh

if [ -z "$2" ]; then
    echo "Sets GPIO pin(s) value"
    echo "$0 <pin-number> <value> OR"
    echo "$0 \"<pin-number-1> <pin-number-2> ... <pin-number-n>\" <value>"
else
    for N in $1; do
	    # Sets GPIO pin to output, if necessary
        DIR=$(cat /sys/class/gpio/gpio$N/direction)
        if [ -z "$DIR" ] || [ "$DIR" != "out" ]; then
            echo "Setting pin $N to ouput"
		    echo $N > /sys/class/gpio/export
		    echo out > /sys/class/gpio/gpio$N/direction
        fi
	    # Sets actual pin value
	    echo $2 > /sys/class/gpio/gpio$N/value
	    #sleep 0.01
    done
fi

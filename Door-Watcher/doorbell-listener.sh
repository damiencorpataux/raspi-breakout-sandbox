#!/bin/bash

pin=10 # GPIO pin
path=/root/motion-storage/events/doorbell # Path to save images to
delay=0.5 # Delay between bell checks

# Tests for output path writable
while [ ! -w $path ]; do
    echo "Error: output path does not exit or is not writable, retrying ($path)"
    sleep 10
done

# Setups gpio pin
echo $pin > /sys/class/gpio/export
echo in > /sys/class/gpio/gpio$pin/direction

# Polls doorbell
echo "Starting doorbell polling, every ${delay}s on gpio $pin..."
while true; do
    value=`cat /sys/class/gpio/gpio$pin/value`
    if [ $value == 1 ]; then
        file="$path/`date +'%Y-%m-%d %H-%M-%S'`.jpg"
        echo "Ring `date +'on %d.%m.%Y at %H:%M:%S'`, saving snapshot in $file"
        curl -s http://localhost:8080?action=snapshot > "$file"
    fi
    sleep $delay
done

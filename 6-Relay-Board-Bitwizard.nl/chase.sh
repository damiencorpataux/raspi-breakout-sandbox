#!/bin/bash

# Chases the bitwizard.nl big relay board (address 0x4e)
while [ true ];
	do for N in 1 2 4 8 16 32 63; do
		echo -ne "$N,";
		i2cset -y 0 0x4e 0x10 $N;
		sleep 0.5;
	done; 
done;

#!/bin/bash


# reloads every 10m 
# opens a new email into new tab every 10 time reloaded.
c=1

while [ 1 ]
do
	# delay time.
	# chang this accordingly
	sleep 600
	c=$(( $c + 1 ))
	if [ $c -eq 10 ]
	then
	
		xdotool mousemove 500 500 click 5
		xdotool keydown ctrl
		xdotool click 1
		xdotool keyup ctrl	
		sleep 10

		c=1
	else	
		xdotool key F5
		sleep 5
		xdotool key Return

	fi
done

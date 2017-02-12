#!/bin/bash 

FWD_TIME=15
BWD_TIME=15
R_TURN_TIME=15
L_TURN_TIME=15
FWD_R_TIME=15
FWD_L_TIME=15
BWD_R_TIME=15
BWD_L_TIME=15

while true; do

	SECONDS=0
	echo "Testing driving forward for $FWD_TIME seconds"
	rostopic pub /cmd_vel geometry_msgs/Twist -r 1 -- '[1.0, 0.0, 0.0]' '[0.0, 0.0, 0.0]' &
	PID=$!
	while [  $SECONDS -lt $FWD_TIME ]; do
		echo "$SECONDS..."
		sleep 1	
	done
	kill -9 $PID
	echo "Done."

	SECONDS=0
	echo "Testing driving backwards for $BWD_TIME seconds"
	rostopic pub /cmd_vel geometry_msgs/Twist -r 1 -- '[-1.0, 0.0, 0.0]' '[0.0, 0.0, 0.0]' &
	PID=$!
	while [  $SECONDS -lt $BWD_TIME ]; do
		echo "$SECONDS..."
		sleep 1	
	done
	kill -9 $PID
	echo "Done."

	SECONDS=0
	echo "Testing right turn for $R_TURN_TIME seconds"
	rostopic pub /cmd_vel geometry_msgs/Twist -r 1 -- '[0.0, 0.0, 0.0]' '[0.0, 0.0, 1.0]' &
	PID=$!
	while [  $SECONDS -lt $R_TURN_TIME ]; do
		echo "$SECONDS..."
		sleep 1	
	done
	kill -9 $PID
	echo "Done."

	SECONDS=0
	echo "Testing left turn for $L_TURN_TIME seconds"
	rostopic pub /cmd_vel geometry_msgs/Twist -r 1 -- '[0.0, 0.0, 0.0]' '[0.0, 0.0, -1.0]' &
	PID=$!
	while [  $SECONDS -lt $L_TURN_TIME ]; do
		echo "$SECONDS..."
		sleep 1	
	done
	kill -9 $PID
	echo "Done."

	SECONDS=0
	echo "Testing driving forward and right for $FWD_R_TIME seconds"
	rostopic pub /cmd_vel geometry_msgs/Twist -r 1 -- '[1.0, 0.0, 0.0]' '[0.0, 0.0, 1.0]' &
	PID=$!
	while [  $SECONDS -lt $FWD_R_TIME ]; do
		echo "$SECONDS..."
		sleep 1	
	done
	kill -9 $PID
	echo "Done."

	SECONDS=0
	echo "Testing driving forward and left for $FWD_L_TIME seconds"
	rostopic pub /cmd_vel geometry_msgs/Twist -r 1 -- '[1.0, 0.0, 0.0]' '[0.0, 0.0, -1.0]' &
	PID=$!
	while [  $SECONDS -lt $FWD_L_TIME ]; do
		echo "$SECONDS..."
		sleep 1	
	done
	kill -9 $PID
	echo "Done."

	SECONDS=0
	echo "Testing driving backward and right for $BWD_R_TIME seconds"
	rostopic pub /cmd_vel geometry_msgs/Twist -r 1 -- '[-1.0, 0.0, 0.0]' '[0.0, 0.0, 1.0]' &
	PID=$!
	while [  $SECONDS -lt $BWD_R_TIME ]; do
		echo "$SECONDS..."
		sleep 1	
	done
	kill -9 $PID
	echo "Done."

	SECONDS=0
	echo "Testing driving backward and left for $BWD_L_TIME seconds"
	rostopic pub /cmd_vel geometry_msgs/Twist -r 1 -- '[-1.0, 0.0, 0.0]' '[0.0, 0.0, -1.0]' &
	PID=$!
	while [  $SECONDS -lt $BWD_L_TIME ]; do
		echo "$SECONDS..."
		sleep 1	
	done
	kill -9 $PID
	echo "Done."
done

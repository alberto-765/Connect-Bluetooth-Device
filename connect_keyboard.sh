#!/bin/bash

# Log file
LOG_FILE="$HOME/.local/state/connect_keyboard/$(date +%Y-%m-%d).log"

echo $LOG_FILE

# We verify bluetooth is activated
if bluetoothctl show | grep -q "Powered: yes"; then
	echo "Bluetooth activated. Trying yo connect to the keyboard..." >> $LOG_FILE
	MAC=""
	INFO=$(bluetoothctl info $MAC)
	
	# Trust, connect and pair device
	if echo $INFO | grep -q "Bonded: yes"; then
		echo "Keyboard is already bonded, we can try connection" >> $LOG_FILE

		if echo $INFO | grep -q "Connected: no"; then
			echo "Connecting to the device: $MAC" >> $LOG_FILE
			bluetoothctl connect $MAC
		fi
	else
		# Remove device because it could be connected but not  bunded, and we wont be able to use it
		echo "Removing device if exists" >> $LOG_FILE
		bluetoothctl untrust $MAC && bluetoothctl remove $MAC

		echo "Scanning devices" >> $LOG_FILE
		bluetoothctl scan on & sleep 5; kill $!  # Scan just 5 seconds

		# 1. Pair  2.Connect  3.Trust/Save
		bluetoothctl pair $MAC
		bluetoothctl connect $MAC
		bluetoothctl trust $MAC
	fi

else
	echo "Bluetooth not activated" >> $LOG_FILE
fi 

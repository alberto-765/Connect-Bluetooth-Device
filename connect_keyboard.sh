#!/bin/bash

# We verify bluetooth is activated
if bluetoothctl show | grep -q "Powered: yes"; then
	echo "Bluetooth activated. Trying yo connect to the keyboard..."
	MAC=""
	INFO=$(bluetoothctl info $MAC)
	
	# Trust, connect and pair device
	if echo $INFO | grep -q "Bonded: yes"; then
		echo "Keyboard is already bonded, we can try connection"
		if echo $INFO | grep -q "Connected: no"; then
			echo "Connecting to the device: $MAC"
			bluetoothctl connect $MAC
		fi
	else
		# Remove device because it could be connected but not  bunded, and we wont be able to use it
		echo "Removing device if exists"
		bluetoothctl untrust $MAC && bluetoothctl remove $MAC

		echo "Scanning devices"
		bluetoothctl scan on & sleep 5; kill $!  # Scan just 5 seconds

		# 1. Pair  2.Connect  3.Trust/Save
		bluetoothctl pair $MAC
		bluetoothctl connect $MAC
		bluetoothctl trust $MAC
	fi

else
	echo "Bluetooth not activated"
fi 

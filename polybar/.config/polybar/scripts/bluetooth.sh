#!/bin/sh
toggle() {
	if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]; then
		bluetoothctl power on
	else
		bluetoothctl power off
	fi
}

show() {
	# Check if Bluetooth is powered on
	if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]; then
		echo "%{F#66ffffff}" # Bluetooth is off (gray icon)
		exit 0
	fi

	# Get connected device MAC address
	device_mac=$(bluetoothctl info | grep "Device" | awk '{print $2}')

	if [ -z "$device_mac" ]; then
		echo "" # No connected device
		exit 0
	fi

	# Get battery level of the connected device
	battery_level=$(bluetoothctl info "$device_mac" | grep "Battery Percentage" | awk '{print $4}')

	# Display the Bluetooth icon with the battery percentage
	if [ -n "$battery_level" ]; then
		echo "%{F#2193ff} $battery_level%" # Bluetooth on, device connected, show battery
	else
		echo "%{F#2193ff}" # Bluetooth on, device connected, but no battery info available
	fi

}

#!/bin/bash

# Check if adb is installed, if not install it  
if ! [ -x "$(command -v adb)" ]; then
  echo "adb is not installed."
  exit 1
fi

# Kill adb server to reset connections
adb kill-server

# Start adb server
adb start-server

# Connect to the first device attached through USB
# or emulator running
device=$(adb devices | grep -v "List" | grep "device" | awk '{print $1}')

if [ -z "$device" ]; then
  echo "No devices attached"
  exit 1
fi

# Restart adbd on device in case connection is stuck
adb -s $device root &> /dev/null
adb -s $device remount &> /dev/null  
adb -s $device reboot &> /dev/null

# Wait for device to reconnect 
echo "Waiting for device..."
while [ -z "$(adb get-state)" ]; do
  sleep 0.5
done  

echo "Device connected!"

# Print serial number and list of devices
serial=$(adb -s $device get-serialno)
echo "Serial number: $serial"
adb devices

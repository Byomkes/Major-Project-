#!/bin/bash

# Specify the ADB server host and port (default is "localhost" and 5037)
adb_host="localhost"
adb_port="5037"

# List connected devices
devices=$(adb -H $adb_host -P $adb_port devices)

if [[ -z "$devices" ]]; then
    echo "No connected devices found."
else
    # Get the first connected device
    device=$(echo "$devices" | grep -oP '^\S+')
    
    # Example: Print the device serial number
    echo "Connected to device: $device"

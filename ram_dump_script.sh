#!/bin/bash

# List connected devices
devices=$(adb -H $adb_host -P $adb_port devices)

if [[ -z "$devices" ]]; then
    echo "No connected devices found."
else
    # Get the first connected device
    device=$(echo "$devices" | grep -oP '^\S+')
    
    # Example: Print the device serial number
    echo "Connected to device: $device"

    # Create a directory for storing the RAM dump
    dump_dir="ram_dump_$(date +%Y%m%d_%H%M%S)"
    mkdir "$dump_dir"

    # Capture the RAM dump using adb pull
    adb -H $adb_host -P $adb_port -s $device pull /proc/self/mem "$dump_dir/mem_dump"
    
    # Check if the RAM dump was successfully captured
    if [[ $? -eq 0 ]]; then
        echo "RAM dump collected successfully. Directory: $dump_dir"
    else
        echo "Failed to collect RAM dump."
    fi
fi

#!/bin/bash

# Set backup path on device
backup_path=/sdcard/imei

# Clear old backup 
adb shell "rm -rf $backup_path"

# Create backup directory
adb shell "mkdir $backup_path"

# Get IMEI number using service call
adb shell "service call iphonesubinfo 1 > $backup_path/imei.txt"

# Pull IMEI file from device
adb pull $backup_path/imei.txt ./imei.txt

# Print confirmation
echo "IMEI number:"
cat imei.txt

# Alternative without service call
# adb shell "dumpsys iphonesubinfo | grep Device"

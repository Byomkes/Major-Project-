#!/bin/bash

# Set backup path on device 
backup_path=/sdcard/sim_data

# Clear old backup
adb shell "rm -rf $backup_path"

# Create backup directory 
adb shell "mkdir $backup_path"

# Get SIM card status
adb shell "service call iphonesubinfo 1 > $backup_path/sim_status.txt"

# Get SIM serial number  
adb shell "service call iphonesubinfo 3 > $backup_path/sim_serial.txt"

# Get number of active SIM cards
adb shell "service call iphonesubinfo 10 > $backup_path/sim_count.txt"

# Get subscriber ID 
adb shell "service call iphonesubinfo 11 > $backup_path/subscriber_id.txt"

# Pull SIM data from device
adb pull $backup_path ./sim_data

# Print confirmation
echo "SIM data pulled:"
ls -l ./sim_data

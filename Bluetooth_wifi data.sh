#!/bin/bash

# Set backup path on device
backup_path=/sdcard/network_data

# Clear old backup 
adb shell "rm -rf $backup_path"

# Create backup directory
adb shell "mkdir $backup_path"

# Collect wifi connection history
adb shell "dumpsys wifi > $backup_path/wifi_history.txt"

# Collect wifi hotspot history
adb shell "dumpsys wifi | grep -A 20 Wi-FiHotspotStateMachine > $backup_path/hotspot_history.txt"

# Collect bluetooth history
adb shell "dumpsys bluetooth_manager > $backup_path/bluetooth_history.txt" 

# Pull data from device
adb pull $backup_path ./network_data      

# Clear backup   
adb shell "rm -r $backup_path"

# Print confirmation
echo "Network data pulled:"  
ls -l network_data

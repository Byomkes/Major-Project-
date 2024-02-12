#!/bin/bash

# Set backup path on device
backup_path=/sdcard/auth_data

# Clear old backup  
adb shell "rm -rf $backup_path"

# Create backup directory
adb shell "mkdir $backup_path"

# Dump account manager details
adb shell "dumpsys account > $backup_path/account_manager.txt"

# Backup locksettings database 
adb shell "cp /data/system/locksettings.db $backup_path/"

# Backup gesture.key file containing lock pattern  
adb shell "cp /data/system/gesture.key $backup_path/" 

# Pull authentication data from device
adb pull $backup_path ./auth_data  

# Print confirmation  
echo "Authentication data pulled:"
ls -l ./auth_data/ 

# Decode lock pattern (if pattern lock is set)
# Use https://github.com/sch3m4/androidpatternlock

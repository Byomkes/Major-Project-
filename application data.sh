#!/bin/bash

# Set backup path on device 
backup_path=/sdcard/app_backup

# Clear old backup
adb shell "rm -rf $backup_path"

# Create backup directory
adb shell "mkdir $backup_path"

# Fetch all apps info using package manager 
adb shell "pm list packages -f > $backup_path/app_list.txt"

# Pull app info file from device
adb pull $backup_path/app_list.txt ./app_list.txt  

# Print confirmation
echo "Application list file pulled:" 
ls -l ./app_list.txt

# Process app list and extract package ID and vendor for each app
echo "packageName,vendor" > app_details.csv
while read -r line; do
  pkg=$(echo "$line" | awk -F":" '{print $1" "$2}' | awk '{print $2}')
  vendor=$(echo "$line" | awk -F"=" '{print $2}')
  echo "$pkg,$vendor"  
done < app_list.txt >> app_details.csv

# Print confirmation
echo "Application details extracted to CSV:"
ls -l app_details.csv

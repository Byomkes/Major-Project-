#!/bin/bash

# Set backup path on device
backup_path=/sdcard/app_backup

# API key for VirusTotal 
api_key=<your_virustotal_api_key>

# Clear old backup
adb shell "rm -rf $backup_path" 

# Create backup directory 
adb shell "mkdir $backup_path"

# List all user installed packages
adb shell "pm list packages -f -3 > $backup_path/apps.txt"

# Pull app list
adb pull $backup_path/apps.txt apps.txt

# Loop through each package 
while read -r pkg; do
  path=$(echo $pkg | awk -F "=" '{print $2"/"$2".apk"}' | awk -F ":" '{print $1}')
  
  # Pull APK from device
  adb pull $path ./

  # Scan with VirusTotal
  response=$(curl -s --upload-file $path https://www.virustotal.com/vtapi/v2/file/scan --header "X-Apikey: $api_key")

  # Check response 
  if echo $response | grep -q "\"response_code\": 1"; then
    echo "$pkg app scanned successfully" 
  else
    echo "Failed to scan $pkg"
  fi  

  # Cleanup 
  rm *.apk
done < apps.txt

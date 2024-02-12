#!/bin/bash

# Set SMS backup path on device
sms_backup_path=/sdcard/sms_backup

# Clear old SMS backups
adb shell "rm -rf $sms_backup_path"

# Create SMS backup directory 
adb shell "mkdir $sms_backup_path"

# Backup SMS database using content provider 
adb shell "content query --uri content://sms/ --projection _id:thread_id:address:person:date:protocol:read:status:type:reply_path:subject:body:service_center:locked:error_code > $sms_backup_path/sms_backup.csv"

# Pull SMS backup file from device
adb pull $sms_backup_path/sms_backup.csv ./sms_messages.csv

# Print confirmation
echo "SMS backup file pulled:" 
ls -l ./sms_messages.csv

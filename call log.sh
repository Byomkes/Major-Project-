#!/bin/bash

# Set call log path on device
call_log_path=/sdcard/call_logs

# Clear old call logs 
adb shell "rm -rf $call_log_path"

# Create call log directory
adb shell "mkdir $call_log_path"

# Pull call logs 
adb shell "cp /data/data/com.android.providers.contacts/databases/calllog.db $call_log_path/"

# Pull contacts database to map numbers 
adb shell "cp /data/data/com.android.providers.contacts/databases/contacts2.db $call_log_path/"

# Pull files from device 
adb pull $call_log_path ./call-logs

# Print log file info
echo "Pulled files:"   
ls -l call-logs

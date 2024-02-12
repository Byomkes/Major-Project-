#!/bin/bash

# Set calendar backup path on device 
calendar_path=/sdcard/calendar_backup

# Clear old calendar backups
adb shell "rm -rf $calendar_path"

# Create calendar backup directory
adb shell "mkdir $calendar_path"

# Backup calendar database
adb shell "cp /data/data/com.android.providers.calendar/databases/calendar.db $calendar_path/"

# Pull calendar database from device
adb pull $calendar_path/calendar.db ./calendar.db  

# Print confirmation
echo "Calendar database file pulled:" 
ls -l ./calendar.db

# Export calendars to CSV (optional)
sqlite3 calendar.db "select * from Calendars;" > calendars.csv 
sqlite3 calendar.db "select * from Events;" > events.csv

echo "Calendars and events exported to CSV:"
ls -l *.csv

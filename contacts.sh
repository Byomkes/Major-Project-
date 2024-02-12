#!/bin/bash

# Set contacts backup path on device
contacts_backup_path=/sdcard/contacts_backup

# Clear old contacts backups 
adb shell "rm -rf $contacts_backup_path"

# Create contacts backup directory
adb shell "mkdir $contacts_backup_path"

# Backup contacts database
adb shell "cp /data/data/com.android.providers.contacts/databases/contacts2.db $contacts_backup_path/"

# Pull contacts database file from device 
adb pull $contacts_backup_path/contacts2.db ./contacts.db

# Print confirmation 
echo "Contacts backup file pulled:"
ls -l ./contacts.db

# Export contacts to CSV (optional)
sqlite3 contacts.db "select * from view_contacts;" > contacts.csv
echo "Contacts exported to CSV file:" 
ls -l contacts.csv

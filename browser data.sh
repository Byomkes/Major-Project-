#!/bin/bash

# Set browser history backup path on device
browser_history_path=/sdcard/browser_history

# Clear old history backups 
adb shell "rm -rf $browser_history_path"

# Create browser history backup directory
adb shell "mkdir $browser_history_path"

# Backup Chrome browser history
adb shell "cp /data/data/com.android.chrome/app_chrome/Default/History $browser_history_path/chrome_history"

# Backup Firefox browser history
adb shell "cp /data/data/org.mozilla.firefox/files/mozilla/firefox/profile.default/places.sqlite $browser_history_path/firefox_history" 

# Pull browser history files from device
adb pull $browser_history_path ./browser_history

# Print confirmation
echo "Browser history files pulled:"
ls -l browser_history

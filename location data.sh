#!/bin/bash

# Set location backup path on device
location_path=/sdcard/location

# Clear old locations
adb shell "rm -rf $location_path" 

# Create location directory
adb shell "mkdir $location_path"

# Pull down various location databases
adb pull /data/system/location $location_path
adb pull /data/system/location/in progress $location_path
adb pull /data/system/location/successfully $location_path  

# Pull down modemsst1 database 
adb pull /data/system/modemst1 $location_path

# Pull fused location provider output
adb shell "logcat -d -v threadtime FusedLocationProvider:" > $location_path/fusedlocations.txt

# Pull location directory from device
adb pull $location_path ./location-data

# Print confirmation 
echo "Location data pulled:"
ls -l ./location-data

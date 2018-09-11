#!/bin/bash
LOGFILE="/var/log/clamav/clamav-$(date +'%Y-%m-%d').log";
DIRTOSCAN="/var/www /var/vmail";

for S in ${DIRTOSCAN}; do
 DIRSIZE=$(du -sh "$S" 2>/dev/null | cut -f1);

 echo "Starting a daily scan of "$S" directory.
 Amount of data to be scanned is "$DIRSIZE".";

 clamscan -ri "$S" >> "$LOGFILE";

 # get the value of "Infected lines"
 MALWARE=$(tail "$LOGFILE"|grep Infected|cut -d" " -f3);

#!/bin/bash

OUTPUT="/var/log/system_audit_$(date +%F_%T).log"

echo -e "\n--- Uptime ---" | tee -a "$OUTPUT"
uptime | tee -a "$OUTPUT"

echo -e "\n--- Disk Usage ---" | tee -a "$OUTPUT"
df -h | tee -a "$OUTPUT"

echo -e "\n--- Memory Usage ---" | tee -a "$OUTPUT"
free -h | tee -a "$OUTPUT"

echo -e "\n--- Last Logins ---" | tee -a "$OUTPUT"
last -a | head -10 | tee -a "$OUTPUT"

echo -e "\n--- Top Processes ---" | tee -a "$OUTPUT"
ps aux --sort=-%mem | head -10 | tee -a "$OUTPUT"

echo -e "\n--- Listening Ports ---" | tee -a "$OUTPUT"
ss -tuln | tee -a "$OUTPUT"

echo -e "\n--- Logged-in Users ---" | tee -a "$OUTPUT"
who | tee -a "$OUTPUT"

echo -e "\n--- Package Count ---" | tee -a "$OUTPUT"
dpkg -l | wc -l | tee -a "$OUTPUT"

echo -e "\n--- Sudo Users ---" | tee -a "$OUTPUT"
getent group sudo | cut -d: -f4 | tee -a "$OUTPUT"

#!/bin/bash

SERVICE="$1"
LOG="/var/log/service_monitor.log"
TIMESTAMP=$(date +%F_%T)

if [[ -z "$SERVICE" ]]; then
	echo "[$TIMESTAMP] ERROR: No service name provided." >> "$LOG"
	echo "Usage: $0 <service_name>"
	exit 1
fi

if systemctl is-active --quiet "$SERVICE"; then
	echo "[$TIMESTAMP] $SERVICE is running." >> "$LOG"
else
	echo "[$TIMESTAMP] $SERVICE is down! Restarting..." >> "$LOG"
	systemctl restart "$SERVICE"
	echo "[$TIMESTAMP] $SERVICE restarted." >> "$LOG"
fi

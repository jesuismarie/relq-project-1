#!/bin/bash

BACKUP_DIR="/PATH/TO/BACKUP/DIRECTORY"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
ENCRYPTED_NAME="$BACKUP_NAME.gpg"
KEY_ID="YOUR_GPG_KEY_ID"

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_DIR/$BACKUP_NAME" /etc/nginx /var/www

gpg --output "$BACKUP_DIR/$ENCRYPTED_NAME" --encrypt --recipient "$KEY_ID" "$BACKUP_DIR/$BACKUP_NAME"

rm "$BACKUP_DIR/$BACKUP_NAME"

find "$BACKUP_DIR" -type f -name "*.gpg" -mtime +7 -delete


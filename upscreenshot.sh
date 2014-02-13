#!/bin/bash

NAME=$(mktemp --dry-run XXXXX.jpg)
SITE="i.brod.es"
USER="aaron"
DIR="/var/www/images/$NAME"
PORT=22
DE="kde4"

convert $@ /tmp/$NAME

scp -P $PORT /tmp/$NAME $USER@$SITE:$DIR

rm /tmp/$NAME

URL="http://$SITE/$NAME"

if [$DE eq "kde4"]; then
  qdbus org.kde.klipper /klipper setClipboardContents "$URL"
  kdialog --passivepopup "Uploaded" 1
elif [$DE eq "xfce4"]; then


fi

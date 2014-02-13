#!/bin/bash

NAME=$(mktemp --dry-run XXXXX.png)
SITE="i.brod.es"
USER="aaron"
DIR="/var/www/images/$NAME"
URL="http://$SITE/$NAME"
PORT=22

if [ ! -z $1 ]; then
  convert $@ /tmp/$NAME
  out=`scp -P $PORT /tmp/$NAME $USER@$SITE:$DIR`
  rm /tmp/$NAME
  xsel < "$URL"
  if [ $out == 0 ]; then
    notify-send 'Uploaded and pasted into clipboard.' $URL --icon=dialog-information
  else
    notify-send 'Upload failed.' --icon=dialog-error
  fi
fi
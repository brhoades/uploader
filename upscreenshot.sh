#!/bin/bash

TEMPFILE=$(mktemp --tmpdir XXXXX.png)
NAME=$(basename "$TEMPFILE")
SITE="i.brod.es"
USER="aaron"
DIR="/var/www/images/$NAME"
URL="http://$SITE/$NAME"
PORT=22

if [ ! -z $1 ]; then
  convert $@ "$TEMPFILE"
  out=`scp -P $PORT "$TEMPFILE" $USER@$SITE:$DIR`
  rm "$TEMPFILE"
  xsel < "$URL"
  if [ $out == 0 ]; then
    notify-send 'Uploaded and pasted into clipboard.' $URL --icon=dialog-information
  else
    notify-send 'Upload failed.' --icon=dialog-error
  fi
fi

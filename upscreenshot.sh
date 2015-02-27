#!/bin/bash

TEMPFILE=$(mktemp --tmpdir XXXXX.png)
NAME=$(basename "$TEMPFILE")
SITE="i.brod.es"
USER="aaron"
DIR="/var/www/images/$NAME"
URL="http://$SITE/$NAME"
UMASK=775
PORT=22

sleep 0.1
escrotum $* "$TEMPFILE"
chmod $UMASK "$TEMPFILE"
scp -p -P $PORT "$TEMPFILE" $USER@$SITE:$DIR
if [[ $? == 0 ]]; then
  notify-send 'Uploaded and pasted into clipboard.' $URL --icon=dialog-information
  echo $URL | xsel --clipboard -i
else
  notify-send 'Upload failed.' --icon=dialog-error
fi
rm "$TEMPFILE"

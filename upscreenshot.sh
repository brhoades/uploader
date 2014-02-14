#!/bin/bash

TEMPFILE=$(mktemp --tmpdir XXXXX.png)
NAME=$(basename "$TEMPFILE")
SITE="i.brod.es"
USER="aaron"
DIR="/var/www/images/$NAME"
URL="http://$SITE/$NAME"
PORT=22

echo $URL | xsel --clipboard -i
scrot -z -q 80 $@ $TEMPFILE
scp -P $PORT "$TEMPFILE" $USER@$SITE:$DIR
rm $TEMPFILE
if [[ $? == 0 ]]; then
  notify-send 'Uploaded and pasted into clipboard.' $URL --icon=dialog-information
else
  notify-send 'Upload failed.' --icon=dialog-error
fi

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
escrotum "$TEMPFILE" $*
chmod $UMASK "$TEMPFILE"
notify-send 'On clipboard: ' $TEMPFILE --icon=dialog-information


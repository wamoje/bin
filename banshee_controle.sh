#!/bin/bash
MP3DIR=/home/wamoje/Dropbox/Public/Index
LASTLETTER=$(ls $MP3DIR/MP3_VO* | tail -1 | cut --characters=41)
LASTNUMBER=$(ls $MP3DIR/MP3_VO* | tail -1 | cut --characters=42-43)
WRKFILE=$(mktemp)
sqlite3 ~/.config/banshee-1/banshee.db "select Uri from CoreTracks" | cut --characters=39-41 | sort -u >$WRKFILE
for X in {L..Z}
do
  for N in {0..99}
  do
    ZOEK=$(printf "%s%02d" $X $N)
    if ! grep -q $ZOEK $WRKFILE
    then
      echo $ZOEK is missing
    fi
    if [[ $X == $LASTLETTER && $LASTNUMBER == $(printf "%02d" $N) ]]
    then
      break
    fi
  done
  echo $X checked
  if [[ $X == $LASTLETTER ]]
  then
    break
  fi
done
rm $WRKFILE

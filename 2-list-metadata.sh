#!/bin/bash

source ./.env

rm $DATES_FILE
touch $DATES_FILE
while read video_file; do
    utc_date=$(mediainfo "$video_file" | grep "Encoded date" | head -n1 | tr -s ' ' | cut -d ' ' -f 5-6 | sed  s/\ /\_/)
    echo "$video_file;$utc_date" >> $DATES_FILE

done < $LIST_FILE
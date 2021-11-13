#!/bin/bash

source ./.env



current_file_index=0

INPUT_FILE="$NAS_LIST_FILE"

if [ -n "$1" ] ; then
    INPUT_FILE="$1"
    
fi

echo "Using file : $INPUT_FILE"

size_of_file=$(cat "$INPUT_FILE" | wc -l)

rm $PROBLEMATIC_FILE

while read nas_video_file; do
    ((current_file_index=current_file_index+1))

    # Get filename without extension because some video are converted
    # file_name=$(basename "$nas_video_file" | cut -d. -f1)

    full_file_name=$("${nas_video_file#$SRC_PATH}" cut -d. -f -1)

    nb_of_match=$(cat $DATES_FILE | grep "$full_file_name\." | wc -l)

    echo "$current_file_index/$size_of_file - $full_file_name : $nb_of_match results found"

    if [ "$nb_of_match" -eq 1 ] ; then

        if [ "$(cat $FIXED_FILE | grep "$nas_video_file" | wc -l)" -eq 0 ] ; then

            original_date=$(cat $DATES_FILE | grep "$full_file_name" | head -n 1 | cut -d ';' -f 2)

            # utc_date=$(mediainfo "$nas_video_file" | grep "Encoded date" | head -n1 | tr -s ' ' | cut -d ' ' -f 5-6 | sed  s/\ /\_/)
            utc_date=$(exiftool -fast -AllDates "$nas_video_file"  | head -n1 | tr -s ' ' | cut -d ' ' -f 4-6)
            formatted_date=$(echo "$original_date" | sed s/-/:/g | sed s/\_/\ /g)

            if [ "$formatted_date" != "$utc_date" ] ; then 
                echo "  Will change date from $utc_date to $original_date ($formatted_date)"  

                exiftool -fast -AllDates="$formatted_date" -overwrite_original "$nas_video_file"
                echo "$nas_video_file" >> $FIXED_FILE
            else
                echo "  Will do nothing"
                echo "$nas_video_file" >> $FIXED_FILE
            fi

        else 
            echo "Skipped"

        fi

    else 

        echo "$nas_video_file" >> $PROBLEMATIC_FILE

    fi

    # Update the date
    # exiftool -AllDates="1998:12:12 06:00:00" -overwrite_original  YDXJ0081.MP4

    # utc_date=$(mediainfo "$video_file" | grep "Encoded date" | head -n1 | tr -s ' ' | cut -d ' ' -f 5-6 | sed  s/\ /\_/)
    # echo "$video_file;$utc_date" >> $DATES_FILE

done < $INPUT_FILE
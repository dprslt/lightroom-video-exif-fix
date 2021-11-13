#!/bin/bash


source ./.env

# Step 1 

# https://unix.stackexchange.com/questions/15308/how-to-use-find-command-to-search-for-multiple-extensions

find "$SRC_PATH" \
    -type f \
    \( \( -iname \*.mov -o -iname \*.mp4 \) -not \( -iwholename */export/* -o -iwholename *export* -o  -iwholename */Exp/* \) \) \
    | sort | uniq> $LIST_FILE


# MVI_2981-2
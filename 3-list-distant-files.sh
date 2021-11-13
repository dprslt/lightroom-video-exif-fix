#!/bin/bash


source ./.env

# Step 1 

# https://unix.stackexchange.com/questions/15308/how-to-use-find-command-to-search-for-multiple-extensions

find "$SRC_NAS_PATH" -type f \( \( -iname \*.mov -o -iname \*.mp4 \) -not -iwholename */@eaDir/* \) > $NAS_LIST_FILE

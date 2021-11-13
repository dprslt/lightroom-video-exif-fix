# Correct lightroom video date after export


[] Step 1 : List all video files
[] Step 2 : list metadata
[] Step 3 : found the good one for the timestamp
[] Step 4 : Build the database
[] Step 5 : Use Step 1 to found invalid video files on NAS
[] Step 6 : Recover info from DB with the filename
[] Step 7 : Update metadata

## Dependencies

```
sudo apt-get install mediainfo
sudo apt-get install libimage-exiftool-perl
```

## Config

Create a `.env` file with the following values

- `SRC_PATH` : Primary RAW files base tree
- `LIST_FILE` : name of the file containing all the movies
- `DATES_FILE` :name of the CSV file containing the tuples movies name / date
- `SRC_NAS_PATH` : export base tree
- `NAS_LIST_FILE` : name of the file containing all the exported movies
- `FIXED_FILE` : name of the file containing the fixed files path
- `PROBLEMATIC_FILE` : name of the file containing the problematic files path

```
SRC_PATH=
LIST_FILE=
DATES_FILE=
SRC_NAS_PATH=
NAS_LIST_FILE=
FIXED_FILE=
PROBLEMATIC_FILE=
```

## Usage

- write config
- run script in order
- check output

If working on a NAS, proccess ccan be slow, dates database can be build locally and then sent to the NAS where script `3` and `4` could be used.

## TODO

- Add a params to switch from `file_name` to `full_file_name` in script `4`
- concat script `1` and `3`
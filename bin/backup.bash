#!/bin/bash


##
## $1: LOCATION OF ALPHA                  ex: /home/q/alpha
## $2: LOCATION OF BACKUP                 ex: /media/q/Samsung_T5/backups
## $3: LOCATION OF USER HOME DIR          ex: /home/q
##


LOC=$1
BLOC=$2
BLS=$(echo $LOC/"data/backup.txt")  # the list of files/dirs to backup

DATE=$(date +%d_%m_%Y)
DIRNAME=$(echo "backup_"$DATE)


if [[ ! -d $BLOC ]]; then
  echo "Backup device is not connected..."
  exit 0;
elif [[ -d $BLOC/$DIRNAME ]]; then
  echo "Already did a backup today..."
  exit 0;  # TODO ask if we want to overwrite it
fi

mkdir $BLOC/$DIRNAME

while read L; do
  FULL_LOC=$(echo $USER"/"$L)
  FULL_BLOC=$( echo $BLOC"/"$DIRNAME"/"$L)
  if [[ -d $FULL_LOC ]]; then  # Directory
    cp -r $FULL_LOC $FULL_BLOC
    #echo $FULL_LOC $FULL_BLOC
  elif [[ -f $FULL_LOC ]]; then  # File
    cp $FULL_LOC $FULL_BLOC
    #echo $FULL_LOC $FULL_BLOC
  else
    echo "Couldn't find "$FULL_LOC
  fi
done <$BLS

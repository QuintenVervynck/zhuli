#!/bin/bash

# TODO: make this /home/alpha
LOC="/home/q/zhuli"
USER="/home/q"

if [[ $# -eq 0 ]];then
  echo "Nothing to do, goodbye! :)"
  exit 0;
fi


cd $LOC
# TODO make counters to know what is used the most often
case $1 in
  help)
    echo "options: [backup|install|les|notes]"
    ;;
  backup)
   bin/backup.bash $LOC "/media/q/Samsung_T5/backups" $USER
    ;;
  install)
    bin/install.bash ${@:2}
    ;;
  les)
    bin/les.bash
    ;;
  notes)
    bin/notes.bash ${@:2}
    ;;
  *)
    echo "Don't know what to do with this..."
    ;;
esac

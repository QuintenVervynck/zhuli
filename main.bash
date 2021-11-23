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
  help|h)
    echo "options: [backup|install|les|notes]"
    exit 0
    ;;
  backup|back|bup)
    bin/backup.bash $LOC "/media/q/Samsung_T5/backups" $USER
    exit 0
    ;;
  install|fix)
    bin/install.bash ${@:2}
    exit 0
    ;;
  les)
    bin/les.bash
    exit 0
    ;;
  notes|todo|note|n)
    bin/notes.bash ${@:2}
    exit 0
    ;;
  *)
    echo "Don't know what to do with this..."
    ;;
esac

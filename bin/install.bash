#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "Don't know what you want me to install / setup ..."
  exit 0
fi

case $1 in
  update)
    sudo apt update
    sudo apt upgrade
    ;;
  zhuli-data)
    #echo $(pwd)
    mkdir data data/notes
    touch data/backup.txt data/les.txt data/notes/example_note

    echo "-----My first todo list!-----" >> data/notes/example_note
    echo "My first todo item -----" >> data/notes/example_note

    echo ".bashrc" >> data/backup.txt
    echo ".bash_aliases" >> data/backup.txt

    echo "MONDAY" >> data/les.txt
    echo "10:00-13:00 Maths" >> data/les.txt
    # TODO make user set /home/...
    ;;
  ssh)
    echo "leave everything empty and just press enter"
    ssh-keygen
    ;;
  google-chrome)
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    ;;
  github)
    sudo apt install git
    git config --global user.email "vervynck.quinten@gmail.com"
    git config --global user.name "Quinten Vervynck"
    clear
    echo "add the ssh-key in ~/.ssh to your github profile (https://github.com/settings/keys)"
    echo "   I'll show him under here"
    echo "----------------------------------------"
    cat ~/.ssh/~/.ssh/id_rsa.pub
    echo "----------------------------------------"
    echo "hit enter when ready"
    read READY
    ;;
  regolith)
    sudo add-apt-repository ppa:regolith-linux/release
    sudo apt install regolith-desktop-mobile
    # show terminal on startup
    echo " " >> /etc/regolith/i3/config
    echo "# Show terminal on startup" >> /etc/regolith/i3/config
    echo "exec gnome-terminal" >> /etc/regolith/i3/config
    ;;
  *)
    echo "Not in install / setup list ..."
    ;;
esac

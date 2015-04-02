#!/bin/bash
# pcp.sh: A shell script to copy /bin/* and /etc/* files
#         Display a progress bar while copying files.  
# * Based upon Greg's (GreyCat's) GPLd wiki example. *
# --------------------------------------------------------
# Create an array of all files in /etc and /bin directory

DIALOG=`which dialog`
if [ -z $DIALOG ]; then echo dialog not found.  dialog is required to run this script - try sudo apt-get install dialog for Ubuntu or Debian systems.; exit 1; fi

DIRS=(./.*)
 
# Destination directory
DEST="../"
 
# Create $DEST if does not exits
[ ! -d $DEST ] && mkdir -p $DEST
 
#
# Show a progress bar
# ---------------------------------
# Redirect dialog commands input using substitution
#
dialog --title "Copy file" --backtitle "Matt's dotfiles installation script" --gauge "Copying file..." 10 75 < <(
   # Get total number of files in array
   n=${#DIRS[*]}; 
 
   # set counter - it will increase every-time a file is copied to $DEST
   i=0
 
   #
   # Start the for loop 
   #
   # read each file from $DIRS array 
   # $f has filename 
   for f in "${DIRS[@]}"
   do
      # calculate progress
      PCT=$(( 100*(++i)/n ))
 
      # update dialog box 
cat <<EOF
XXX
$PCT
Copying file "$f"...
XXX
EOF
  # copy file $f to $DEST 
  /bin/cp $f ${DEST} &>/dev/null
   done
)
 


dialog --backtitle "Matt's dotfiles installation script" --infobox "Installing directories..." 3 34  
cp -R .oh-my-zsh ../
cp -R .task ../
cp -R .tin ../
cp -R .tmux-powerline ../
cp -R .vifm ../
cp -R .vim ../

dialog --title "Installation Complete." --msgbox "dotfiles installation completed!" 6 50

clear

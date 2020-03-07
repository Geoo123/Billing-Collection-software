#!/bin/bash
#echo "You are going to uninstall NOTOMYS. Are you sure? Type 'yes' or 'no'"
#zenity --warning --width=230 --height=100 --text "You are going to uninstall NOTOMYS!" 2> /dev/null
zenity --question --width=230 --height=100 --text "You are going to uninstall NOTOMYS. Are you sure?" 2>/dev/null; line=$?
#while read line
 #   do
  #      i=1
        if [ $line == 1 ];
                then
                        i=0
                        zenity --info --width=230 --height=100 --text "You have just canceled uninstalling process!" 2> /dev/null
			#echo "You have just canceled uninstalling process!"
        else
                        echo "Uninstalling..."
                        echo "Please wait a few moments..."
                        sudo rm /usr/bin/fast.sh
                        sudo rm /usr/share/icons/notomys.png
                        sudo chattr -a /usr/bin/dndelete.txt
                        sudo rm /usr/bin/dndelete.txt
                        sudo rm /usr/share/applications/notomys.desktop
                        sudo rm /home/$USER/Desktop/notomys.desktop
                        sudo rm /usr/share/icons/uninstall_notomys.png
                        sudo rm /usr/share/applications/uninstall_notomys.desktop
                        sudo rm /home/$USER/Desktop/uninstall_notomys.desktop
                        sudo rm /usr/bin/uninstall_notomys.sh
                        sudo rm /home/$USER/.mailrc
			zenity --info --width=230 --height=100 --text "NOTOMYS was uninstalled successfully!" 2> /dev/null
			zenity --info --timeout 4 --width=230 --height=100 --text "Thank you for choosing NOTOMYS!" 2> /dev/null
       fi

#!/bin/bash
if [ -e /home/$USER/.mailrc ]
then
	zenity --question --width=230 --height=100 --text "A new version of NOTOMYS is now available! Do you want to replace the old version with the new one?" 2>/dev/null; line=$?
	if [ $line == 1 ]; then
	zenity --warning --width=230 --height=100 --text "NOTOMYS was not updated!" 2>/dev/null
	else
	if [ $line == 0 ]; then
		    sudo rm /usr/share/icons/uninstall_notomys.png
		    sudo rm /usr/bin/fast.sh
		    sudo rm /usr/share/applications/notomys.desktop
		    sudo cp $PWD/fast.sh /usr/bin/fast.sh
		    sudo cp $PWD/notomys.png /usr/share/icons/notomys.png
		    sudo cp $PWD/uninstall_notomys.png /usr/share/icons/uninstall_notomys.png
		    sudo touch $PWD/temp.txt
		    sudo chmod 777 temp.txt
		    sudo echo "#!/usr/bin/env xdg-open" >> $PWD/temp.txt
		    sudo echo "[Desktop Entry]" >> $PWD/temp.txt
		    sudo echo "Type=Application" >> $PWD/temp.txt
		    sudo echo "Name=Notomys" >> $PWD/temp.txt
		    sudo echo "Exec=/usr/bin/fast.sh" >> $PWD/temp.txt
		    sudo echo "Icon=/usr/share/icons/notomys.png" >> $PWD/temp.txt
		    sudo echo "Terminal=true" >> $PWD/temp.txt

		    sudo mv $PWD/temp.txt $PWD/notomys.desktop
		    sudo mv $PWD/notomys.desktop /usr/share/applications/
		    sudo rm /home/$USER/.mailrc
		    sudo cp $PWD/config.txt /home/$USER/config.txt
		    sudo mv /home/$USER/config.txt /home/$USER/.mailrc
		    zenity --info --width=230 --height=100 --text "NOTOMYS was updated successfully!" 2> /dev/null
	    	    sudo chown $USER:$USER /home/$USER/Desktop/uninstall_notomys.desktop
            	    sudo chown $USER:$USER /home/$USER/Desktop/notomys.desktop
                    sudo chmod 777 /home/$USER/Desktop/uninstall_notomys.desktop
                    sudo chmod 777 /home/$USER/Desktop/notomys.desktop
	    fi
	fi
else
    	zenity --info --width=230 --height=100 --text "NOTOMYS is not installed on this device! Please install it and update it later!" 2> /dev/null
fi



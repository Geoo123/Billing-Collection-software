#!/bin/bash

if [ -e /usr/bin/dndelete.txt ]; then
zenity --info --width=230 --height=100 --text "NOTOMYS is already installed!" 2> /dev/null
else
	mkdir -p /home/$USER/Desktop/CNSB
	mkdir -p /home/$USER/Desktop/CNSB/BUILDINGS
	mkdir -p /home/$USER/Desktop/CNSB/BUILDINGS/a
	sudo cp $PWD/fast.sh /usr/bin/fast.sh
	sudo cp $PWD/notomys.png /usr/share/icons/notomys.png
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

	sudo cp $PWD/"How to use Notomys.pdf" /home/$USER/Desktop/CNSB/BUILDINGS/a/"How to use Notomys.pdf"
	sudo chmod 777 /home/$USER/Desktop/CNSB/BUILDINGS/a/"How to use Notomys.pdf"
	sudo chattr +a /home/$USER/Desktop/CNSB/BUILDINGS/a/"How to use Notomys.pdf"
		
	sudo cp $PWD/uninstall_notomys.sh /usr/bin/uninstall_notomys.sh
	sudo cp $PWD/uninstall_notomys.png /usr/share/icons/uninstall_notomys.png
	sudo touch $PWD/tempa.txt
	sudo chmod 777 tempa.txt
	sudo echo "#!/usr/bin/env xdg-open" >> $PWD/tempa.txt
	sudo echo "[Desktop Entry]" >> $PWD/tempa.txt
	sudo echo "Type=Application" >> $PWD/tempa.txt
	sudo echo "Name=Uninstall_Notomys" >> $PWD/tempa.txt
	sudo echo "Exec=/usr/bin/uninstall_notomys.sh" >> $PWD/tempa.txt
	sudo echo "Icon=/usr/share/icons/uninstall_notomys.png" >> $PWD/tempa.txt
	sudo echo "Terminal=true" >> $PWD/tempa.txt

	sudo mv $PWD/tempa.txt $PWD/uninstall_notomys.desktop
	sudo mv $PWD/uninstall_notomys.desktop /usr/share/applications/

	sudo cp /usr/share/applications/notomys.desktop /home/$USER/Desktop/
	sudo cp /usr/share/applications/uninstall_notomys.desktop /home/$USER/Desktop/
	zenity --warning --width=230 --height=100 --text "Choose a pasword for NOTOMYS!" 2> /dev/null
	PASS1=""
	PASS2=""
	while [ "$PASS1" == "" ]; do
		PASS1=$(zenity --password 2> /dev/null)
		if [[ "$PASS1" == "" ]]; then
			zenity --warning --width=230 --height=100 --text "No password typed!" 2> /dev/null
		fi
	done
	zenity --info --width=230 --height=100 --text "Retype password" 2> /dev/null
	while [ "$PASS1" != "$PASS2" ]; do
	PASS2=$(zenity --password 2> /dev/null)
	if [[ "$PASS2" == "" ]]; then
		zenity --warning --width=230 --height=100 --text "No password typed!" 2> /dev/null
	fi
	if [[ "$PASS1" != "$PASS2" ]]; then

		zenity --warning --width=230 --height=100 --text "Passwords are not the same! Try again!" 2> /dev/null
	fi
	done
	if [[ "$PASS1" == "$PASS2" ]]; then
		zenity --info --width=230 --height=100 --text "You set a new password!" 2> /dev/null
	fi
	sudo echo $PASS1 > dndelete.txt
	sudo mv dndelete.txt /usr/bin/dndelete.txt
	sudo chattr +a /usr/bin/dndelete.txt
	sudo apt-get install s-nail
	sudo apt install xlsx2csv
	sudo snap install pdftk
	if [ -e /home/$USER/.mailrc ]
	then
	    echo "Configuration file exists!"
	else
	     echo "Configuration file does not exist!"
	     echo "Adding configuration file..."
	     sudo cp $PWD/config.txt /home/$USER/config.txt
	     sudo mv /home/$USER/config.txt /home/$USER/.mailrc
	     echo "Complete!"
	     zenity --info --width=230 --height=100 --text "Installation complete! Thank you for choosing NOTOMYS!" 2> /dev/null
	     sudo chown $USER:$USER /home/$USER/Desktop/uninstall_notomys.desktop
	     sudo chown $USER:$USER /home/$USER/Desktop/notomys.desktop
	     sudo chmod 777 /home/$USER/Desktop/uninstall_notomys.desktop
	     sudo chmod 777 /home/$USER/Desktop/notomys.desktop
     	fi
	
fi
